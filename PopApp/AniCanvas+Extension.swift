////
////  AniCanvasExtension.swift
////  PopApp
////
////  Created by Emiaostein on 4/1/16.
////  Copyright © 2016 Emiaostein. All rights reserved.
////
//
//import Foundation
//import UIKit
//
//extension AniCanvas {
//    
//    func canvasView() -> AniCanvasView {
//        let size = CGSize(width: width, height: height)
//        let v = AniCanvasView(frame: CGRect(origin: CGPoint.zero, size: size))
//        return v
//    }
//}
//
//extension AniCanvas: AniCanvasViewable {
//    
//    var size: CGSize { return CGSize(width: width, height: height) }
//    var containerItems: [AniContainerable] { return containers.map{$0 as AniContainerable} }
//}
//
//extension AniCanvas: UICollectionViewDataSource {
//    
//    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return containers.count
//    }
//    
//    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
//        
//        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("AniContainerCell", forIndexPath: indexPath)
//        as! AniContainerCollectionViewCell
//        
//        cell.container = containerItems[indexPath.item]
//        return cell
//    }
//}
//
//extension AniCanvas: AniCanvasLayoutDataSource {
//    
//    func canvasLayout(layout: AniCanvasLayout, containerForItemAtIndexPath indexPath: NSIndexPath) -> AniCanvasLayoutItemAttributes? {
//        
//        guard containers.count > 0 && containers.count > indexPath.item else {
//            return nil
//        }
//        let container = containers[indexPath.item]
//        return container
//    }
//}