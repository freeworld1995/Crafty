//
//  ListProductsDataSource.swift
//  Crafty
//
//  Created by Jimmy Hoang on 3/2/17.
//  Copyright © 2017 Jimmy Hoang. All rights reserved.
//

import UIKit

class ListProductsDataSource: NSObject, UICollectionViewDataSource {
    
    var products: [Product] = []
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(forIndexPath: indexPath) as ProductCell
        cell.productTitle.text = products[indexPath.row].title
        return cell 
    }
    
    func getListProduct(category: String, collectionView: UICollectionView, viewController controller: UIViewController) {
        products = FirebaseManager.observeProductByCategory(category: category) { (result) in
            if result {
                collectionView.reloadData()
            } else {
                let ac = UIAlertController(title: "Error", message: "Cannot get data", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                controller.present(ac, animated: true, completion: nil)
            }
        }!
    }
}
