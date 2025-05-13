//
//  RouteViewBuilder.swift
//  LoginDemoSiwiftUI
//
//  Created by MACM18 on 13/05/25.
//

import SwiftUI

struct RouteViewBuilder: View {
    let route: AppRoute
    @EnvironmentObject var router: Router
    
    var body: some View {
        switch route {
        case .welcome:
            WelcomeView()
        case .logIn:
            LogInView()
                .navigationBarBackButtonHidden(true)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: {
                            router.pop()
                        }) {
                            Image(systemName: "chevron.left")
                                .foregroundColor(.gray)
                        }
                    }
                }
        case .signUp:
            SignUpView()
                .navigationBarBackButtonHidden(true)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: {
                            router.pop()
                        }) {
                            Image(systemName: "chevron.left")
                                .foregroundColor(.gray)
                        }
                    }
                }
        }
    }
}
