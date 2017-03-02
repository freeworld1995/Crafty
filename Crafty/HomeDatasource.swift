//
//  HomeDatasource.swift
//  Crafty
//
//  Created by Jimmy Hoang on 3/1/17.
//  Copyright © 2017 Jimmy Hoang. All rights reserved.
//

import UIKit

class HomeDataSource: NSObject, UICollectionViewDataSource {
    
    var categoryTitle = ["Editor\'s choice", "Hat", "Clothing", "Bags", "Jewlery", "Art & Collectibles", "Bath & Beauty", "Shoes"]
    
    var categoryImageName = ["editorChoice", "hat", "clothing", "bag", "jewelery", "art", "bath", "shoes"]
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryTitle.count + 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.item {
        case 0:
            let cell = collectionView.dequeueReusableCell(forIndexPath: indexPath) as SectionLabelCell
            cell.title.text = "Stuffs people love"
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(forIndexPath: indexPath) as HighlightCollectionViewCell
            return cell
        case 2:
            let cell = collectionView.dequeueReusableCell(forIndexPath: indexPath) as SectionLabelCell
            cell.title.text = "Category"
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(forIndexPath: indexPath) as HomeCategoryCell
            cell.setupImage(name: categoryImageName[indexPath.item - 3])
            cell.title.text = categoryTitle[indexPath.item - 3]
            return cell
        }
    }
}
