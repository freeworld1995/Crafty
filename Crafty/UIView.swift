//
//  UIView.swift
//  Crafty
//
//  Created by Jimmy Hoang on 2/1/17.
//  Copyright © 2017 Jimmy Hoang. All rights reserved.
//
import UIKit

extension UIView {
    
    @IBInspectable var cornerRadius: CGFloat {
        get { return layer.cornerRadius }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get { return layer.borderWidth }
        set { layer.borderWidth = newValue }
    }
    
    @IBInspectable var borderColor: UIColor? {
        get { return UIColor(cgColor: layer.borderColor!) }
        set { return layer.borderColor = newValue?.cgColor }
    }
    
}
