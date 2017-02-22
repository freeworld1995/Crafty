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
    
    /**
     Get notification from CategoryCell & update label "categoryDetail"
     */
    func handleUpdateCategoryDetail(notification: Notification) {
        if let category = notification.userInfo?["title"] as? String {
            let indexPath = IndexPath(row: 0, section: 0)
            let cell = tableView.cellForRow(at: indexPath) as! CategoryTableViewCell
            cell.categoryDetail.text = category
            product.category = category
        }
    }
    
    func handleUpdateItemDetail(notification: Notification) {
        if let title = notification.userInfo?["title"] as? String, let detail = notification.userInfo?["description"] as? String  {
            let indexPath = IndexPath(row: 1, section: 0)
            let cell = tableView.cellForRow(at: indexPath) as! ItemTableViewCell
            cell.itemDetail.text = title
            product.title = title
            product.detail = detail

        }
    }
    
    func handleUpdateDelivery(notification: Notification) {
        if let location = notification.userInfo?["location"] as? String {
            product.meetupLocation = location
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
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    func cancelButtonDidPress(_ imagePicker: ImagePickerController) {
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
}
