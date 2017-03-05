//
//  Item.swift
//  Crafty
//
//  Created by Jimmy Hoang on 2/3/17.
//  Copyright © 2017 Jimmy Hoang. All rights reserved.
//

import Foundation

class Product: NSObject {
    var category: String?
    var categoryDetail: String?
    var title: String?
    var detail: String?
    var price: Double?
    var locationName: String?
    var locationAddress: String?
    var love: Int?
    var timestamp: NSNumber?
    var sellerID: String?
    
    
    override init() {
        category = nil
        categoryDetail = nil
        title = nil
        detail = nil
        price = nil
        locationName = nil
        locationAddress = nil
        love = nil
        timestamp = nil
        sellerID = nil
    }
    
    func printAll() {
        print("\(category) - \(categoryDetail) -  \(title) - \(detail) - \(price) - \(locationName) - \(locationAddress)")
    }
}
