//
//  UITextField.swift
//  Crafty
//
//  Created by Jimmy Hoang on 2/1/17.
//  Copyright © 2017 Jimmy Hoang. All rights reserved.
//

import UIKit

@IBDesignable
class CustomTextField: UITextField {
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 8, dy: 7)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return textRect(forBounds: bounds)
    }
}
