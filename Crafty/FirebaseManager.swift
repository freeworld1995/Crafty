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
import SwiftyJSON

class FirebaseManager: NSObject {
    
    static func handleSubmitProductInfo(product: Product, images: [UIImageView], viewController controller: UIViewController) {
        
        // Insert images into Storage -> save images URL
        
        var productImagesURL = [String]()
        
        images.forEach {
            
            let imageName = UUID().uuidString
            
            let storageRef = FIRStorage.storage().reference().child("product_images").child("\(imageName).png")
            
            if let productImage = $0.image, let uploadData = UIImageJPEGRepresentation(productImage, 0.1) {
                
                storageRef.put(uploadData, metadata: nil, completion: { (metadata, error) in
                    if error != nil {
                        print(error as Any)
                        return
                    }
                    
                    if let productImageURL = metadata?.downloadURL()?.absoluteString {
                        productImagesURL.append(productImageURL)
                    }
                    
                    if productImagesURL.count == 3 {
                        
                        // Start inserting product's info into Database
                        
                        guard let category = product.category, let categoryDetail = product.categoryDetail, let title = product.title, let detail = product.detail, let price = product.price, let locationName = product.locationName, let locationAddress = product.locationAddress, let love = 0 as? NSNumber else { return }
                        
                        let sellerID = FIRAuth.auth()?.currentUser?.uid
                        let ref = FIRDatabase.database().reference().child("products")
                        let timestamp = NSNumber(value: Int(Date().timeIntervalSince1970))
                        let values: [String: AnyObject] = ["category": category as AnyObject, "categoryDetail": categoryDetail as AnyObject, "title": title as AnyObject, "detail": detail as AnyObject, "price": price as AnyObject, "images": productImagesURL as AnyObject, "locationName": locationName as AnyObject, "locationAddress": locationAddress as AnyObject, "timestamp": timestamp, "love": love as AnyObject, "sellerID": sellerID as AnyObject]
                        
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
                    
                })
            }
        }
        
    }
    
    static func handleLogout() {
        do {
            try? FIRAuth.auth()!.signOut()
        } catch let logoutError {
            print(logoutError)
        }
        
    }
    
    static func observeProductByCategory(category: String, completion: @escaping (_ result: Bool) -> ()) -> [Product]? {
        guard let uid = FIRAuth.auth()?.currentUser?.uid else { return nil }
        
        var products = [Product]()
        
        let ref = FIRDatabase.database().reference().child("products").queryOrdered(byChild: "category").queryEqual(toValue: "\(category)")
        
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            
            if let dictionary = snapshot.value as? [String: AnyObject] {
                dictionary.forEach {
                    print($0.value)
                    let product = Product()
                    product.setValuesForKeys($0.value as! [String : AnyObject])
                    print(product.printAll())
                    //                    if product.sellerID != uid {
                    products.append(product)
                    //                    }
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
        print("asshole: \(products.count)")
        
        return products
        
    }
    
    static func getUser(byID userID : String, completion: @escaping (User) -> ()) {
        
        let userRef = FIRDatabase.database().reference().child("users").child(userID)
        
        userRef.observeSingleEvent(of: .value, with: { (snapshot) in
            if let dictionnary = snapshot.value as? [String: AnyObject] {
                let user = User()
                
                user.setValuesForKeys(dictionnary)
                DispatchQueue.main.async {
                    completion(user)
                }
            }
        }) { (error) in
            print("Get user error: \(error)")
        }
    }
}
