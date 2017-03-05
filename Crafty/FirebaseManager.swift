//
//  FirebaseManager.swift
//  Crafty
//
//  Created by Jimmy Hoang on 2/22/17.
//  Copyright © 2017 Jimmy Hoang. All rights reserved.
//

import Firebase
import UIKit
import MapKit

class FirebaseManager: NSObject {
    static func handleSubmitProduct(product: Product, viewController controller: UIViewController) {
        guard let category = product.category, let categoryDetail = product.categoryDetail, let title = product.title, let detail = product.detail, let price = product.price, let locationName = product.locationName, let locationAddress = product.locationAddress else { return }
        
        let sellerID = FIRAuth.auth()?.currentUser?.uid
        let ref = FIRDatabase.database().reference().child("products")
        let timestamp = NSNumber(value: Int(Date().timeIntervalSince1970))
        let values: [String: AnyObject] = ["category": category as AnyObject, "categoryDetail": categoryDetail as AnyObject, "title": title as AnyObject, "detail": detail as AnyObject, "price": price as AnyObject, "locationName": locationName as AnyObject, "locationAddress": locationAddress as AnyObject, "timestamp": timestamp, "love": 0 as AnyObject, "sellerID": sellerID as AnyObject]
        
        let childRef = ref.childByAutoId()
        
        childRef.updateChildValues(values) { (error, ref) in
            if error != nil {
                print(error!)
                return
            }
            
            let ac = UIAlertController(title: "Submit Product", message: "Successful", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            controller.present(ac, animated: true, completion: nil)
        }
    }
    
    static func handleLogout() {
        do {
            try! FIRAuth.auth()!.signOut()
        } catch let logoutError {
            print(logoutError)
        }

    }
    
    static func observeProductByCategory(category: String, completion: @escaping (_ result: Bool) -> ()) -> [Product]? {
        guard let uid = FIRAuth.auth()?.currentUser?.uid else { return nil }
        
        var products = [Product]()
        
        let ref = FIRDatabase.database().reference().child("products").queryOrdered(byChild: "category").queryEqual(toValue: "\(category)")
        
        ref.observe(.value, with: { (snapshot) in
            if let dictionary = snapshot.value as? [String: AnyObject] {
                let product = Product()
                product.printAll()
                product.setValuesForKeys(dictionary)
                
                if product.sellerID != uid {
                    products.append(product)
                }
                
                DispatchQueue.main.async {
                    completion(true)
                }
            }
        }) { (error) in
            print("Error observing product by category: \(error)")
            DispatchQueue.main.async {
                completion(false)
            }
        }
        
        return products
    }
}
