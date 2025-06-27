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
            Text(StringConsatnts.signUpScreenTitle)
                .font(.system(size: 26,weight: .bold))
                .foregroundColor(.gray)
                .multilineTextAlignment(.leading)
                .padding(.trailing,50)
            VStack{
                ULTextFieldView(text: $viewModel.emailAddress, errorText: $viewModel.errorEmailAddress,placeholder: StringConsatnts.emailPlaceholder, keyboardType: .emailAddress)
                    .accessibilityIdentifier("signup_emailTextField")
                ULTextFieldView(text: $viewModel.name, errorText: $viewModel.errorName,placeholder: StringConsatnts.namePlaceholder)
                    .accessibilityIdentifier("signup_nameTextField")
                ULTextFieldView(text: $viewModel.password, errorText: $viewModel.errorPassword,placeholder: StringConsatnts.passwodPlaceholder)
                    .accessibilityIdentifier("signup_passwordTextField")
            }.padding(.vertical,40)
            VStack(alignment: .leading) {
                CustomButton(
                    title: StringConsatnts.signUpButtonTitle,
                    textColor: .white,
                    background: LinearGradient(
                        gradient: Gradient(colors: [Color.orange, Color.red]),
                        startPoint: .leading,
                        endPoint: .trailing),
                    isEnabled:viewModel.isEanbleButton){
                        Task {
                            await  viewModel.signUp()
                        }
                        
                    }
                    .accessibilityIdentifier("signup_signUpButton")
                Text(StringConsatnts.socialSignUpTitle)
                    .font(.system(size: 25,weight: .bold))
                    .foregroundColor(.gray)
                socialLogIn
                    .padding(.trailing,100)
            }
        }
        .alert(isPresented: $viewModel.showErrorAlert) {
            Alert(
                title: Text(viewModel.signUPErrorTitle),
                message: Text(viewModel.signUPErrorMessage),
                dismissButton: .default(Text(StringConsatnts.OkButtonTitle))
            )
        }
        .padding(.horizontal,30)
        .frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .center)
        .background(Color.black.edgesIgnoringSafeArea(.all))
        
    }
    
    var socialLogIn:some View {
        HStack {
            IconButton(imageName: ImageConstants.facebookLogo, width: 50, height: 50){
                
            }.accessibilityIdentifier("signup_facebookButton")
            Spacer()
            IconButton(imageName: ImageConstants.twiteerLogo, width: 50, height: 50){
                
            }.accessibilityIdentifier("signup_twitterButton")
            Spacer()
            IconButton(imageName: ImageConstants.googleLogo, width: 50, height: 50){
                
            }.accessibilityIdentifier("signup_googleButton")
        }
    }
}

#Preview {
    SignUpView()
}


