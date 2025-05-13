//
//  CurveView.swift
//  LoginDemoSiwiftUI
//
//  Created by MACM18 on 12/05/25.
//

import SwiftUI


struct CurveView: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: 0, y: rect.height))
        path.addCurve(
            to: CGPoint(x: rect.width, y: rect.height * 0.85),
            control1: CGPoint(x: rect.width * 0.4, y: rect.height*1.2),
            control2: CGPoint(x: rect.width * 0.6, y: rect.height*(0.6))
        )
        path.addLine(to: CGPoint(x: rect.width, y: 0))
        path.closeSubpath()
        
        return path
    }
}
