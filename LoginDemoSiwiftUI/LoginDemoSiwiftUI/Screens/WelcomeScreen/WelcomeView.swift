//
//  WelcomeView.swift
//  LoginDemoSiwiftUI
//
//  Created by MACM18 on 12/05/25.
//

import SwiftUI

struct WelcomeView: View {
    @EnvironmentObject var router: Router

    var body: some View {
        VStack(spacing: 30) {
            CurveView()
                .fill(
                    LinearGradient(
                        gradient: Gradient(colors: [Color.orange, Color.red]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(height: 150)
                .edgesIgnoringSafeArea(.top)
            Spacer()
            VStack {
                VStack(alignment: .leading,spacing: 12) {
                    Text("Join a community of creators")
                        .font(.system(size: 40, weight: .bold))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity,alignment: .leading)
                    
                    Text("A simple, fun, and creative way to share photos, videos, messages with friends and family")
                        .font(.system(size: 20,weight: .medium))
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.leading)
                }
                Spacer()
                VStack(spacing: 15) {
                    CustomButton(
                        title: "Sign Up",
                        textColor: .white,
                        background: Color(.darkGray)){
                            router.push(.signUp)
                        }
                
                    CustomButton(
                        title: "Sign In",
                        textColor: .white,
                        background: LinearGradient(
                            gradient: Gradient(colors: [Color.orange, Color.red]),
                            startPoint: .leading,
                            endPoint: .trailing
                        )) {
                            router.push(.logIn)
                        }
                    
                }
            }
            .padding(.horizontal, 30)
            Spacer()
        }
        .background(Color.black.edgesIgnoringSafeArea(.all))
    }
    
}


#Preview {
    WelcomeView()
}
