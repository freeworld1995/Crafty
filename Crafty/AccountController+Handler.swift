//
//  AccountController+Handler.swift
//  Crafty
//
//  Created by Jimmy Hoang on 3/2/17.
//  Copyright © 2017 Jimmy Hoang. All rights reserved.
//

import UIKit

extension AccountViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func logout() {
        FirebaseManager.handleLogout()
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "registervc") as? RegisterViewController
        present(vc!, animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 2 - 15, height: 208)
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
}
