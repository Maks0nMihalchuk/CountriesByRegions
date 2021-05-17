//
//  StringExtension.swift
//  CountriesByRegions
//
//  Created by MaksOn on 17.05.2021.
//

import Foundation
import UIKit

extension String {

    func widthOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = (self as NSString).size(withAttributes: fontAttributes)
        return ceil(size.width)
    }
    
    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes:[NSAttributedString.Key.font: font], context: nil)
        return ceil(boundingBox.width)
    }
}
