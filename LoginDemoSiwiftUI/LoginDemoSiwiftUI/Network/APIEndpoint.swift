//
//  APIEndpoint.swift
//  LoginDemoSiwiftUI
//
//  Created by MACM18 on 13/05/25.
//
import Alamofire

protocol APIEndpoint {
    var baseURL: String { get }
    var path: String { get }
    var method: HTTPMethodType { get }
    var headers: HTTPHeaders? { get }
    var parameters: [String: Any]? { get }
    var encoding: ParameterEncoding { get }
}
