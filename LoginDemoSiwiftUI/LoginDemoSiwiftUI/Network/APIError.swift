//
//  Untitled.swift
//  LoginDemoSiwiftUI
//
//  Created by MACM18 on 13/05/25.
//

enum APIError: Error {
    case network(Error)
    case server(code: Int, message: String?)
    case decoding(Error)
    case unknown
}

struct ServerErrorResponse: Decodable {
    let message: [String]
    let error: String
    let statusCode: Int
}
