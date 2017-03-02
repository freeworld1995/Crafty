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
    
    var selectedCategory: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar(title: "Category")
        collectionView.delegate = self
        collectionView.dataSource = dataSource
        collectionView.register(CategoryContainerCell.self)
    }
    
    func setupNavigationBar(title: String) {
        self.navigationController?.navigationBar.setup()
        self.navigationItem.title = title
    }
    
    deinit {
        print("CategoryVC deinit")
        if selectedCategory != nil {
            NotificationCenter.default.post(name: Notification.Name(rawValue: "shareCategory"), object: nil, userInfo: ["title": selectedCategory!])
        }
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
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! CategoryContainerCell
        
        selectedCategory = cell.categoryLabel.text
        
        cell.setHeight()
        cell.play()
        collectionView.performBatchUpdates({
        }) { (_: Bool) in
        }
    }
    
    
}
