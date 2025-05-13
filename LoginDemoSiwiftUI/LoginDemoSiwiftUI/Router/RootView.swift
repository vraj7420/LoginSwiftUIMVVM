//
//  RootView.swift
//  LoginDemoSiwiftUI
//
//  Created by MACM18 on 13/05/25.
//
import SwiftUI
    
struct RootView: View {
    @StateObject var router = Router()

    var body: some View {
        NavigationStack(path: $router.path) {
            WelcomeView()
                .navigationDestination(for: AppRoute.self) { route in
                    RouteViewBuilder(route: route)
                }
        }
        .environmentObject(router)
    }
}
