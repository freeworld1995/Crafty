//
//  HighlightLayout.swift
//  Crafty
//
//  Created by Jimmy Hoang on 2/28/17.
//  Copyright © 2017 Jimmy Hoang. All rights reserved.
//

import UIKit

class HighlightLayout: UICollectionViewLayout {
    var contentWidth: CGFloat = 0.0
    var contentHeight: CGFloat = 0.0
    var separateSpace: CGFloat = 1.0
    var cache = [UICollectionViewLayoutAttributes]()
    
    override func prepare() {
        contentWidth = collectionView!.frame.width
        contentHeight  = collectionView!.frame.height
        

        let numberOfItems = collectionView?.dataSource?.collectionView(collectionView!, numberOfItemsInSection: 0)
        let cellWidth = contentWidth / 4
        
        for itemIndex in 0...numberOfItems! - 1 {
            let attribute = UICollectionViewLayoutAttributes(forCellWith: IndexPath(row: itemIndex, section: 0))
            var size = CGSize.zero
            var origin = CGPoint.zero
            
            switch itemIndex {
            case 0:
                size = size.add(dx: cellWidth, dy: contentHeight * 0.7)
            case 1:
                size = size.add(dx: cellWidth, dy: contentHeight * 0.3)
                origin = origin.add(dx: 0, dy: contentHeight * 0.7 + separateSpace)
            case 2:
                size = size.add(dx: cellWidth - separateSpace, dy: contentHeight * 0.3)
                origin = origin.add(dx: cellWidth + separateSpace , dy: 0)
            case 3:
                size = size.add(dx: cellWidth - separateSpace, dy: contentHeight * 0.7)
                origin = origin.add(dx: cellWidth + separateSpace, dy: contentHeight * 0.3 + separateSpace)
            case 4:
                size = size.add(dx: cellWidth - separateSpace, dy: contentHeight / 2)
                origin = origin.add(dx: cellWidth * 2 + separateSpace, dy: 0)
            case 5:
                size = size.add(dx: cellWidth - separateSpace, dy: contentHeight / 2)
                origin = origin.add(dx: cellWidth * 2 + separateSpace, dy: contentHeight / 2 + separateSpace)
            case 6:
                size = size.add(dx: cellWidth, dy: contentHeight * 0.8)
                origin = origin.add(dx: cellWidth * 3 + separateSpace, dy: 0)
            case 7:
                size = size.add(dx: cellWidth, dy: contentHeight * 0.2)
                origin = origin.add(dx: cellWidth * 3 + separateSpace, dy: contentHeight * 0.8 + separateSpace)
            default:
                print("yolo")
            }
            
            attribute.frame = CGRect(origin: origin, size: size)
            cache.append(attribute)
        }
    }
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cache[indexPath.item]
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var attributeInRect = [UICollectionViewLayoutAttributes]()
        cache.forEach {
            if rect.intersects($0.frame) {
                attributeInRect.append($0)
            }
        }
        
        return attributeInRect
    }
}
