//
//  ListProductsViewController.swift
//  Crafty
//
//  Created by Jimmy Hoang on 3/2/17.
//  Copyright © 2017 Jimmy Hoang. All rights reserved.
//

import UIKit

class ListProductsViewController: UIViewController, SetupNavBar, HADropDownDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var dropDownList: HADropDown!
    
    let datasource = ListProductsDataSource()
    var pagingViewController: PagingViewController?
    var category: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(DemoCell.self)
        collectionView.register(ProductCell.self)
        collectionView.delegate = self
        collectionView.dataSource = datasource
        self.setupNavigationBar(title: category!)
        dropDownList.delegate = self
        dropDownList.items = ["Popularity", "Highest Price", "Lowest Price"]
        
        FirebaseManager.observeProductByCategory(category: category!, viewController: self) { (condition, result) in
            if condition {
                self.datasource.products = result!
                self.collectionView.reloadData()
                self.indicator.stopAnimating()
            }
        }
        
        FirebaseManager.checkAccountCategory(category: category!) { (result) in
            if result {
                self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Unlike", style: .plain, target: self, action: #selector(self.unlikeCategory))
            } else {
                self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Like", style: .plain, target: self, action: #selector(self.likeCategory))
            }
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleProductVC), name: Notification.Name(rawValue: "productVC"), object: nil)
        
    }
    
    func handleProductVC(notification: Notification) {
        if let result = notification.userInfo?["result"] as? Bool {
            if result {
                FirebaseManager.observeProductByCategory(category: category!, viewController: self) { (condition, result) in
                    if condition {
                        self.datasource.products = result!
                        self.collectionView.reloadData()
                        self.indicator.stopAnimating()
                    }
                }
            }
            
        }
    }
    
    deinit {
        print("ListProduct deinit")
    }
    
    func didSelectItem(dropDown: HADropDown, at index: Int) {
        switch index {
        case 0:
            indicator.isHidden = false
            indicator.startAnimating()
            FirebaseManager.observeSortedProduct(type: .popularity, category: category!, viewController: self, completion: { (condition, result) in
                self.indicator.stopAnimating()
                self.indicator.isHidden = true
                if condition {
                    self.datasource.products = result!
                    self.collectionView.reloadData()
                }
            })
        case 1:
            indicator.isHidden = false
            indicator.startAnimating()
            FirebaseManager.observeSortedProduct(type: .highest, category: category!, viewController: self, completion: { (condition, result) in
                self.indicator.stopAnimating()
                self.indicator.isHidden = true
                if condition {
                    self.datasource.products = result!
                    self.collectionView.reloadData()
                }
            })
        case 2:
            indicator.isHidden = false
            indicator.startAnimating()
            FirebaseManager.observeSortedProduct(type: .lowest, category: category!, viewController: self, completion: { (condition, result) in
                self.indicator.stopAnimating()
                self.indicator.isHidden = true
                if condition {
                    self.datasource.products = result!
                    self.collectionView.reloadData()
                }
            })
        default:
            print("fuck")
        }
    }
}


