//
//  CanvasLayout.swift
//  PopApp
//
//  Created by Emiaostein on 4/3/16.
//  Copyright © 2016 Emiaostein. All rights reserved.
//

import UIKit

protocol CanvasLayoutDataSource: class {
    
    func layerAttributesForItemAtIndexPath(indexPath: NSIndexPath) -> Layerable?
}

class CanvasLayout: UICollectionViewFlowLayout {
    
    weak var dataSource: CanvasLayoutDataSource?
    
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        guard let attributesCollection = super.layoutAttributesForElementsInRect(rect) else {
            return nil
        }
        var nextAs = [UICollectionViewLayoutAttributes]()
        for a in attributesCollection {
            let indexPath = a.indexPath
            if let nextA = layoutAttributesForItemAtIndexPath(indexPath) {
                nextAs.append(nextA)
            }
        }
        return nextAs
    }
    
    override func layoutAttributesForItemAtIndexPath(indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes? {
        
        guard let a = super.layoutAttributesForItemAtIndexPath(indexPath) else {
            return nil
        }
        
        guard let dataSource = dataSource, let layerAttr = dataSource.layerAttributesForItemAtIndexPath(indexPath) else {
            return a
        }
        
        a.size = layerAttr.size
        a.center = layerAttr.position
        a.transform3D = layerAttr.transform
        
        return a
    }
}
