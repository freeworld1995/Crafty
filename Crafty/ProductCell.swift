//
//  ProductCell.swift
//  Crafty
//
//  Created by Jimmy Hoang on 3/2/17.
//  Copyright © 2017 Jimmy Hoang. All rights reserved.
//

import UIKit
import SDWebImage

class ProductCell: BaseCellWithShadow {
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productTitle: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userLocation: UILabel!

    @IBOutlet weak var loveCount: UILabel!
    @IBOutlet weak var commentCount: UILabel!
    
    var userID: String? {
        didSet {
            FirebaseManager.getUser(byID: userID!) { (user) in
                self.userName.text = user.name
                self.userLocation.text = user.city
                self.userImage.sd_setImage(with: URL(string: user.profileImageUrl!))
            }

        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        userImage.layer.cornerRadius = userImage.frame.width / 2
        userImage.layer.masksToBounds = true
    }

    @IBAction func lovePressed(_ sender: UIButton) {
    }
    
    @IBAction func commentPressed(_ sender: UIButton) {
    }

    @IBAction func socialPressed(_ sender: UIButton) {
    }
}
