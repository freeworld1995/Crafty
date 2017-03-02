//
//  NibLoadableView.swift
//  Crafty
//
//  Created by Jimmy Hoang on 2/28/17.
//  Copyright © 2017 Jimmy Hoang. All rights reserved.
//
import UIKit

protocol NibLoadableView: class { }

extension NibLoadableView where Self: UIView {
    
    static var nibName: String {
        // notice the new describing here
        // now only one place to refactor if describing is removed in the future
        return String(describing: self)
    }
    
}

// Now all UITableViewCells have the nibName variable
// you can also apply this to UICollectionViewCells if you have those
// Note that if you have some cells that DO NOT load from a Nib vs some that do,
// extend the cells individually vs all of them as below!
// In my project, all cells load from a Nib.
extension UITableViewCell: NibLoadableView { }

extension UICollectionViewCell: NibLoadableView { }
