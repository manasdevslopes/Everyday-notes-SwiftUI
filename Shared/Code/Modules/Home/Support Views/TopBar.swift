//
//  TopBar.swift
//  Everyday-Notes
//
//  Created by MANAS VIJAYWARGIYA on 02/05/21.
//

import SwiftUI

struct TopBar: View {
    
    // MARK:- variables
    @EnvironmentObject var taskManager: TaskManager
    @Binding var viewAppeared: Bool
    
    @State var profileScale: CGFloat = 0
    @State var profileOpacity: Double = 0
    @State var profileOffset: CGFloat = 48
    @State var userNameOpacity: Double = 0
    
    
    // MARK:- views
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(taskManager.greeting)
                    .font(TypefaceOne.medium.font(size: 24))
                    .foregroundColor(Color.label.opacity(0.75))
                    .shadow(color: Color.white.opacity(0.5), radius: 1)
                    .opacity(self.viewAppeared ? 1 : 0)
                    .frame(width: self.viewAppeared ? 300: 0, alignment: .leading)
                    .animation(Animation.easeInOut(duration: 0.3))
                Text("Manas")
                    .font(TypefaceOne.bold.font(size: 36))
                    .foregroundColor(Color.label)
                    .shadow(color: Color.white.opacity(0.5), radius: 1)
                    .opacity(self.userNameOpacity)
            }
            Spacer()
            ProfileView()
                .opacity(self.profileOpacity)
                .offset(x: self.profileOffset)
                .scaleEffect(self.profileScale)
        }.onAppear() {
            withAnimation(Animation.easeInOut(duration: 0.3).delay(0.1)) {
                self.userNameOpacity = 1
            }
            withAnimation(Animation.easeOut(duration: 0.3).delay(0.15)) {
                self.profileScale = 1
                self.profileOpacity = 1
                self.profileOffset = 0
            }
        }
    }
}

struct TopBar_Previews: PreviewProvider {
    static var previews: some View {
        TopBar(viewAppeared: .constant(true))
    }
}
