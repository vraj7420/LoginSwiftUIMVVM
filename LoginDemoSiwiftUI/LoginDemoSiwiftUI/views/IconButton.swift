//
//  IconButton.swift
//  LoginDemoSiwiftUI
//
//  Created by Vraj on 27/05/25.
//

import SwiftUI

struct IconButton: View {
    let imageName: String
    let width: CGFloat
    let height: CGFloat
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(imageName)
                .resizable()
                .frame(width: width, height: height)
        }
    }
}
