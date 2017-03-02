//
//  SubmitProductImageView.swift
//  Crafty
//
//  Created by Jimmy Hoang on 2/22/17.
//  Copyright © 2017 Jimmy Hoang. All rights reserved.
//

import UIKit

class SubmitProductImageView: UIImageView {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.5
        self.layer.shadowRadius = 2
    }

}
