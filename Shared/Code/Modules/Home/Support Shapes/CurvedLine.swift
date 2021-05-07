//
//  CurvedLine.swift
//  Everyday-Notes
//
//  Created by MANAS VIJAYWARGIYA on 02/05/21.
//

import SwiftUI

struct CurveLine: Shape {
    
    // MARK:- variables
    var animatableX: CGFloat = 0
    var animatableY: CGFloat = 0
    var applyExtraPadding: Bool = false
    
    var animatableData: AnimatablePair<CGFloat, CGFloat> {
        get { AnimatablePair(animatableX, animatableY) }
        set {
            self.animatableX = newValue.first
            self.animatableY = newValue.second
        }
    }
    
    // MARK:- functions
    func path(in rect: CGRect) -> Path {
        let cX = rect.midX
        let cY = rect.midY
        
        var path = Path()
        path.move(to: CGPoint(x: 0 , y: cY))
        path.addLine(to: CGPoint(x: cX * 1.55, y: cY))
        path.addLine(to: CGPoint(x: cX * 2, y: cY))
        return path
    }
}

struct CurveLine_Previews: PreviewProvider {
    static var previews: some View {
        CurveLine(animatableX: 22, animatableY: -10)
            .stroke(style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
            .padding(24)
    }
}

