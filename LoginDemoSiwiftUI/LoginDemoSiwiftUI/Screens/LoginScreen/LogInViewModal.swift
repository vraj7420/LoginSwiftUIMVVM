//
//  LogInViewModal.swift
//  LoginDemoSiwiftUI
//
//  Created by MACM18 on 12/05/25.
//

import Foundation

class LogInViewModal:ObservableObject {
    @Published var emailAddress:String = "Test@yopmail.com"
    @Published var password:String = "Test"
    
    func login() {
        let endpoint = UserAPI.login(email: emailAddress, password: password)
        NetworkManager.shared.request(endpoint: endpoint, responseType:LoginResponse.self){ result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    print("accessToken==>"+response.accessToken)
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
