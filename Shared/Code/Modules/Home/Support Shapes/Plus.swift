//
//  Plus.swift
//  Everyday-Notes
//
//  Created by MANAS VIJAYWARGIYA on 02/05/21.
//

import SwiftUI

struct PlusPosition: Identifiable, Hashable {
    var id: Int
    var color: Color
    
    var offsetX: CGFloat
    var offsetY: CGFloat
    var delay: TimeInterval
    
    var scale: CGFloat
    var opacity: Double
    var degree: Angle
}


struct Plus: Shape {
    func path(in rect: CGRect) -> Path {

        let cX: CGFloat = rect.midX
        let cY: CGFloat = rect.midY
            
        var path = Path()
        
        path.move(to: CGPoint(x: cX, y: cY + -16))
        path.addLine(to: CGPoint(x: cX, y: cY + 16))
        path.move(to: CGPoint(x: cX + -16, y: cY))
        path.addLine(to: CGPoint(x: cX + 16, y: cY))
        return path
        
    }
    
}

struct Plus_Previews: PreviewProvider {
    static var previews: some View {
        Plus()
            .stroke(style: StrokeStyle(lineWidth: 6, lineCap: .round))
    }
}
