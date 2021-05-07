//
//  Tick.swift
//  Everyday-Notes
//
//  Created by MANAS VIJAYWARGIYA on 02/05/21.
//

import SwiftUI

struct Tick: Shape {
    let scaleFactor: CGFloat
    
    func path(in rect: CGRect) -> Path {
        let cX = rect.midX + 4
        let cY = rect.midY - 3
        
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.move(to: CGPoint(x: cX - (42 * scaleFactor), y: cY - (4 * scaleFactor)))
        path.addLine(to: CGPoint(x: cX - (scaleFactor * 18), y: cY + (scaleFactor * 28)))
        path.addLine(to: CGPoint(x: cX + (scaleFactor * 40), y: cY - (scaleFactor * 36)))
        return path
    }
}

struct Tick_Previews: PreviewProvider {
    static var previews: some View {
        Tick(scaleFactor: 1)
            .stroke(style: StrokeStyle(lineWidth: 4, lineCap: .round, lineJoin: .round))
    }
}
