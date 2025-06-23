//
//  SignUpViewModel.swift
//  LoginDemoSiwiftUI
//
//  Created by MACM18 on 12/05/25.
//

import Foundation
import Combine

class SignUpViewModel:ObservableObject {
    
    @Published var emailAddress:String = ""
    @Published var name:String = ""
    @Published var password:String = ""
    @Published var errorEmailAddress = ""
    @Published var errorName = ""
    @Published var errorPassword = ""
    @Published var isEanbleButton = false
    @Published var showErrorAlert = false
    @Published var signUPErrorTitle = ""
    @Published var signUPErrorMessage = ""
    
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
        
        let trimmedName = name.trimmingCharacters(in: .whitespacesAndNewlines)
        if trimmedName.isEmpty {
            errorName = StringConsatnts.invalidNameError
            isValid = false
        } else {
            errorName = ""
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
        Publishers.CombineLatest3($emailAddress, $name, $password)
            .receive(on: RunLoop.main)
            .dropFirst()
            .sink { [weak self] _, _, _ in
                self?.isEanbleButton = self?.validateAll() ?? false
            }
            .store(in: &cancellables)
    }
    
    @MainActor
    func signUp() async {
        let endpoint = UserAPI.signUp(signUp: .init(name: name, email: emailAddress, password: password, avatar: "https://i.imgur.com/LDOO4Qs.jpg"))
        Task {
            do {
                let response = try await networkManager.request(
                    endpoint: endpoint,
                    responseType: SignUpResponse.self
                )
                print(response.id) // Already on MainActor
            } catch let error as APIError {
                switch error {
                case .server(let code, let message):
                    self.signUPErrorTitle = "\(StringConsatnts.serverError) \(code):"
                    self.signUPErrorMessage = message ?? StringConsatnts.defultError
                case .network(let err):
                    self.signUPErrorTitle = StringConsatnts.networkError
                    self.signUPErrorMessage = err.localizedDescription
                case .decoding(let err):
                    self.signUPErrorTitle = StringConsatnts.parsingError
                    self.signUPErrorMessage = err.localizedDescription
                case .unknown:
                    self.signUPErrorTitle = StringConsatnts.unexpectedError
                    self.signUPErrorMessage = StringConsatnts.defultError
                }
                self.showErrorAlert = true
            } catch {
                self.signUPErrorTitle = StringConsatnts.unexpectedError
                self.signUPErrorMessage = error.localizedDescription
                self.showErrorAlert = true
            }
        }
    }
    
}
