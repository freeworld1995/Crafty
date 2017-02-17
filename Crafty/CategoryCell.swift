//
//  CategoryCell.swift
//  Crafty
//
//  Created by Jimmy Hoang on 2/8/17.
//  Copyright © 2017 Jimmy Hoang. All rights reserved.
//

import UIKit
import Lottie

class CategoryCell: UICollectionViewCell {

    @IBOutlet weak var labelContainer: UIView!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var collectionView: CategoryDetailCollectionView!
    @IBOutlet weak var categoryDetailHeightConstraint: NSLayoutConstraint!
    var animationView = LOTAnimationView()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.autoresizingMask = [.flexibleHeight]
        self.autoresizingMask = .flexibleHeight
        
        print(self.labelContainer.frame.height / 2)
        
        animationView = LOTAnimationView.animationNamed("data10")
        animationView.frame = CGRect(x: self.labelContainer.frame.width * 0.8, y: 10, width: 30, height: 30)
        animationView.contentMode = .scaleAspectFit

        
        let square = UIView(frame: CGRect(x: self.labelContainer.frame.width * 0.8, y: 10, width: 60, height: 30))
        square.backgroundColor = UIColor.red
        
        labelContainer.addSubview(animationView)
    }
    
    func play() {
        animationView.play()
    }
    
    func setHeight() {
        UIView.animate(withDuration: 0.5) { [unowned self] in
            self.categoryDetailHeightConstraint.constant = 250
            
        }
    }

}
