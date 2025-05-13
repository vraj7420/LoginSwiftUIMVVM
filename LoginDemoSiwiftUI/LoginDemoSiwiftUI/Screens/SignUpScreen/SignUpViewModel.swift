//
//  SignUpViewModel.swift
//  LoginDemoSiwiftUI
//
//  Created by MACM18 on 12/05/25.
//

import Foundation

class SignUpViewModel:ObservableObject {
    
    @Published var emailAddress:String = "Test@yopmail.com"
    @Published var name:String = "Test"
    @Published var password:String = "Test"
    
    func signUp () {
        let endpoint = UserAPI.signUp(signUp: .init(name: name, email: emailAddress, password: password, avatar: ""))
        
        NetworkManager.shared.request(endpoint: endpoint, responseType: SignUpResponse.self) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    print(response.id)
                case .failure(let error):
                    switch error {
                    case .server(let code, let message):
                        print("Server error \(code):", message ?? "No message")
                    case .network(let err):
                        print("Network error:", err.localizedDescription)
                    case .decoding(let err):
                        print("Parsing error:", err)
                    case .unknown:
                        print("Unknown error")
                    }
                }
            }
        }
    }
    
}
