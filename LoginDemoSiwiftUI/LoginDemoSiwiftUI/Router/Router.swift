//
//  Router.swift
//  LoginDemoSiwiftUI
//
//  Created by MACM18 on 13/05/25.
//
import SwiftUI

class Router: ObservableObject {
    @Published var path: [AppRoute] = []

    func push(_ route: AppRoute) {
        path.append(route)
    }

    func pop() {
        _ = path.popLast()
    }

    func reset(to route: AppRoute) {
        path = [route]
    }
}
