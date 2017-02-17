//
//  ProductImage.swift
//  Crafty
//
//  Created by Jimmy Hoang on 2/12/17.
//  Copyright © 2017 Jimmy Hoang. All rights reserved.
//

import UIKit

typealias HandleImagePicker = () -> ()

class ProductImage: UIImageView {
    var handleImagePicker: HandleImagePicker?
}
