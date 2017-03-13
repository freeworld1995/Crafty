//
//  ProductCommentTableViewCell.swift
//  Crafty
//
//  Created by Nguyen Bach on 3/13/17.
//  Copyright © 2017 Jimmy Hoang. All rights reserved.
//

import UIKit

class ProductCommentTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var commentTextLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
