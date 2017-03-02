//
//  ReusableView.swift
//  Crafty
//
//  Created by Jimmy Hoang on 2/28/17.
//  Copyright © 2017 Jimmy Hoang. All rights reserved.
//

import UIKit

protocol ReusableView: class {}

extension ReusableView where Self: UIView {
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
}

extension UITableViewCell: ReusableView { }

extension UICollectionViewCell: ReusableView { }
