//
//  CategoryDetailCollectionView.swift
//  Crafty
//
//  Created by Jimmy Hoang on 2/8/17.
//  Copyright © 2017 Jimmy Hoang. All rights reserved.
//

import UIKit

class CategoryDetailCollectionView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    
    var data = [String]()
    var previousClickedCell: CategoryDetailCell?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        delegate = self
        dataSource = self
        register(UINib(nibName: "CategoryDetailCell", bundle: nil), forCellWithReuseIdentifier: "categoryDetailCell")
        if let flowLayout = self.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = CGSize(width: 1, height: 1)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: "categoryDetailCell", for: indexPath) as! CategoryDetailCell
        cell.title.text = data[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        
                previousClickedCell?.backgroundColor = Color.green
        let cell = collectionView.cellForItem(at: indexPath) as! CategoryDetailCell

        cell.backgroundColor = Color.red
        previousClickedCell = collectionView.cellForItem(at: indexPath) as! CategoryDetailCell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
    }
    
    
}
