//
//  AccountCategoryCell.swift
//  Crafty
//
//  Created by Jimmy Hoang on 3/11/17.
//  Copyright © 2017 Jimmy Hoang. All rights reserved.
//

import UIKit
import Firebase

class AccountCategoryCell: BaseCellWithShadow {
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var title: UILabel!

    override var isSelected: Bool {
        didSet {
                self.alpha = 1.0

//            } else {
//                self.alpha = 0.5
//            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.alpha = 0.5
        title.font = UIFont(name: "Lato-Semibold", size: 14)
        title.textColor = UIColor.white
        
    }
    
    func setupImage(name: String) {
        image.image = UIImage(named: name)
    }

}
