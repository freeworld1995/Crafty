//
//  TakePictureCollectionViewCell.swift
//  Crafty
//
//  Created by Jimmy Hoang on 2/5/17.
//  Copyright © 2017 Jimmy Hoang. All rights reserved.
//

import UIKit

class TakePictureCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var productImage: UIImageView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    func setImage(image: UIImage) {
        self.productImage.image = image
    }
    

    
}
