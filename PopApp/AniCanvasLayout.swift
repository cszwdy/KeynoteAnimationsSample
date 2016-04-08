//
//  AniContainerLayout.swift
//  PopApp
//
//  Created by Emiaostein on 4/1/16.
//  Copyright © 2016 Emiaostein. All rights reserved.
//

import UIKit

protocol AniCanvasLayoutItemAttributes {

    var center: CGPoint { get }
    var size: CGSize { get }
    var transform: CATransform3D { get }
}

protocol AniCanvasLayoutDataSource: class {
    
    func canvasLayout(layout: AniCanvasLayout, containerForItemAtIndexPath indexPath: NSIndexPath) -> AniCanvasLayoutItemAttributes?
}

class AniCanvasLayout: UICollectionViewFlowLayout {

    weak var dataSource: AniCanvasLayoutDataSource?

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
        print("sdfsdf")
        guard let attributes = super.layoutAttributesForItemAtIndexPath(indexPath) else {
            return nil
        }
        
        guard let container = dataSource?.canvasLayout(self, containerForItemAtIndexPath: indexPath) else {
            return attributes
        }
        
        attributes.center = container.center
        attributes.size = container.size
        attributes.transform3D = container.transform
        
        return attributes
    }
}
