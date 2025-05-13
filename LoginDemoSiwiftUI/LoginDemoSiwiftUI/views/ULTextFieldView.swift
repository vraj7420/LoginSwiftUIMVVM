//
//  ULTextFieldView.swift
//  LoginDemoSiwiftUI
//
//  Created by MACM18 on 12/05/25.
//

import SwiftUI

struct ULTextFieldView: View {
    @Binding var text: String
    var placeholder: String = "Enter text"
    var keyboardType: UIKeyboardType = .default

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            TextField(placeholder, text: $text)
                .keyboardType(keyboardType)
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .padding(.bottom, 4)
                .foregroundColor(.white)
                .textFieldStyle(PlainTextFieldStyle())
                .placeholder(when: text.isEmpty) {
                    Text(placeholder).foregroundColor(.gray)
                }
            
            Rectangle()
                .frame(height: 1)
                .foregroundColor(.gray)
        }
        .padding()
    }
}
