//
//  AccountViewController.swift
//  Crafty
//
//  Created by Jimmy Hoang on 3/2/17.
//  Copyright © 2017 Jimmy Hoang. All rights reserved.
//

import UIKit
import Firebase
import SDWebImage

class AccountViewController: UIViewController, SetupNavBar {
    
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    
    @IBOutlet weak var userProfileImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userCity: UILabel!
    @IBOutlet weak var userEmail: UILabel!
    
    let datasource = AccountDataSource()
    let accountCategoryDatasource = AccountCategoryDataSource()
    
    var accountCategories: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        categoryCollectionView.register(AccountCategoryCell.self)
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = accountCategoryDatasource
        
        userProfileImage.layer.cornerRadius = userProfileImage.frame.width / 2
        userProfileImage.layer.masksToBounds = true
        
        self.setupNavigationBar(title: "Account")
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logout))
        
        
        //        FirebaseManager.observeProductByUser(userID: userID!, viewController: self) { (condition, result) in
        //            if condition {
        //                self.datasource.products = result!
        //            }
        //        }

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        FirebaseManager.getUser(byID: FIRAuth.auth()!.currentUser!.uid) { (user) in
            self.userProfileImage.sd_setImage(with: URL(string: user.profileImageUrl!))
            self.userName.text = user.name
            self.userCity.text = user.city
            self.userEmail.text = user.email
        }
    }
    
    
}
