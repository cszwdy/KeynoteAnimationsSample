//
//  AniContentsLayout.swift
//  PopApp
//
//  Created by Emiaostein on 4/1/16.
//  Copyright © 2016 Emiaostein. All rights reserved.
//

import UIKit

protocol AniContainerLayoutItemAttributes {
    
    var center: CGPoint { get }
    var size: CGSize { get }
    var transform: CATransform3D { get }
}

protocol AniContainerLayoutDataSource: class {
    
    func containerLayout(layout: AniContainerLayout, containerForItemAtIndexPath indexPath: NSIndexPath) -> AniContainerLayoutItemAttributes?
}

class AniContainerLayout: UICollectionViewFlowLayout {

    weak var dataSource: AniContainerLayoutDataSource?
    
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        guard let attributes = super.layoutAttributesForElementsInRect(rect) else {
            return nil
        }
        
        var next = [UICollectionViewLayoutAttributes]()
        for a in attributes {
            let indexPath = a.indexPath
            if let atrribute = layoutAttributesForItemAtIndexPath(indexPath) {
                next.append(atrribute)
            }
        }
        
        return next
    }
    
    override func layoutAttributesForItemAtIndexPath(indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes? {
        
        guard let attributes = super.layoutAttributesForItemAtIndexPath(indexPath) else {
            return nil
        }
        
        guard let container = dataSource?.containerLayout(self, containerForItemAtIndexPath: indexPath) else {
            return attributes
        }
        
        attributes.center = container.center
        attributes.size = container.size
        attributes.transform3D = container.transform
        
        return attributes
    }
}
