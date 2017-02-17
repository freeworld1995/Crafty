//
//  CategoryViewController.swift
//  Crafty
//
//  Created by Jimmy Hoang on 2/6/17.
//  Copyright © 2017 Jimmy Hoang. All rights reserved.
//

import UIKit

class CategoryViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    let dataSource = CategoryDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = dataSource
        collectionView.register(UINib(nibName: "CategoryCell", bundle: nil), forCellWithReuseIdentifier: "categoryCell")
//        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
//            flowLayout.estimatedItemSize = CGSize(width: 1, height: 1)
//        }
    }

}

extension CategoryViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView.indexPathsForSelectedItems?.first {
        case .some(indexPath):
            return CGSize(width: self.view.frame.size.width, height: 150)
        default:
            return CGSize(width: self.view.frame.size.width, height: 50)
        }
        //         cells[indexPath.row].
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! CategoryCell
        
        cell.setHeight()
        cell.play()
        collectionView.performBatchUpdates({
        }) { (_: Bool) in
        }
    }
    
    
}
