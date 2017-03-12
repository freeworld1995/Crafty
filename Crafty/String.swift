//
//  String.swift
//  Crafty
//
//  Created by Jimmy Hoang on 3/11/17.
//  Copyright © 2017 Jimmy Hoang. All rights reserved.
//

import UIKit

extension NSMutableAttributedString {
    func bold(_ text:String) -> NSMutableAttributedString {
        let attrs:[String:AnyObject] = [NSFontAttributeName : UIFont(name: "Lato-Bold", size: 14)!]
        let boldString = NSMutableAttributedString(string:"\(text)", attributes:attrs)
        self.append(boldString)
        return self
    }
    
    func normal(_ text:String)->NSMutableAttributedString {
        let normal =  NSAttributedString(string: text)
        self.append(normal)
        return self
    }
}
