//
//  SuccessView.swift
//  Everyday-Notes
//
//  Created by MANAS VIJAYWARGIYA on 02/05/21.
//

import SwiftUI

struct SuccessView: View {
    
    // MARK:- variables
    @State var addAttachment: Bool = false
    @State var rotateBar: Bool = false
    @State var hidePlus: Bool = false
    
    @State var likeStart: CGFloat = 0
    @State var likeEnd: CGFloat = 0
    @State var textOpacity: Double = 0
    
    @Binding var blurRadius: CGFloat
    
    let thumbsColor: Color
    let labelColor: Color = Color.white
    
    var positions: [PlusPosition] = []
    
    // MARK:- initializers
    init(thumbsColor: Color, blurRadius: Binding<CGFloat>) {
        self.thumbsColor = thumbsColor
        self._blurRadius = blurRadius
        self.positions = self.getRandomPositions()
    }
    
    // MARK:- views
    var body: some View {
        ZStack {
            LikeView(scale: 2)
                .trim(from: likeStart, to: likeEnd)
                .stroke(style: StrokeStyle(lineWidth: 8, lineCap: .round))
                .foregroundColor(thumbsColor)
                .rotationEffect(self.getBarRotationDegree(), anchor: .leading)
                .animation(
                    Animation.interpolatingSpring(mass: 2, stiffness: 14, damping: 10, initialVelocity: 5)
                        .delay(0.1)
                )
            ZStack {
                ForEach(positions, id: \.self) { position in
                    ShrinkingPlus(position: position)
                        .offset(x: position.offsetX, y: position.offsetY)
                        .opacity(self.hidePlus ? 0 : 1)
                        .animation(Animation.easeIn(duration: 0.25))
                }
            }
            ZStack {
                Text("You're done for today, Good Job!")
                    .lineLimit(4)
                    .multilineTextAlignment(.center)
                    .font(.system(size: 28, weight: .bold, design: .monospaced))
                    .opacity(self.textOpacity)
                    .foregroundColor(Color.label)
                    .padding([.leading, .trailing], 24)
            }.frame(height: 100)
            .offset(y: 160)
        }.onAppear() {
            self.rotateBar.toggle()
            self.addAttachment.toggle()
            
            withAnimation(Animation.easeOut(duration: 0.3).delay(0.3)) {
                self.textOpacity = 1
                self.blurRadius = 6
            }
            
            Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { (Timer) in
                self.rotateBar = false
                self.addAttachment.toggle()
            }
            withAnimation(Animation.easeOut(duration: 0.5)) {
                self.likeEnd = 1
            }
        
            
            Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { _ in
                withAnimation(Animation.easeIn(duration: 0.3).delay(0.3)) {
                    self.textOpacity = 0
                }
                
                withAnimation(.default) {
                    self.blurRadius = 0
                }
                
                self.addAttachment.toggle()
                self.hidePlus.toggle()
                self.likeEnd = 0
            }
        }
    }
    
    // MARK:- functions
    func getBarRotationDegree() -> Angle {
        if (self.rotateBar && self.addAttachment) {
            return .degrees(-5)
        } else if (self.addAttachment) {
            return .degrees(5)
        } else {
            return .degrees(0)
        }
    }
    
    func getRandomPositions() -> [PlusPosition] {
        var positions = [PlusPosition]()
        positions.append(PlusPosition(id: 0, color: labelColor, offsetX: -92, offsetY: -100, delay: 0.2, scale: 0.8, opacity: 1, degree: Angle(degrees: 43)))
        positions.append(PlusPosition(id: 1, color: labelColor, offsetX: 72, offsetY: -100, delay: 0.1, scale: 0.5, opacity: 0.8, degree: Angle(degrees: -43)))
        positions.append(PlusPosition(id: 2, color: thumbsColor, offsetX: -52, offsetY: -50, delay: 0.225, scale: 0.5, opacity: 1, degree: Angle(degrees: -43)))
        positions.append(PlusPosition(id: 3, color: thumbsColor, offsetX: 110, offsetY: -20, delay: 0.135, scale: 0.25, opacity: 0.95, degree: Angle(degrees: 43)))
        positions.append(PlusPosition(id: 4, color: labelColor, offsetX: -115, offsetY: 72, delay: 0.075, scale: 1.1, opacity: 0.85, degree: Angle(degrees: 43)))
        positions.append(PlusPosition(id: 5, color: labelColor, offsetX: -140, offsetY: 32, delay: 0.15, scale: 0.3, opacity: 0.45, degree: Angle(degrees: 43)))
        positions.append(PlusPosition(id: 6, color: thumbsColor, offsetX: 100, offsetY: 102, delay: 0.2, scale: 0.65, opacity: 0.85, degree: Angle(degrees: 43)))
        return positions
    }
}

struct SuccessView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)
            SuccessView(thumbsColor: Color.label, blurRadius: .constant(0))
        }
    }
}

