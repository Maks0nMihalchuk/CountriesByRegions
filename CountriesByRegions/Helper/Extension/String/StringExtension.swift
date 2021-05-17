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
}
