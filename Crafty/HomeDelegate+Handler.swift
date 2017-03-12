//
//  HomeDelegate+Handler.swift
//  Crafty
//
//  Created by Jimmy Hoang on 3/2/17.
//  Copyright © 2017 Jimmy Hoang. All rights reserved.
//

import UIKit

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.item {
        case 0, 2:
            return CGSize(width: self.view.frame.width, height: 40)
        case 1:
            return CGSize(width: self.view.frame.width - 50, height: 150)
        default:
            return CGSize(width: self.view.frame.width / 2 - 20, height: 108)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        cell.alpha = 0
        
        UIView.animate(withDuration: 0.8) {
            cell.alpha = 1.0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.row {
        case 3:
            _ = storyboard?.instantiateViewController(withIdentifier: "productVC")
        default:
            let cell = collectionView.cellForItem(at: indexPath) as! HomeCategoryCell
            goToListProductVC(category: cell.title.text!)
        }
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
    
    func goToListProductVC(category: String) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "productVC") as! ListProductsViewController
        vc.pagingViewController = pagingViewController
        vc.category = category
        pagingViewController!.navigationController?.pushViewController(vc, animated: true)
    }
}
