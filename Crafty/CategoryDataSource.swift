//
//  CategoryDataSource.swift
//  Crafty
//
//  Created by Jimmy Hoang on 2/6/17.
//  Copyright © 2017 Jimmy Hoang. All rights reserved.
//

import UIKit

class CategoryDataSource: NSObject, UICollectionViewDataSource {
    
    var category = ["Hat", "Clothing", "Bags", "Jewelry", "Art & Collectibles", "Bath & Beauty", "Shoes"]
    var hatDetails = ["Cap", "Wool hat", "Leather hat", "Water-proof hat"]
    var clothingDetails = ["Hoodie", "T-shirt", "Polo", "Office", "Jacket"]
    var bagDetails = ["Handbag", "Pouch", "Wallet", "Backpack", "Messenger bag"]
    var jeweleryDetails = ["Necklace", "Earring", "Bracelet", "Ring", "Watch"]
    var artDetails = ["Photography", "Painting", "Sculpture", "Mininature", "Doll"]
    var bathDetails = ["Soap", "Skin care", "Hair care", "Fragrance", "Makeup"]
    var shoesDetails = ["Sandal", "Boot", "Sneaker", "Slip on", "High heel"]
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(forIndexPath: indexPath) as CategoryContainerCell

        cell.categoryLabel.text = category[indexPath.item]
        
        switch indexPath.row {
        case 0:
            cell.collectionView.data = hatDetails
        case 1:
            cell.collectionView.data = clothingDetails
        case 2:
            cell.collectionView.data = bagDetails
        case 3:
            cell.collectionView.data = jeweleryDetails
        case 4:
            cell.collectionView.data = artDetails
        case 5:
            cell.collectionView.data = bathDetails
        case 6:
            cell.collectionView.data = shoesDetails
        default:
            print("Category data error")
        }
        
        cell.collectionView.reloadData()
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return category.count
    }
}
