//
//  CustomTextField.swift
//  Everyday-Notes
//
//  Created by MANAS VIJAYWARGIYA on 02/05/21.
//

import SwiftUI

struct CustomTextField<PlaceholderView: View>: View {
    
    // MARK:- variables
    @Binding var text: String
    var editingChanged: () -> () = { }
    var commit: () -> () = { }
    
    var placeholderView: PlaceholderView
    
    @Binding var viewFocused: Bool
    
    // MARK:- init
    init(@ViewBuilder placeholderView: () -> PlaceholderView, entry: Binding<String>, viewFocused: Binding<Bool>, commit: @escaping() -> ()) {
        self.placeholderView = placeholderView()
        self._text = entry
        self._viewFocused = viewFocused
        self.commit = commit
    }
    
    // MARK:- views
    var body: some View {
        ZStack(alignment: .leading) {
            if text.isEmpty {
                placeholderView
            }
            TextField("", text: $text, onEditingChanged: { _ in
                editingChanged()
                self.viewFocused = true
            }, onCommit: commit)
            .font(TypefaceOne.regular.font(size: 20))
            .frame(width: UIScreen.main.bounds.width - 48)
            .accentColor(Color.background)
            .foregroundColor(.background)
            .disableAutocorrection(true)
            ZStack {
                Capsule()
                    .stroke(style: StrokeStyle(lineWidth: 2, lineCap: .round))
                    .opacity(0.25)
                    .frame(height: 0.5)
                    .foregroundColor(.background)
                RoundedRectangle(cornerRadius: 24)
                    .trim(from: 0, to: self.viewFocused ? 1 : 0)
                    .stroke(style: StrokeStyle(lineWidth: 2, lineCap: .round))
                    .rotationEffect(.degrees(180))
                    .foregroundColor(.background)
                    .frame(height: 0.5, alignment: .trailing)
            }
            .padding(.top, 38)
        }.animation(.default)
    }
}


struct CustomTextField_Previews: PreviewProvider {
    static var previews: some View {
        CustomTextField(placeholderView: {
            Text("Enter Task Here")
                .font(.system(size: 13, weight: .semibold))
                .opacity(0.5)
        }, entry: .constant(""), viewFocused: .constant(false), commit: {})
        .padding()
    }
}
