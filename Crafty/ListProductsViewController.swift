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
        collectionView.delegate = self
        collectionView.dataSource = datasource
        datasource.getListProduct(category: category!, collectionView: collectionView, viewController: self)
        collectionView.register(ProductCell.self)
        
    }
}

extension ListProductsViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
}
