//
//  LocationTableViewCell.swift
//  Crafty
//
//  Created by Jimmy Hoang on 2/28/17.
//  Copyright © 2017 Jimmy Hoang. All rights reserved.
//

import UIKit

class LocationTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                self.accessoryType = .checkmark
            } else {
                self.accessoryType = .none
            }
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
