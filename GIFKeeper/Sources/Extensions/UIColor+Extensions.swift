//
//  UIColor+Extensions.swift
//  GIFKeeper
//
//  Created by Sonata Girl on 17.10.2023.
//

import UIKit

extension UIColor {
    static func appMainColor() -> UIColor {
        UIColor(red: 58 / 255,
                green: 163 / 255,
                blue: 144 / 255,
                alpha: 1)
    }
    
    static func lightGrayHalfAlpha() -> UIColor {
        UIColor.lightGray.withAlphaComponent(0.5)
    }
    
    static func lightGrayLowAlpha() -> UIColor {
        UIColor.lightGray.withAlphaComponent(0.2)
    }
}
