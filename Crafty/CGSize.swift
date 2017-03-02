//
//  CGSize.swift
//  Crafty
//
//  Created by Jimmy Hoang on 3/1/17.
//  Copyright © 2017 Jimmy Hoang. All rights reserved.
//

import UIKit

extension CGSize {
    func add(dx: CGFloat, dy: CGFloat) -> CGSize {
        return CGSize(width: self.width + dx, height: self.height + dy)
    }
}

