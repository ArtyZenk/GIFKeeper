//
//  UIColor+Extensions.swift
//  GIFKeeper
//
//  Created by Sonata Girl on 17.10.2023.
//

import UIKit

extension UIColor {
    static var appMainColor: UIColor {
        UIColor(red: 58 / 255,
                green: 163 / 255,
                blue: 144 / 255,
                alpha: 1)
    }
    
    static var lightGrayHalfAlpha: UIColor {
        UIColor.lightGray.withAlphaComponent(0.5)
    }
    
    static var lightGrayLowAlpha: UIColor {
        UIColor.lightGray.withAlphaComponent(0.2)
    }
}
