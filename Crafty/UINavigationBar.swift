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
    
    /**
     Add image to NavigationBar Title
     - Parameter width: NavigationBar width
     - Parameter height: NavigationBar height
     */
    func changeTitleView(width: CGFloat, height: CGFloat) {
        let image = UIImage(named: "Title")
        let imageView = UIImageView(frame: CGRect(x: (width - image!.size.width) / 2, y: (height - image!.size.height) / 2, width: image!.size.width, height: image!.size.height))
        
        imageView.image = image
        self.titleView = imageView
    }
}

extension UINavigationBar {
    /**
     Setup text style for NavigationBar Title
     */
    func setup() {
        titleTextAttributes = [NSForegroundColorAttributeName : Color.strongYellow,
                               NSFontAttributeName: UIFont(name: "Lato-Medium", size: 20)]
    }
}
