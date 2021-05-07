//
//  ProfileView.swift
//  Everyday-Notes
//
//  Created by MANAS VIJAYWARGIYA on 02/05/21.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        Image("Manas")
            .resizable()
            .frame(width: 64, height: 64)
            .cornerRadius(30)
            .overlay(RoundedRectangle(cornerRadius: 30)
                        .strokeBorder(Color.label, lineWidth: 4))
            .shadow(color: Color.label.opacity(0.1), radius: 4)
            .animation(Animation.spring())
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
