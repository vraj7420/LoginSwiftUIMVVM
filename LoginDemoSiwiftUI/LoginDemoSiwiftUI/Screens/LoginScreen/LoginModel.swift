//
//  LoginModel.swift
//  LoginDemoSiwiftUI
//
//  Created by MACM18 on 13/05/25.
//

struct LoginRequest: Codable {
    let email, password: String
}

struct LoginResponse: Codable {
    let accessToken, refreshToken: String
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case refreshToken = "refresh_token"
    }
}
