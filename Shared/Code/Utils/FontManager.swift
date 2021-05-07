//
//  FontManager.swift
//  Everyday-Notes
//
//  Created by MANAS VIJAYWARGIYA on 02/05/21.
//

import SwiftUI

enum TypefaceOne {
    case regular
    case medium
    case semibold
    case bold
    
    func font(size: CGFloat) -> Font {
        switch self {
        case .regular:
            return .custom("NocturneSerif-Regular", size: size)
        case .medium:
            return .custom("NocturneSerif-Medium", size: size)
        case .semibold:
            return .custom("NocturneSerif-SemiBold", size: size)
        case .bold:
            return .custom("NocturneSerif-Bold", size: size)
            
        }
    }
}

enum TypefaceTwo {
    case regular
    case medium
    case semibold
    case bold
    
    func font(size: CGFloat) -> Font {
        switch self {
        case .regular:
            return .custom("Ubuntu-Regular", size: size)
        case .medium:
            return .custom("Ubuntu-Medium", size: size)
        case .semibold:
            return .custom("Ubuntu-SemiBold", size: size)
        case .bold:
            return .custom("Ubuntu-Bold", size: size)
            
        }
    }
}




