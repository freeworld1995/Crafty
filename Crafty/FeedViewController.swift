//
//  FeedViewController.swift
//  Crafty
//
//  Created by Jimmy Hoang on 3/11/17.
//  Copyright © 2017 Jimmy Hoang. All rights reserved.
//

import UIKit
import Firebase

class FeedViewController: UIViewController, SetupNavBar {
    @IBOutlet weak var collectionView: UICollectionView!
    
    let datasource = FeedDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(FeedCell.self)
        collectionView.dataSource = datasource
        collectionView.delegate = self
        self.setupNavigationBar(title: "Feeds")
        self.navigationController?.navigationBar.isTranslucent = false

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let userID = FIRAuth.auth()?.currentUser?.uid
        FirebaseManager.observeFeed(userID: userID!, viewController: self) { (condition, result) in
            if condition {
                print(result)
                self.datasource.products = result!
                self.collectionView.reloadData()
            }
        }
    }
    
    
    
}
