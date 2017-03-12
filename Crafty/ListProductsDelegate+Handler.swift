//
//  ListProductsDelegate+Handler.swift
//  Crafty
//
//  Created by Jimmy Hoang on 3/6/17.
//  Copyright © 2017 Jimmy Hoang. All rights reserved.
//

import UIKit
import Firebase

extension ListProductsViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width / 2 - 20, height: 208)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 12, left: 12, bottom: 0, right: 12)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = UIStoryboard(name: "bach", bundle: nil).instantiateViewController(withIdentifier: "productVC") as? ProductViewController
        vc?.product = datasource.products[indexPath.item]
        self.pagingViewController?.present(vc!, animated: true, completion: nil)
    }
}

//MARK: Handler

extension ListProductsViewController {
    func likeCategory() {
        
        let userID = FIRAuth.auth()?.currentUser?.uid
        
        let ref = FIRDatabase.database().reference().child("users").child(userID!)
        
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            if snapshot.hasChild("accountCategory") {
                
                
                ref.child("accountCategory").observeSingleEvent(of: .value, with: { (snapshot) in
                    
                    var categoryArray = [String]()
                    print(snapshot.value)
                    if let array = snapshot.value as? [String] {
                        array.forEach {
                            categoryArray.append($0)
                        }
                    }
                    
                    categoryArray.append(self.category!)
                    
                    ref.updateChildValues(["accountCategory" : categoryArray], withCompletionBlock: { (error, ref) in
                        if error != nil {
                            print(error!)
                            return
                        }
                        // complete
                        
                        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Unlike", style: .plain, target: self, action: #selector(self.unlikeCategory))
                    })
                    
                })
                
            } else {
                
                var categoryArray = [String]()
                categoryArray.append(self.category!)
                ref.updateChildValues(["accountCategory" : categoryArray], withCompletionBlock: { (error, ref) in
                    if error != nil {
                        print(error!)
                        return
                    }
                    //complete
                    
                    self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Unlike", style: .plain, target: self, action: #selector(self.unlikeCategory))
                })
            }
        })
        
    }
    
    func unlikeCategory() {
        
        let userID = FIRAuth.auth()?.currentUser?.uid
        
        let ref = FIRDatabase.database().reference().child("users").child(userID!)
        
        ref.child("accountCategory").observeSingleEvent(of: .value, with: { (snapshot) in
            if var categoryArray = snapshot.value as? [String] {
                for (index, item) in categoryArray.enumerated() {
                    if item == self.category! {
                        categoryArray.remove(at: index)
                    }
                }
                
                ref.updateChildValues(["accountCategory" : categoryArray], withCompletionBlock: { (error, ref) in
                    if error != nil {
                        print(error!)
                        return
                    }
                    // complete
                    
                    self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Like", style: .plain, target: self, action: #selector(self.likeCategory))
                })
            }
        })
    }
}

