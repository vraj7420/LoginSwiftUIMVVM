//
//  UserAPI.swift
//  LoginDemoSiwiftUI
//
//  Created by MACM18 on 13/05/25.
//
import Foundation
import Alamofire

enum UserAPI: APIEndpoint {
    case login(email: String, password: String)
    case getProfile(userId: String)
    case signUp(signUp:SignUpRequest)

    var baseURL: String {
        return "https://api.escuelajs.co/api/v1"
    }

    var path: String {
        switch self {
        case .login:
            return "/auth/login"
        case .getProfile(let userId):
            return "/users/\(userId)"
        case .signUp:
            return "/users"
        }
    }

    var method: HTTPMethodType {
        switch self {
        case .login,.signUp: return .post
        case .getProfile: return .get
        }
    }

    var headers: HTTPHeaders? {
        return ["Content-Type": ContentType.json.rawValue]
    }

    var parameters: [String : Any]? {
        switch self {
        case .login(let email, let password):
            return ["email": email, "password": password]
        case .getProfile:
            return nil
        case .signUp(signUp: let signUp):
            return [
                "email": signUp.email,
                "password": signUp.password,
                "name":signUp.name,
                "avatar": signUp.avatar
            ]
        }
    }

    var encoding: ParameterEncoding {
        switch self.method {
        case .get:
            return URLEncoding.default
        default:
            return JSONEncoding.default
        }
    }
}
