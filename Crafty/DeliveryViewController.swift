//
//  DeliveryViewController.swift
//  Crafty
//
//  Created by Jimmy Hoang on 2/18/17.
//  Copyright © 2017 Jimmy Hoang. All rights reserved.
//

import UIKit

class DeliveryViewController: UIViewController {

    @IBOutlet weak var meetupLocation: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar(title: "Delivery")
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupNavigationBar(title: String) {
        self.navigationController?.navigationBar.setup()
        self.navigationItem.title = title
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Apply", style: .plain, target: self, action: #selector(backToCategoryVC))
    }
  
    func backToCategoryVC() {
        self.navigationController?.popToRootViewController(animated: true)
        NotificationCenter.default.post(name: Notification.Name(rawValue: "shareDelivery"), object: nil, userInfo: ["location": meetupLocation.text])
    }

}
