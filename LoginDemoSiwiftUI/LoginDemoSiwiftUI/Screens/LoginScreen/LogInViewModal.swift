//
//  LogInViewModal.swift
//  LoginDemoSiwiftUI
//
//  Created by MACM18 on 12/05/25.
//

import Foundation
import Combine

class LogInViewModal:ObservableObject {
    @Published var emailAddress:String = ""
    @Published var password:String = ""
    @Published var errorEmailAddress = ""
    @Published var errorPassword = ""
    @Published var isEanbleButton = false
    @Published var logInErrorTitle = ""
    @Published var logINErrorMessage = ""
    @Published var showErrorAlert = false

    private var cancellables = Set<AnyCancellable>()
    
    init() {
        setupValidation()
    }
    
    
    func validateAll() -> Bool {
        var isValid = true
        let trimmedEmail = emailAddress.trimmingCharacters(in: .whitespacesAndNewlines)
        if trimmedEmail.isEmpty {
            errorEmailAddress = StringConsatnts.emailEmptyError
            isValid = false
        } else if !trimmedEmail.isValidEmail {
            errorEmailAddress = StringConsatnts.invalidEmailError
            isValid = false
        } else {
            errorEmailAddress = ""
        }
        
        let trimmedPassword = password.trimmingCharacters(in: .whitespacesAndNewlines)
        if trimmedPassword.isEmpty {
            errorPassword = StringConsatnts.passwordEmptyError
            isValid = false
        } else if !trimmedPassword.isValidPassword {
            errorPassword = StringConsatnts.invalidPasswordError
            isValid = false
        } else {
            errorPassword = ""
        }
        return isValid
    }
    
    
    private func setupValidation() {
        Publishers.CombineLatest($emailAddress,$password)
            .dropFirst()
            .sink { [weak self] _,_ in
                self?.isEanbleButton = self?.validateAll() ?? false
            }
            .store(in: &cancellables)
    }
    
    
    
    func login() {
        let endpoint = UserAPI.login(email: emailAddress, password: password)
        Task {
            do {
                let response = try await NetworkManager.shared.request(
                    endpoint: endpoint,
                    responseType: LoginResponse.self
                )
                await MainActor.run {
                    print("accessToken==>" + response.accessToken)
                }
            } catch let error as APIError {
                await MainActor.run {
                    switch error {
                    case .server(let code, let message):
                        self.logInErrorTitle = "\(StringConsatnts.serverError) \(code):"
                        if code == 401 {
                            self.logINErrorMessage = StringConsatnts.invalidCredentials
                        } else {
                            self.logINErrorMessage = message ?? StringConsatnts.defultError

                        }
                    case .network(let err):
                        self.logInErrorTitle = StringConsatnts.networkError
                        self.logINErrorMessage = err.localizedDescription
                    case .decoding(let err):
                        self.logInErrorTitle = StringConsatnts.parsingError
                        self.logINErrorMessage = err.localizedDescription
                    case .unknown:
                        break
                    }
                    self.showErrorAlert = true
                }
            } catch {
                await MainActor.run {
                    self.logInErrorTitle = StringConsatnts.unexpectedError
                    self.logINErrorMessage = error.localizedDescription
                    self.showErrorAlert = true
                }
            }
        }
        
    }
    
}
