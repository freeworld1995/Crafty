//
//  ItemTableViewCell.swift
//  Crafty
//
//  Created by Jimmy Hoang on 2/17/17.
//  Copyright © 2017 Jimmy Hoang. All rights reserved.
//

import UIKit

class ItemTableViewCell: UITableViewCell {
    
    @IBOutlet weak var itemDetail: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
