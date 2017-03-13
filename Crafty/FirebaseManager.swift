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
    
    enum SortingType {
        case popularity
        case highest
        case lowest
    }
    
    static func handleSubmitProductInfo(product: Product, images: [UIImageView], viewController controller: UIViewController, completion: @escaping () -> ()) {
        
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
                        

                        guard let category = product.category, let categoryDetail = product.categoryDetail, let title = product.title, let detail = product.detail, let price = product.price, let locationName = product.locationName, let locationAddress = product.locationAddress, let peopleWhoLike = product.peopleWhoLike, let love = 0 as? NSNumber else { return }

                        let sellerID = FIRAuth.auth()?.currentUser?.uid
                        let ref = FIRDatabase.database().reference().child("products")
                        let timestamp = NSNumber(value: Int(Date().timeIntervalSince1970))
                        
                        let childRef = ref.childByAutoId()
                        let values: [String: AnyObject] = ["category": category as AnyObject, "categoryDetail": categoryDetail as AnyObject, "title": title as AnyObject, "detail": detail as AnyObject, "price": price as AnyObject, "images": productImagesURL as AnyObject, "locationName": locationName as AnyObject, "locationAddress": locationAddress as AnyObject, "timestamp": timestamp, "love": love as AnyObject, "sellerID": sellerID as AnyObject, "peopleWhoLike": peopleWhoLike as AnyObject, "productID": childRef.key as AnyObject]

                        childRef.updateChildValues(values) { (error, ref) in
                            if error != nil {
                                print(error!)
                                return
                            }
                            
                            let categoryRef = FIRDatabase.database().reference().child("productCategory").child(category).child(ref.key)
                            
                            categoryRef.updateChildValues(values, withCompletionBlock: { (error, ref) in
                                if error != nil {
                                    print(error!)
                                    return
                                }
                                // Complete denormalize
                            })
                            
                            let userProductRef = FIRDatabase.database().reference().child("userProducts").child(sellerID!).child(ref.key)
                            
                            userProductRef.updateChildValues(values, withCompletionBlock: { (error, ref) in
                                if error != nil {
                                    print(error!)
                                    return
                                }
                                // Complete denormalize
                            })
                            
                            DispatchQueue.main.async {
                                completion() // reload tableview at viewController
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
    
    static func observeProductByCategory(category: String, viewController controller: UIViewController, completion: @escaping (_ result: Bool, _ productList: [Product]?) -> ()) {
        guard let userID = FIRAuth.auth()?.currentUser?.uid else { return }
        
        var products = [Product]()
        
        let ref = FIRDatabase.database().reference().child("products").queryOrdered(byChild: "category").queryEqual(toValue: "\(category)")
        
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            if let dictionary = snapshot.value as? [String: AnyObject] {
                dictionary.forEach {
                    let product = Product()
                    product.setValuesForKeys($0.value as! [String : AnyObject])
                    if product.sellerID != userID {
                        products.append(product)
                    }
                }
                
                DispatchQueue.main.async {
                    completion(true, products)
                }
            }
        }) { (error) in
            DispatchQueue.main.async {
                completion(false, nil)
                
                let ac = UIAlertController(title: "Error", message: "Something wrong happen, please try again", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                controller.present(ac, animated: true, completion: nil)
            }
        }
    }
    
    static func observeSortedProduct(type: SortingType, category: String, viewController controller: UIViewController, completion: @escaping (_ result: Bool, _ productList: [Product]?) -> ()) {
        guard FIRAuth.auth()?.currentUser?.uid != nil else { return }
        
        var products = [Product]()
        
        let ref = FIRDatabase.database().reference().child("productCategory").child(category)
        
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            if let dictionary = snapshot.value as? [String: AnyObject] {
                dictionary.forEach {
                    let product = Product()
                    product.setValuesForKeys($0.value as! [String : AnyObject])
                    
                    //                    if product.sellerID != uid {
                    products.append(product)
                    //                    }
                }
                
                if type == .highest {
                    products.sort(by: { (p1, p2) -> Bool in
                        return p1.price!.doubleValue > p2.price!.doubleValue
                    })
                } else if type == .lowest {
                    products.sort(by: { (p1, p2) -> Bool in
                        return p1.price!.doubleValue < p2.price!.doubleValue
                    })
                } else {
                    products.sort(by: { (p1, p2) -> Bool in
                        return p1.love!.intValue > p2.love!.intValue
                    })
                }
                
                DispatchQueue.main.async {
                    completion(true, products)
                }
            }
            
        }, withCancel: { (error) in
            print("error while filtering: \(error)")
            
            DispatchQueue.main.async {
                completion(false, nil)
                
                let ac = UIAlertController(title: "Error", message: "Something wrong happen, please try again", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                controller.present(ac, animated: true, completion: nil)
            }
            
        })
        
    }
    
    static func observeProductByUser(userID: String, viewController controller: UIViewController, completion: @escaping (_ result: Bool, _ productList: [Product]?) -> ()) {
        guard FIRAuth.auth()?.currentUser?.uid != nil else { return }
        
        var products = [Product]()
        
        let ref = FIRDatabase.database().reference().child("userProducts").queryEqual(toValue: userID)
        
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            if let dictionary = snapshot.value as? [String: AnyObject] {
                dictionary.forEach {
                    let product = Product()
                    product.setValuesForKeys($0.value as! [String : AnyObject])
                    products.append(product)
                }
                
                DispatchQueue.main.async {
                    completion(true, products)
                }
            }
        }) { (error) in
            print("fetch user products error: \(error)")
            
            DispatchQueue.main.async {
                completion(false, nil)
                
                let ac = UIAlertController(title: "Error", message: "Something wrong happen, please try again", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                controller.present(ac, animated: true, completion: nil)
            }
            
        }
        
    }
    
    static func getUser(byID userID : String, completion: @escaping (User) -> ()) {
        
        let userRef = FIRDatabase.database().reference().child("users").child(userID)
        
        userRef.observeSingleEvent(of: .value, with: { (snapshot) in
            if let dictionnary = snapshot.value as? [String: AnyObject] {
                let user = User()
                
                user.setValuesForKeys(dictionnary)
                user.id = snapshot.key
                DispatchQueue.main.async {
                    completion(user)
                }
            }
        }) { (error) in
            print("Get user error: \(error)")
        }
        
    }
    
    static func observeUser(byID userID : String, name: UILabel, city: UILabel, email: UILabel) {
        let userRef = FIRDatabase.database().reference().child("users").child(userID)
        
        
        userRef.observe(.value, with: { (snapshot) in
            if let dictionnary = snapshot.value as? [String: AnyObject] {
                let user = User()
                
                user.setValuesForKeys(dictionnary)
                user.id = snapshot.key
                name.text =  user.name
                city.text = user.city
                email.text = user.email
            }
        })
        
    }
    
    static func observeFeed(userID: String, viewController controller: UIViewController, completion: @escaping (_ result: Bool, _ productList: [Product]?) -> ()) {
        
        guard let userID = FIRAuth.auth()?.currentUser?.uid else { return }
        
        var products = [Product]()
        
        getUser(byID: userID) { (user) in
            user.accountCategory?.forEach {
                let productRef = FIRDatabase.database().reference().child("productCategory").child($0)
                
                productRef.observeSingleEvent(of: .value, with: { (snapshot) in
                    if let dictionary = snapshot.value as? [String: AnyObject] {
                        dictionary.forEach {
                            let product = Product()
                            product.setValuesForKeys($0.value as! [String : AnyObject])
                            
                            if product.sellerID != userID {
                                products.append(product)
                            }
                        }
                    }
                    products.sort(by: { (p1, p2) -> Bool in
                        return p1.timestamp!.doubleValue > p2.timestamp!.doubleValue
                    })
                    completion(true, products)
                })
            }
            
        }
    }
    
    static func checkAccountCategory(category: String, completion: @escaping (Bool) -> ()) {
        let userID = FIRAuth.auth()?.currentUser?.uid
        
        let ref = FIRDatabase.database().reference().child("users").child(userID!).child("accountCategory")
        
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            var result = false
            
            if let array = snapshot.value as? [String] {
                array.forEach {
                    if $0 == category {
                        result = true
                        
                        return
                    }
                }
            }
            
            completion(result)
            
        }) { (error) in
            print("error checking account cateogry: \(error)")
        }
    }
    
    static func handleLogout() {
        do {
            try? FIRAuth.auth()!.signOut()
        } catch let logoutError {
            print(logoutError)
        }
        
    }
}
