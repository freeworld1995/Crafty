//
//  ListProductsDataSource.swift
//  Crafty
//
//  Created by Jimmy Hoang on 3/2/17.
//  Copyright © 2017 Jimmy Hoang. All rights reserved.
//

import Firebase
import SDWebImage

class ListProductsDataSource: NSObject, UICollectionViewDataSource {
    
    var products: [Product] = []
    let nf = NumberFormatter()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(forIndexPath: indexPath) as ProductCell
        let product = products[indexPath.row]
       
//        cell.title.text = product.title
        
        cell.productTitle.text = product.title
        cell.productPrice.text =  "\(nf.string(from: product.price!)!) VND"
        cell.productImage.sd_setImage(with: URL(string: product.images[0]))
        cell.userID = product.sellerID
        cell.loveCount.text = nf.string(from: product.love!)
        
        return cell 
    }
    
//    func getListProduct(category: String, collectionView: UICollectionView, viewController controller: UIViewController) {
//        FirebaseManager.observeProductByCategory(category: category, products: products) { (result) in
//            if result {
//                collectionView.reloadData()
//            } else {
//                let ac = UIAlertController(title: "Error", message: "Cannot get data", preferredStyle: .alert)
//                ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
//                controller.present(ac, animated: true, completion: nil)
//            }
//        }
//        
//        print("fuck product: \(products.count)")
//    }
    
    func getData(category: String, collectionView: UICollectionView, viewController controller: UIViewController, completion: @escaping () -> ()) {
        let ref = FIRDatabase.database().reference().child("products").queryOrdered(byChild: "category").queryEqual(toValue: "\(category)")
        
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            
            if let dictionary = snapshot.value as? [String: AnyObject] {
                dictionary.forEach {
                    print($0.value)
                    let product = Product()
                    product.setValuesForKeys($0.value as! [String : AnyObject])
                    print(product.printAll())
                    //                    if product.sellerID != uid {
                    self.products.append(product)
                    //                    }
                }
                
                DispatchQueue.main.async {
                    completion()
                }
            }
            
        }) { (error) in
            print("Error observing product by category: \(error)")
        }

    }
}
