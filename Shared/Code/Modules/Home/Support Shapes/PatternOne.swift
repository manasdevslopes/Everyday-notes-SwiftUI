//
//  PatternOne.swift
//  Everyday-Notes
//
//  Created by MANAS VIJAYWARGIYA on 02/05/21.
//

import SwiftUI

struct PatternOne: View {
    
    @State var isAppeared = false
    
    @State var lineStrokeOne: CGFloat = 1
    @State var lineStrokwTwo: CGFloat = 1
    
    let colorOne: Color
    let colorTwo: Color
    var needsAnimation: Bool = true
    
    var body: some View {
        ZStack {
            Path { path in
                path.move(to: CGPoint(x: 454, y: 308.46))
                path.addCurve(to: CGPoint(x: -133.07, y: 308.46), control1: CGPoint(x: 103.46, y: 629.48), control2: CGPoint(x: 43.99, y: 137.39))
            }
            .stroke(style: StrokeStyle(lineWidth: 100, lineCap: .round))
            .trim(from: 0, to: lineStrokeOne)
            .foregroundColor(colorOne)
            
            
            Path { path in
                path.move(to: CGPoint(x: 454, y: 420))
                path.addCurve(to: CGPoint(x: -133.07, y: 490.46), control1: CGPoint(x: 103.46, y: 679.48), control2: CGPoint(x: 43.99, y: 137.39))
            }
            .stroke(style: StrokeStyle(lineWidth: 80, lineCap: .round))
            .trim(from: 0, to: lineStrokwTwo)
            .foregroundColor(colorTwo)
        }
    }
}
