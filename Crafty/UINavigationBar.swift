//
//  UINavigationBar.swift
//  Crafty
//
//  Created by Jimmy Hoang on 2/17/17.
//  Copyright © 2017 Jimmy Hoang. All rights reserved.
//

import UIKit

extension UINavigationController {
    
}

extension UINavigationItem {
    func changeTitleView() {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 73, height: 28))
        imageView.image = UIImage(named: "Title")
        titleView = imageView
    }
}

extension UINavigationBar {
    func setup() {
        titleTextAttributes = [NSForegroundColorAttributeName : Color.strongYellow,
                               NSFontAttributeName: UIFont(name: "Lato-Medium", size: 18)]
        
        backIndicatorImage = UIImage(named: "NavBarBack")
        backIndicatorTransitionMaskImage = UIImage(named: "NavBarBack")
    }
}
