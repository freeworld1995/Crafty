//
//  AccountDataSource.swift
//  Crafty
//
//  Created by Jimmy Hoang on 3/2/17.
//  Copyright © 2017 Jimmy Hoang. All rights reserved.
//

import UIKit
import Firebase

class AccountDataSource: NSObject, UICollectionViewDataSource {
    
    var products: [Product] = []
    let nf = NumberFormatter()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(forIndexPath: indexPath) as ProductCell
        let product = products[indexPath.row]
        cell.productTitle.text = product.title
        cell.productPrice.text =  "\(nf.string(from: product.price!)!) VND"
        cell.productImage.sd_setImage(with: URL(string: product.images[0]))
        cell.userID = product.sellerID
        cell.loveCount.text = nf.string(from: product.love!)
        
        return cell
    }
}
