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

    private let networkManager: NetworkManagerProtocol
    private var cancellables = Set<AnyCancellable>()
    
    init(networkManager: NetworkManagerProtocol = NetworkManager.shared) {
           self.networkManager = networkManager
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
            .receive(on: RunLoop.main)
            .dropFirst()
            .sink { [weak self] _,_ in
                self?.isEanbleButton = self?.validateAll() ?? false
            }
            .store(in: &cancellables)
    }
    
    
    @MainActor
    func login() async {
        let endpoint = UserAPI.login(email: emailAddress, password: password)
        do {
            let response = try await networkManager.request(
                endpoint: endpoint,
                responseType: LoginResponse.self
            )
            print("accessToken ==> \(response.accessToken)")
        } catch let error as APIError {
            switch error {
            case .server(let code, let message):
                self.logInErrorTitle = "\(StringConsatnts.serverError) \(code):"
                self.logINErrorMessage = (code == 401)
                    ? StringConsatnts.invalidCredentials
                    : message ?? StringConsatnts.defultError
            case .network(let err):
                self.logInErrorTitle = StringConsatnts.networkError
                self.logINErrorMessage = err.localizedDescription
            case .decoding(let err):
                self.logInErrorTitle = StringConsatnts.parsingError
                self.logINErrorMessage = err.localizedDescription
            case .unknown:
                self.logInErrorTitle = StringConsatnts.unexpectedError
                self.logINErrorMessage = StringConsatnts.defultError
            }
            self.showErrorAlert = true
        } catch {
            self.logInErrorTitle = StringConsatnts.unexpectedError
            self.logINErrorMessage = error.localizedDescription
            self.showErrorAlert = true
        }
    }

    
}
