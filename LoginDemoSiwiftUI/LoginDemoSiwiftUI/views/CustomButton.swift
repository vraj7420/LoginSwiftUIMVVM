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
    let isEnabled: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .fontWeight(.bold)
                .foregroundColor(isEnabled ? textColor : textColor.opacity(0.5))
                .frame(maxWidth: .infinity)
                .padding()
                .background(
                    isEnabled
                        ? AnyView(background)
                        : AnyView(Color.gray.opacity(0.3))
                )                .cornerRadius(20)
        }
        .disabled(!isEnabled)
    }
}
