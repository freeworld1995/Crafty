//
//  ItemViewController.swift
//  Crafty
//
//  Created by Jimmy Hoang on 2/18/17.
//  Copyright © 2017 Jimmy Hoang. All rights reserved.
//

import UIKit
import KMPlaceholderTextView

class ItemViewController: UIViewController {

    @IBOutlet weak var itemTitle: UITextField!
    @IBOutlet weak var itemDescription: KMPlaceholderTextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar(title: "Item")
    }

    func setupNavigationBar(title: String) {
        self.navigationController?.navigationBar.setup()
        self.navigationItem.title = title
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Apply", style: .plain, target: self, action: #selector(backToCategoryVC))
    }
    
    func backToCategoryVC() {
        self.navigationController?.popToRootViewController(animated: true)
        NotificationCenter.default.post(name: Notification.Name("shareItem"), object: nil, userInfo: ["title": itemTitle.text, "description": itemDescription.text])
//        if let vc = storyboard?.instantiateViewController(withIdentifier: "SubmitVC") as? CategoryViewController {
//
//        }
    }


}
