//
//  FoundationExtensions.swift
//  Everyday-Notes
//
//  Created by MANAS VIJAYWARGIYA on 02/05/21.
//

import UIKit

extension String {
    func getHeight(_ font: UIFont, width: CGFloat, maxHeight: CGFloat = CGFloat.greatestFiniteMagnitude) -> CGFloat {
        let constraintRect = CGSize(width: width, height: maxHeight)
        let boundingBox = self.boundingRect(with: constraintRect, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return boundingBox.height
    }
    
    func getWidth(_ font: UIFont, maxWidth: CGFloat = CGFloat.greatestFiniteMagnitude, height: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: maxWidth, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return boundingBox.width
    }

}
