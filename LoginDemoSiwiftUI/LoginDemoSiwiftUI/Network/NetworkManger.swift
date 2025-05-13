//
//  NetworkManger.swift
//  LoginDemoSiwiftUI
//
//  Created by MACM18 on 13/05/25.
//

import Alamofire
import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func request<T: Decodable>(
        endpoint: APIEndpoint,
        responseType: T.Type,
        completion: @escaping (Result<T, APIError>) -> Void
    ) {
        let url = endpoint.baseURL + endpoint.path
        
        AF.request(
            url,
            method: HTTPMethod(rawValue: endpoint.method.rawValue),
            parameters: endpoint.parameters,
            encoding: endpoint.encoding,
            headers: endpoint.headers
        )
        .validate()
        .responseData { response in
            let statusCode = response.response?.statusCode ?? -1
            
            switch response.result {
            case .success(let data):
                if (200..<300).contains(statusCode) {
                    do {
                        let decoded = try JSONDecoder().decode(T.self, from: data)
                        completion(.success(decoded))
                    } catch {
                        completion(.failure(.decoding(error)))
                    }
                } else {
                      let serverMessage = try? JSONDecoder().decode(ServerErrorResponse.self, from: data)
                    let message = serverMessage?.message.joined(separator: "\n") ?? serverMessage?.error
                    completion(.failure(.server(code: statusCode, message: message)))
                }
                
            case .failure(let afError):
                if let data = response.data {
                    let serverMessage = try? JSONDecoder().decode(ServerErrorResponse.self, from: data)
                    let message = serverMessage?.message.joined(separator: "\n") ?? serverMessage?.error
                    completion(.failure(.server(code: statusCode, message: message)))
                } else {
                    completion(.failure(.network(afError)))
                }
            }
        }
    }
}
