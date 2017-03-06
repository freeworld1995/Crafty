//
//  BaseCellWithShadow.swift
//  Crafty
//
//  Created by Jimmy Hoang on 3/6/17.
//  Copyright © 2017 Jimmy Hoang. All rights reserved.
//

import UIKit

class BaseCellWithShadow: UICollectionViewCell {
    override func awakeFromNib() {
        self.layer.cornerRadius = 5.0
        self.layer.masksToBounds = false
        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.5
        self.layer.shadowRadius = 2
    }
}
