//
//  CategoryCell.swift
//  Crafty
//
//  Created by Jimmy Hoang on 2/8/17.
//  Copyright © 2017 Jimmy Hoang. All rights reserved.
//

import UIKit
import Lottie

class CategoryContainerCell: UICollectionViewCell {
    
    @IBOutlet weak var labelContainer: UIView!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var separateLine: UIView!
    @IBOutlet weak var collectionView: CategoryDetailCollectionView!
    @IBOutlet weak var categoryDetailHeightConstraint: NSLayoutConstraint!
    var animationView = LOTAnimationView()
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                self.labelContainer.backgroundColor = Color.selectedCellYellow
                self.separateLine.isHidden = true
            } else {
                self.labelContainer.backgroundColor = Color.deselectedCellGray
                self.separateLine.isHidden = false
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.autoresizingMask = [.flexibleHeight]
        self.autoresizingMask = .flexibleHeight
        
        animationView = LOTAnimationView(name: "data10")
        animationView.frame = CGRect(x: self.labelContainer.frame.width * 0.8, y: 10, width: 30, height: 30)
        animationView.contentMode = .scaleAspectFit
        
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
