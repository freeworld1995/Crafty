//
//  BaseViewController.swift
//  Crafty
//
//  Created by Jimmy Hoang on 2/18/17.
//  Copyright © 2017 Jimmy Hoang. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupNavigationBar(title: String) {
        self.navigationController?.navigationBar.setup()
        self.navigationItem.title = title
    }

}
