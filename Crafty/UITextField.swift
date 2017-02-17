//
//  UITextField.swift
//  Crafty
//
//  Created by Jimmy Hoang on 2/1/17.
//  Copyright © 2017 Jimmy Hoang. All rights reserved.
//

import UIKit

extension UITextField {
    @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSForegroundColorAttributeName: newValue!])
        }
    }
}
