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
        setupNavigationBar(title: "Category")
        collectionView.delegate = self
        collectionView.dataSource = dataSource
        collectionView.register(UINib(nibName: "CategoryCell", bundle: nil), forCellWithReuseIdentifier: "categoryCell")
    }
    
    func setupNavigationBar(title: String) {
        self.navigationController?.navigationBar.setup()
        self.navigationItem.title = title
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
        
        //        collectionView.indexPathsForVisibleItems.forEach {
        //            if $0 != indexPath {
        //                let cell = collectionView.cellForItem(at: $0) as! CategoryCell
        //                cell.collectionView.reloadData()
        //            }
        //        }
        
        cell.setHeight()
        cell.play()
        collectionView.performBatchUpdates({
        }) { (_: Bool) in
        }
    }
    
    
}
