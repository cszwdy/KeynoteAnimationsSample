////
////  ContainerCollectionViewCell.swift
////  PopApp
////
////  Created by Emiaostein on 4/1/16.
////  Copyright © 2016 Emiaostein. All rights reserved.
////
//
//import UIKit
//
//protocol AniContainerable: UICollectionViewDataSource, AniContainerLayoutDataSource {
//    var ID: String { get }
//    var animated: Bool { get }
//}
//
//class AniContainerCollectionViewCell: UICollectionViewCell {
//    
//    var container: AniContainerable? {
//        didSet {
//            collectionView.dataSource = container
//            layout.dataSource = container
//        }
//    }
//    
//    let collectionView: UICollectionView
//    var layout: AniContainerLayout {
//        return collectionView.collectionViewLayout as! AniContainerLayout
//    }
//    
//    override init(frame: CGRect) {
//        let layout = AniContainerLayout()
//        collectionView = UICollectionView(
//            frame: CGRect(origin: CGPoint.zero, size: frame.size),
//            collectionViewLayout: layout)
//        super.init(frame: frame)
//        setup()
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        let layout = AniContainerLayout()
//        collectionView = UICollectionView(
//            frame: CGRect(origin: CGPoint.zero, size: CGSize.zero),
//            collectionViewLayout: layout)
//        super.init(coder: aDecoder)
//        setup()
//    }
//    
//    func setup() {
////        layer.masksToBounds = false
//        contentView.addSubview(collectionView)
//        collectionView.backgroundColor = UIColor.clearColor()
//        collectionView.registerClass(AniContentCollectionViewCell.self, forCellWithReuseIdentifier: "AniContentCell")
//        collectionView.delegate = self
//        collectionView.layer.masksToBounds = false
//    }
//    
//    func removeAnimations() {
//        let cells = collectionView.visibleCells()
//        
//        for c in cells {
//            c.layer.removeAllAnimations()
//        }
//    }
//    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        collectionView.bounds.size = bounds.size
//        collectionView.reloadData()
//    }
//}
//
//extension AniContainerCollectionViewCell: UICollectionViewDelegate {
//    
//    func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
//        
//        
//
//        
//        
//        
//        
//        
//        
//        
//        
//        
//        if let container = container where container.animated {
//            let fillMode : String = kCAFillModeBoth
//            
//            let c = cell
//            let i = indexPath.item
//            let position = c.layer.position
//            let nextPosition = CGPoint(x: position.x + 320, y: position.y + 5 * CGFloat(i % 5))
//            ////Rectangle animation
//            let rectanglePositionAnim      = CAKeyframeAnimation(keyPath:"position")
//            rectanglePositionAnim.values   = [NSValue(CGPoint: position), NSValue(CGPoint: nextPosition)]
//            rectanglePositionAnim.keyTimes = [0, 1]
//            rectanglePositionAnim.duration = 1.6
//            rectanglePositionAnim.beginTime = 0
//            
//            let rectangleTransformAnim      = CAKeyframeAnimation(keyPath:"transform")
//            rectangleTransformAnim.values   = [NSValue(CATransform3D: CATransform3DMakeRotation(0, 0, 0, -1)),
//                                               NSValue(CATransform3D: CATransform3DMakeRotation(CGFloat(M_PI), 0, 1, 0))]
//            rectangleTransformAnim.keyTimes = [0, 1]
//            rectangleTransformAnim.duration = 1.6
//            rectangleTransformAnim.beginTime = 0
//            let rectangleUntitled1Anim : CAAnimationGroup = QCMethod.groupAnimations([rectanglePositionAnim, rectangleTransformAnim], fillMode:fillMode)
//            rectangleUntitled1Anim.removedOnCompletion = true
//            rectangleUntitled1Anim.delegate = self
//            c.layer.addAnimation(rectangleUntitled1Anim, forKey:"rectangleUntitled1Anim")
//            
//            c.layer.position = nextPosition
//        }
//    }
//}