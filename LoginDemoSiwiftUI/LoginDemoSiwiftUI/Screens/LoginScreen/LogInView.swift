//
//  LogInView.swift
//  LoginDemoSiwiftUI
//
//  Created by MACM18 on 12/05/25.
//

import SwiftUI

struct LogInView: View {
    @ObservedObject var viewModel = LogInViewModal()

    var body: some View {
        VStack(alignment: .leading){
            Text(StringConsatnts.signUpButtonTitle)
                .font(.system(size: 40,weight:  .bold))
                .foregroundColor(.gray)
                .multilineTextAlignment(.leading)
            Text(StringConsatnts.welcomeBackTitle)
                .font(.system(size: 26,weight: .bold))
                .foregroundColor(.gray)
                .multilineTextAlignment(.leading)
            VStack{
                ULTextFieldView(text: $viewModel.emailAddress, errorText: $viewModel.errorEmailAddress,placeholder: StringConsatnts.emailPlaceholder, keyboardType: .emailAddress)
                ULTextFieldView(text: $viewModel.password, errorText: $viewModel.errorPassword,placeholder: StringConsatnts.passwodPlaceholder)
            }.padding(.vertical,40)
            CustomButton(
                title: StringConsatnts.signInButtonTitle,
                textColor: .white,
                background: LinearGradient(
                    gradient: Gradient(colors: [Color.orange, Color.red]),
                    startPoint: .leading,
                    endPoint: .trailing
                ), isEnabled: viewModel.isEanbleButton) {
                    viewModel.login()
                }
        }
        .alert(isPresented: $viewModel.showErrorAlert) {
                    Alert(
                        title: Text(viewModel.logInErrorTitle),
                        message: Text(viewModel.logINErrorMessage),
                        dismissButton: .default(Text(StringConsatnts.OkButtonTitle))
                    )
                }
        .padding(.horizontal,30)
        .frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .center)
        .background(Color.black.edgesIgnoringSafeArea(.all))

    }
}

#Preview {
    LogInView()
}
