//
//  SignUpModel.swift
//  LoginDemoSiwiftUI
//
//  Created by MACM18 on 13/05/25.
//

import Foundation

struct SignUpResponse: Codable {
    let email, password, name: String
    let avatar: String
    let role: String
    let id: Int
}

struct SignUpRequest: Codable {
    let name, email, password: String
    let avatar: String
}
