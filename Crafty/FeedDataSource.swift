//
//  FeedDataSource.swift
//  Crafty
//
//  Created by Jimmy Hoang on 3/11/17.
//  Copyright © 2017 Jimmy Hoang. All rights reserved.
//

import UIKit
import SDWebImage

class FeedDataSource: NSObject, UICollectionViewDataSource {
    
    var products: [Product] = []
    let nf = NumberFormatter()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(forIndexPath: indexPath) as FeedCell
        let product = products[indexPath.row]
        cell.productImage.sd_setImage(with: URL(string: product.images[0]))
        if let seconds = product.timestamp?.doubleValue {
            let timestampDate = Date(timeIntervalSince1970: seconds)
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "hh:mm:ss a"
            
            cell.feedTime.text = dateFormatter.string(from: timestampDate)
        }
        
        FirebaseManager.getUser(byID: product.sellerID!) { (user) in
            cell.userImage.sd_setImage(with: URL(string: user.profileImageUrl!))
            
            let formattedString = NSMutableAttributedString()
            cell.feedDetail.attributedText = formattedString.bold(product.title!).normal(" has been posted by ").bold(user.name!)
        }
        
        return cell
    }
}
