////
////  AniAnimatedContainer+Extension.swift
////  PopApp
////
////  Created by Emiaostein on 4/1/16.
////  Copyright © 2016 Emiaostein. All rights reserved.
////
//
//import Foundation
//import UIKit
//
//extension AnimatedContainer: AniContainerable {
//    var ID: String { return identifier }
//    var animated: Bool { return true }
//}
//
//extension AnimatedContainer: UICollectionViewDataSource {
//    
//    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return contents.count
//    }
//    
//    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
//        
//        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("AniContentCell", forIndexPath: indexPath)
//        
//        cell.backgroundColor = UIColor.blueColor()
//        
//        return cell
//    }
//}
//
//extension AnimatedContainer: AniContainerLayoutDataSource {
//    
//    func containerLayout(layout: AniContainerLayout, containerForItemAtIndexPath indexPath: NSIndexPath) -> AniContainerLayoutItemAttributes? {
//        
//        guard contents.count > 0 && contents.count > indexPath.item else {
//            return nil
//        }
//        let content = contents[indexPath.item]
//        return content
//    }
//}
//
//extension AnimatedContainer: AniCanvasLayoutItemAttributes {
//    
//    var center: CGPoint { return CGPoint(x: positionX, y: positionY) }
//    var size: CGSize { return CGSize(width: width, height: height) }
//    var transform: CATransform3D { return CATransform3DMakeRotation(CGFloat(rotation) / 180 * CGFloat(M_PI), 0, 0, 1) }
//}