//
//  SetupNavBar.swift
//  Crafty
//
//  Created by Jimmy Hoang on 3/8/17.
//  Copyright © 2017 Jimmy Hoang. All rights reserved.
//

import UIKit

protocol SetupNavBar { }

extension SetupNavBar where Self: UIViewController{
    func setupNavigationBar(title: String) {
        self.navigationController?.navigationBar.setup()
        self.navigationItem.title = title
    }
}
