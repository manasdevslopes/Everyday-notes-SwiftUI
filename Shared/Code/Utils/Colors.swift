//
//  Colors.swift
//  Everyday-Notes
//
//  Created by MANAS VIJAYWARGIYA on 02/05/21.
//

import SwiftUI

extension Color {
    
    static func getBackgroundColor(colorScheme: ColorScheme) -> Color {
        if (colorScheme == .light) {
            return Color(hex: "f0f0f0")
        } else {
            return Color(hex: "030303")
        }
    }
    
    static func getColorForTick(colorScheme: ColorScheme) -> Color {
        if (colorScheme == .light) {
            return Color(hex: "ececec")
        } else {
            return Color(hex: "3f3f3f")
        }
    }
    
    static func getColorForStrikeout(colorScheme: ColorScheme) -> Color {
        if (colorScheme == .light) {
            return Color(hex: "1b1b1b")
        } else {
            return Color(hex: "e0e0e0")
        }
    }
    
    static func getColorForInstruction(colorScheme: ColorScheme) -> Color {
        if (colorScheme == .light) {
            return Color(hex: "e0e0e0")
        } else {
            return Color(hex: "898989")
        }
    }
    
    static func getColorForValidation(colorScheme: ColorScheme) -> Color {
        if (colorScheme == .light) {
            return Color(hex: "ff0000")
        } else {
            return Color.red
        }
    }
    
    static let background: Color = Color(UIColor.systemBackground)
    static let label: Color = Color(UIColor.label)
}
