//
//  SubmitProductController+Handler.swift
//  Crafty
//
//  Created by Jimmy Hoang on 2/18/17.
//  Copyright © 2017 Jimmy Hoang. All rights reserved.
//

import UIKit
import ImagePicker

extension SubmitProductViewController {
    
    // MARK: Handle notification from all ViewController send back to SubmitProductViewController
    
    /**
     Get notification from CategoryCell & update label "categoryDetail"
     */
    func handleUpdateCategoryDetail(notification: Notification) {
        if let categoryDetail = notification.userInfo?["title"] as? String {
            let indexPath = IndexPath(row: 0, section: 0)
            let cell = tableView.cellForRow(at: indexPath) as! CategoryTableViewCell
            cell.categoryDetail.text = categoryDetail
            product?.categoryDetail = categoryDetail
            checkSubmitCondition()
        }
    }
    
    func handleUpdateCategory(notification: Notification) {
        if let category = notification.userInfo?["title"] as? String {
            let indexPath = IndexPath(row: 0, section: 0)
            let cell = tableView.cellForRow(at: indexPath) as! CategoryTableViewCell
            product?.category = category
            cell.categoryDetail.text = category
            checkSubmitCondition()
        }
    }
    
    func handleUpdateItemDetail(notification: Notification) {
        if let title = notification.userInfo?["title"] as? String, let detail = notification.userInfo?["description"] as? String  {
            product?.title = title
            product?.detail = detail
            
            let indexPath = IndexPath(row: 1, section: 0)
            let cell = tableView.cellForRow(at: indexPath) as! ItemTableViewCell
            cell.itemDetail.text = title
            checkSubmitCondition()
        }
    }
    
    func handleUpdateDelivery(notification: Notification) {
        if let locationName = notification.userInfo?["locationName"] as? String, let locationAddress = notification.userInfo?["locationAddress"] as? String {
            product?.locationName = locationName
            product?.locationAddress = locationAddress
            
            let indexPath = IndexPath(row: 3, section: 0)
            let cell = tableView.cellForRow(at: indexPath) as! DeliveryTableViewCell
            cell.deliveryDetail.text = locationName
            checkSubmitCondition()
        }
    }
    
    // MARK: Handle ImagePicker for product images
    
    /**
     Show image picker when image pressed
     - Parameter gesture: Type of gesture: Tap Gesture
     */
    func handleSelectProductImages(gesture: UITapGestureRecognizer) {
        let picker = ImagePickerController()
        picker.imageLimit = 3
        picker.delegate = self
        
        present(picker, animated: true)
    }
    
    func wrapperDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
        print("wrapper did press")
    }
    
    func doneButtonDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
        for i in 0...2 {
            imageCollection[i].image = images[i]
        }
        imagePicker.dismiss(animated: true) {
            UIView.animate(withDuration: 0.9, delay: 0.1, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.4, options: .curveEaseOut, animations: {
                self.rightImageContraint.constant = 16
                self.leftImageContraint.constant = 16
                self.imageCollection.forEach {
                    self.setImageShadow(image: $0)
                }
                
                self.view.layoutIfNeeded()
            }, completion: { (success) in
            })
            
        }
    }
    
    func cancelButtonDidPress(_ imagePicker: ImagePickerController) {
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    func setImageShadow(image: UIImageView) {
        image.layer.masksToBounds = false
        image.layer.shadowOffset = CGSize.zero
        image.layer.shadowColor = UIColor.black.cgColor
        image.layer.shadowOpacity = 0.5
        image.layer.shadowRadius = 2
    }
    
    func resetImageShadow(image: UIImageView) {
        image.layer.masksToBounds = true
        image.layer.shadowOffset = CGSize.zero
        image.layer.shadowOpacity = 0.0
        image.layer.shadowRadius = 0.0
    }
    
    func checkSubmitCondition() {
        let mirror = Mirror(reflecting: product)
        
        var condition = false
        
        for child in mirror.children {
            let value: Any = child.value
            
            let subMirror = Mirror(reflecting: value)
            
            if subMirror.displayStyle == .optional {
                if subMirror.children.count == 0 {
                    condition = false
                    print("\(child) - nil")
                    break
                } else {
                    print("\(child) - not nil")
                    condition = true
                }
            }
        }
        
        print(condition)
        
        if condition {
            self.navigationItem.rightBarButtonItem?.isEnabled = true
        } else {
            self.navigationItem.rightBarButtonItem?.isEnabled = false
        }
    }
}
