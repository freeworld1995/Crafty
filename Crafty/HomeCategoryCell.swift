//
//  HomeCategoryCell.swift
//  Crafty
//
//  Created by Jimmy Hoang on 3/1/17.
//  Copyright © 2017 Jimmy Hoang. All rights reserved.
//

import UIKit

class HomeCategoryCell: BaseCellWithShadow {
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var title: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        title.font = UIFont(name: "Lato-Semibold", size: 14)
        title.textColor = UIColor.white

    }
    
    func setupImage(name: String) {
        image.image = UIImage(named: name)
    }

}
