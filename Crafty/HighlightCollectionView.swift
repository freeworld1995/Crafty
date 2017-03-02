//
//  HighlightCollectionView.swift
//  Crafty
//
//  Created by Jimmy Hoang on 3/1/17.
//  Copyright © 2017 Jimmy Hoang. All rights reserved.
//

import UIKit

class HighlightCollectionView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var images = [UIImage]()
    
    var names = ["elon", "hillary", "mark", "merkel", "obama", "putin", "taylor", "trump"]
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        register(HightlightPhotoCell.self)
        delegate = self
        dataSource = self
        getData()
    }
    
    func getData() {
        for name in names {
            let image = UIImage(named: name)
            images.append(image!)
        }
        print(images.count)
    }
    
    deinit {
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(forIndexPath: indexPath) as HightlightPhotoCell
        cell.image.image = images[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    //
    //    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    //        return 8
    //    }
    //
    //    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    //        return 12
    //    }
    //
    //    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    //        return UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
    //    }
    //
}
