//
//  ListProductsViewController.swift
//  Crafty
//
//  Created by Jimmy Hoang on 3/2/17.
//  Copyright © 2017 Jimmy Hoang. All rights reserved.
//

import UIKit

class ListProductsViewController: UIViewController, SetupNavBar, HADropDownDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var dropDownList: HADropDown!

    
    let datasource = ListProductsDataSource()
    var category: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(DemoCell.self)
        collectionView.register(ProductCell.self)
        collectionView.delegate = self
        collectionView.dataSource = datasource
        self.setupNavigationBar(title: category!)
        dropDownList.delegate = self
        dropDownList.items = ["Popularity", "Highest Price", "Lowest Price"]
        
        FirebaseManager.observeProductByCategory(category: category!, viewController: self) { (condition, result) in
            if condition {
                self.datasource.products = result!
                self.collectionView.reloadData()
                self.indicator.stopAnimating()
            }
        }

    }
}


