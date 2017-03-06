//
//  ListProductsViewController.swift
//  Crafty
//
//  Created by Jimmy Hoang on 3/2/17.
//  Copyright © 2017 Jimmy Hoang. All rights reserved.
//

import UIKit

class ListProductsViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let datasource = ListProductsDataSource()
    var category: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(DemoCell.self)
        collectionView.register(ProductCell.self)
        collectionView.delegate = self
        collectionView.dataSource = datasource
        datasource.getData(category: category!, collectionView: collectionView, viewController: self) {
            self.collectionView.reloadData()
        }

    }
}


