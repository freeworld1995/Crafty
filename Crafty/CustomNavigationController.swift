//
//  CustomNavigationController.swift
//  Crafty
//
//  Created by Jimmy Hoang on 2/22/17.
//  Copyright © 2017 Jimmy Hoang. All rights reserved.
//

import UIKit

class CustomNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationBar.isOpaque = true
        navigationBar.barTintColor = UIColor.white
    }
}
