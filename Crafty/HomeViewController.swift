//
//  HomeViewController.swift
//  Crafty
//
//  Created by Jimmy Hoang on 2/5/17.
//  Copyright © 2017 Jimmy Hoang. All rights reserved.
//

import UIKit
import Firebase
import XLPagerTabStrip

class HomeViewController: UIViewController, IndicatorInfoProvider {
    @IBOutlet weak var collectionView: UICollectionView!
    
    let datasource = HomeDataSource()
    
    var pagingViewController: PagingViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = datasource
        collectionView.delegate = self
        collectionView.register(HighlightCollectionViewCell.self)
        collectionView.register(SectionLabelCell.self)
        collectionView.register(HomeCategoryCell.self)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print(FIRAuth.auth()?.currentUser?.uid)
        checkIfUserIsLoggedIn()
    }
    
    override func awakeFromNib() {
    }
    
    func checkIfUserIsLoggedIn() {
        if FIRAuth.auth()?.currentUser?.uid == nil {
            performSelector(onMainThread: #selector(handleLogout), with: nil, waitUntilDone: false)
        }
    }
    
    func handleLogout() {
        
        do {
            try FIRAuth.auth()!.signOut()
        } catch let logoutError {
            print(logoutError)
        }
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "registervc") as! RegisterViewController
        present(vc, animated: true, completion: nil)
    }
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "Suggestion")
    }
    
}


