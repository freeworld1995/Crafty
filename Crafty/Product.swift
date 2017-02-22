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
    var title: String?
    var detail: String?
    var price: Double?
    var meetupLocation: String?
    
    override init() {
        category = nil
        title = nil
        detail = nil
        price = nil
        meetupLocation = nil
    }
    
    func toString() {
        print("\(category) - \(title) - \(detail) - \(price) - \(meetupLocation)")
    }
}
