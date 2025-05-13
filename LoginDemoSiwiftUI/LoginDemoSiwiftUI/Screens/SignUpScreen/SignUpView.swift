//
//  SignUpView.swift
//  LoginDemoSiwiftUI
//
//  Created by MACM18 on 12/05/25.
//

import SwiftUI

struct SignUpView: View {
    @ObservedObject var viewModel = SignUpViewModel()
    var body: some View {
        VStack{
            Text("Sign up to see photos and videos from your friends.")
                .font(.system(size: 26,weight: .bold))
                .foregroundColor(.gray)
                .multilineTextAlignment(.leading)
                .padding(.trailing,50)
            VStack{
                ULTextFieldView(text: $viewModel.emailAddress,placeholder: "Email", keyboardType: .emailAddress)
                ULTextFieldView(text: $viewModel.name,placeholder: "Name")
                ULTextFieldView(text: $viewModel.password,placeholder: "Passwod")
            }.padding(.vertical,40)
            VStack(alignment: .leading) {
                CustomButton(
                    title: "Sign Up",
                    textColor: .white,
                    background: LinearGradient(
                        gradient: Gradient(colors: [Color.orange, Color.red]),
                        startPoint: .leading,
                        endPoint: .trailing
                    )) {
                        viewModel.signUp()
                    }
                Text("Or sign up with another account.")
                    .font(.system(size: 25,weight: .bold))
                    .foregroundColor(.gray)
                socialLogIn
                    .padding(.trailing,100)
            }
            
            
            
        }
        .padding(.horizontal,30)
        .frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .center)
        .background(Color.black.edgesIgnoringSafeArea(.all))
        
    }
    
    var socialLogIn:some View {
        HStack {
            Button(action: {
                print("Facebook Login tapped")
            }) {
                Image("facebookLogo")
                    .resizable()
                    .frame(width: 50,height: 50)
            }
            Spacer()
            Button(action: {
                print("Twitter Login tapped")
            }) {
                Image("twiteerLogo")
                    .resizable()
                    .frame(width: 50,height: 50)
            }
            Spacer()
            Button(action: {
                print("Google Login tapped")
            }) {
                Image("googleLogo")
                    .resizable()
                    .frame(width: 50,height: 50)
            }
        }
    }
}

#Preview {
    SignUpView()
}


