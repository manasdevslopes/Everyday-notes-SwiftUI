//
//  LikeView.swift
//  Everyday-Notes
//
//  Created by MANAS VIJAYWARGIYA on 02/05/21.
//

import SwiftUI

struct LikeView: Shape {
    let scale: CGFloat
    
    func path(in rect: CGRect) -> Path {
        let cX = rect.midX
        let cY = rect.midY
        
        var path = Path()
        path.move(to: CGPoint(x: cX + (scale * -20.83), y: cY + (scale * 35.67)))
        path.addLine(to: CGPoint(x: cX + (scale * -33.33), y: cY + (scale * 35.67)))
        path.addLine(to: CGPoint(x: cX + (scale * -33.33), y: cY + (scale * 35.67)))
        path.addCurve(to: CGPoint(x: cX + (scale * -41.67), y: cY + (scale * 27.33)), control1: CGPoint(x: cX + (scale * -37.94), y: cY + (scale * 35.67)), control2: CGPoint(x: cX + (scale * -41.67), y: cY + (scale * 31.94)))
        path.addLine(to: CGPoint(x: cX + (scale * -41.67), y: cY + (scale * -1.83)))
        path.addLine(to: CGPoint(x: cX + (scale * -41.67), y: cY + (scale * -1.83)))
        path.addCurve(to: CGPoint(x: cX + (scale * -33.33), y: cY + (scale * -10.17)), control1: CGPoint(x: cX + (scale * -41.67), y: cY + (scale * -6.44)), control2: CGPoint(x: cX + (scale * -37.94), y: cY + (scale * -10.17)))
        path.addLine(to: CGPoint(x: cX + (scale * -20.83), y: cY + (scale * -10.17)))
        
        path.move(to: CGPoint(x: cX + (scale * 8.33), y: cY + (scale * -18.5)))
        path.addLine(to: CGPoint(x: cX + (scale * 8.33), y: cY + (scale * -35.17)))
        path.addLine(to: CGPoint(x: cX + (scale * 8.33), y: cY + (scale * -35.17)))
        path.addCurve(to: CGPoint(x: cX + (scale * -4.17),  y: cY + (scale * -47.67)), control1: CGPoint(x: cX + (scale * 8.33), y: cY + (scale * -42.07)), control2: CGPoint(x: cX + (scale *  2.74), y: cY + (scale * -47.67)))
        
        path.addLine(to: CGPoint(x: cX + (scale * -20.83), y: cY + (scale * -10.17)))
        path.addLine(to: CGPoint(x: cX + (scale * -20.83), y: cY + (scale * 35.67)))
        path.addLine(to: CGPoint(x: cX + (scale * 26.17), y: cY + (scale * 35.67)))
        path.addLine(to: CGPoint(x: cX + (scale * 26.12), y: cY + (scale * 35.67)))
        
        path.addCurve(to: CGPoint(x: cX + (scale * 34.49), y: cY + (scale * 28.64)), control1: CGPoint(x: cX + (scale * 30.27), y: cY + (scale * 35.74)), control2: CGPoint(x: cX + (scale * 33.84), y: cY + (scale * 32.74)))
        path.addLine(to: CGPoint(x: cX + (scale * 40.25), y: cY + (scale * -8.92)))
        path.addLine(to: CGPoint(x: cX + (scale * 40.24), y: cY + (scale * -8.86)))
        
        path.addCurve(to: CGPoint(x: cX + (scale * 33.31), y: cY + (scale * -18.4)), control1: CGPoint(x: cX + (scale * 40.96), y: cY + (scale * -13.41)), control2: CGPoint(x: cX + (scale * 37.86), y: cY + (scale * -17.68)))
        path.addCurve(to: CGPoint(x: cX + (scale * 32.01), y: cY + (scale * -18.5)), control1: CGPoint(x: cX + (scale * 32.88), y: cY + (scale * -18.47)), control2: CGPoint(x: cX + (scale * 32.45), y: cY + (scale * -18.5)))
        
        path.addLine(to: CGPoint(x: cX + (scale * 8.33), y: cY + (scale * -18.5)))
        
        return path
    }
}

struct LikeView_Previews: PreviewProvider {
    static var previews: some View {
        LikeView(scale: 1.5)
            .stroke(style: StrokeStyle(lineWidth: 4))
//            .trim(from: 0, to: 0.5)
    }
}
