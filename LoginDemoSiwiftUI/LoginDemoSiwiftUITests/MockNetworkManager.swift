//
//  MockNetworkManager.swift
//  LoginDemoSiwiftUI
//
//  Created by Vraj on 20/06/25.
//
import SwiftUI
@testable import LoginDemoSiwiftUI


class MockNetworkManager: NetworkManagerProtocol {
    var shouldReturnError = false
    var mockError: APIError = .unknown
    var mockResponse: Any?

    func request<T: Decodable>(endpoint: APIEndpoint, responseType: T.Type) async throws -> T {
        if shouldReturnError {
            throw mockError // ✅ Must be APIError
        }
        guard let response = mockResponse as? T else {
            throw APIError.decoding(NSError(domain: "mock", code: 0))
        }
        return response
    }
}


