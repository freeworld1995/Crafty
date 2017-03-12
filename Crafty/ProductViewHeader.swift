//
//  ProductViewHeader.swift
//  Crafty
//
//  Created by Nguyen Bach on 3/5/17.
//  Copyright © 2017 Jimmy Hoang. All rights reserved.
//
//like&finishheaderCut
import UIKit

class ProductViewHeader1: UIView {
    func updateUI()  {
        imageBackgroundClient.layer.cornerRadius = 10
        imageBackgroundClient.layer.masksToBounds = true
    }
    @IBOutlet weak var imageBackgroundProduct: UIImageView!
    @IBOutlet weak var imageBackgroundClient: UIImageView!
}
