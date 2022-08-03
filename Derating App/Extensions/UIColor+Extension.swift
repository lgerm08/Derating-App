//
//  UIColor+Extension.swift
//  Derating App
//
//  Created by GIRA on 29/07/22.
//

import UIKit 

extension UIColor {
    func RGBColor(r: Float, g: Float, b: Float) -> UIColor {
        return UIColor(red: CGFloat(r/255.0), green: CGFloat(g/255.0), blue: CGFloat(b/255.0), alpha: 1.0)
    }
}
