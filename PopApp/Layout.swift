//
//  Layout.swift
//  PopApp
//
//  Created by Emiaostein on 3/31/16.
//  Copyright © 2016 Emiaostein. All rights reserved.
//

import UIKit

class Layout: UICollectionViewFlowLayout {
    
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
        
        let i = CGFloat(attributes.indexPath.item)
        let value: CGFloat = 1.0
        
        let tx: CGFloat = 320 * value
        let ty: CGFloat = -50 * value
        let translation = CATransform3DMakeTranslation(tx, ty, 0)
        
        let sx: CGFloat = 1
        let sy: CGFloat = 1
        let scale = CATransform3DMakeScale(sx, sy, 1)
        
        let angle: CGFloat = 0
        let rx: CGFloat = 0.5
        let ry: CGFloat = 1
        let rotation = CATransform3DMakeRotation(angle, 0, ry, 0)
        
        let combine = CATransform3DConcat(translation, scale)
        let combine2 = CATransform3DConcat(combine, rotation)
        
        attributes.transform3D = combine2
        attributes.alpha = 1 - value
        
        return attributes
    }
    
}
