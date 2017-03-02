//
//  HomeCategoryCell.swift
//  Crafty
//
//  Created by Jimmy Hoang on 3/1/17.
//  Copyright © 2017 Jimmy Hoang. All rights reserved.
//

import UIKit

class HomeCategoryCell: UICollectionViewCell {
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var title: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        title.font = UIFont(name: "Lato-Semibold", size: 14)
        title.textColor = UIColor.white
        self.layer.cornerRadius = 5.0
        self.layer.masksToBounds = false
        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.5
        self.layer.shadowRadius = 2
    }
    
    func setupImage(name: String) {
        image.image = UIImage(named: name)
    }

}
