//
//  CustomButton.swift
//  LoginDemoSiwiftUI
//
//  Created by MACM18 on 12/05/25.
//

import SwiftUI

struct CustomButton<Background: View>: View {
    let title: String
    let textColor: Color
    let background: Background
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .fontWeight(.bold)
                .foregroundColor(textColor)
                .frame(maxWidth: .infinity)
                .padding()
                .background(background)
                .cornerRadius(20)
        }
    }
}
