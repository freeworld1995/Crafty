//
//  AccountCategoryDataSource.swift
//  Crafty
//
//  Created by Jimmy Hoang on 3/11/17.
//  Copyright © 2017 Jimmy Hoang. All rights reserved.
//

import UIKit

class AccountCategoryDataSource: NSObject, UICollectionViewDataSource {
    
    var categoryTitle = ["Hat", "Clothing", "Bags", "Jewlery", "Art & Collectibles", "Bath & Beauty", "Shoes"]
    
    var categoryImageName = ["hat", "clothing", "bag", "jewelery", "art", "bath", "shoes"]
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryTitle.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(forIndexPath: indexPath) as AccountCategoryCell
        cell.alpha = 0.5
        cell.setupImage(name: categoryImageName[indexPath.item])
        cell.title.text = categoryTitle[indexPath.item]
        return cell
    }
}
