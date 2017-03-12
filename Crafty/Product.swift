//
//  Item.swift
//  Crafty
//
//  Created by Jimmy Hoang on 2/3/17.
//  Copyright © 2017 Jimmy Hoang. All rights reserved.
//

import Firebase

class Product: NSObject {
    var category: String?
    var categoryDetail: String?
    var title: String?
    var detail: String?
    var price: NSNumber?
    var locationName: String?
    var locationAddress: String?
    var love: NSNumber?
    var timestamp: NSNumber?
    var sellerID: String?
    var images: [String]
    var userID: String?
    var peopleWhoLike: [String]? = [String]()
    var productID: String?
    
    override init() {
        category = nil
        categoryDetail = nil
        title = nil
        detail = nil
        price = 0
        locationName = nil
        locationAddress = nil
        love = 0
        timestamp = 0
        sellerID = ""
        images = []
        userID = ""
        productID = ""
        peopleWhoLike = []
    }
    
    func resetAll() {
        category = nil
        categoryDetail = nil
        title = nil
        detail = nil
        price = 0
        locationName = nil
        locationAddress = nil
        love = 0
        timestamp = 0
        sellerID = ""
        images = []
        userID = ""
        productID = "" 
        peopleWhoLike = []
    }
    
    func printAll() {
        print("\(category) - \(categoryDetail) -  \(title) - \(detail) - \(price) - \(locationName) - \(locationAddress) - \(images.count)")
    }
}
