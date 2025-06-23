//
//  NetworkManger.swift
//  LoginDemoSiwiftUI
//
//  Created by MACM18 on 13/05/25.
//

import Alamofire
import Foundation

protocol NetworkManagerProtocol {
    func request<T: Decodable>(endpoint: APIEndpoint, responseType: T.Type) async throws -> T
}

class NetworkManager: NetworkManagerProtocol{
    static let shared = NetworkManager()
    
    private init() {}
    
    func request<T: Decodable>(
        endpoint: APIEndpoint,
        responseType: T.Type
    ) async throws -> T {
        let url = endpoint.baseURL + endpoint.path
        let request = AF.request(
            url,
            method: HTTPMethod(rawValue: endpoint.method.rawValue),
            parameters: endpoint.parameters,
            encoding: endpoint.encoding,
            headers: endpoint.headers
        )
        
        let response = try await request.serializingData().response
        
        let statusCode = response.response?.statusCode ?? -1
        
        switch response.result {
        case .success(let data):
            if (200..<300).contains(statusCode) {
                do {
                    let decoded = try JSONDecoder().decode(T.self, from: data)
                    return decoded
                } catch {
                    throw APIError.decoding(error)
                }
            } else {
                // Decode server error message
                let serverMessage = try? JSONDecoder().decode(ServerErrorResponse.self, from: data)
                let message = serverMessage?.message.joined(separator: "\n") ?? serverMessage?.error
                throw APIError.server(code: statusCode, message: message)
            }
            
        case .failure(let afError):
            if let data = response.data {
                let serverMessage = try? JSONDecoder().decode(ServerErrorResponse.self, from: data)
                let message = serverMessage?.message.joined(separator: "\n") ?? serverMessage?.error
                throw APIError.server(code: statusCode, message: message)
            } else {
                throw APIError.network(afError)
            }
        }
    }
}
