//
//  AnimViewController.swift
//  PopApp
//
//  Created by Emiaostein on 3/31/16.
//  Copyright © 2016 Emiaostein. All rights reserved.
//

import UIKit

class AnimViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var slider: UISlider!
    var collectionView2: UICollectionView!
    var t: UICollectionViewTransitionLayout?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.hidden = true

        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 10, height: 10)
        
        collectionView2 = UICollectionView(frame: CGRect(x: 0, y: 100, width: 300, height: 300), collectionViewLayout: layout)
        view.layer.addSublayer(collectionView2.layer)
        collectionView2.backgroundColor = UIColor.whiteColor()
        collectionView2.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell2")
        collectionView.backgroundColor = UIColor.clearColor()
        
        collectionView2.dataSource = self
        collectionView2.delegate = self
    }
    
    override func viewDidAppear(animated: Bool) {
        
        animationByAnimation()
    }
    
    func animationByTransition() {
        let layout = Layout()
        layout.itemSize = CGSize(width: 10, height: 10)
        t = collectionView2.startInteractiveTransitionToCollectionViewLayout(layout, completion: nil)
        
        slider.start().next = {[weak self] value in
            
            dispatch_async(dispatch_get_main_queue(), {
                
                self?.t?.transitionProgress = CGFloat(value)
                self?.t?.invalidateLayout()
            })
        }
    }
    
    func animationByAnimation() {
        let cells = collectionView2.visibleCells()
        slider.start().next = {[weak self] value in
            
            dispatch_async(dispatch_get_main_queue(), {
                self?.collectionView2.layer.timeOffset = 4.6 * Double(value)
            })
        }

        let fillMode : String = kCAFillModeForwards
        
        for (i, c) in cells.enumerate() {
            let position = c.layer.position
            let nextPosition = CGPoint(x: position.x + 320, y: position.y + 5 * CGFloat(i % 5))
            ////Rectangle animation
            let rectanglePositionAnim      = CAKeyframeAnimation(keyPath:"position")
            rectanglePositionAnim.values   = [NSValue(CGPoint: position), NSValue(CGPoint: nextPosition)]
            rectanglePositionAnim.keyTimes = [0, 1]
            rectanglePositionAnim.duration = 1.6
            rectanglePositionAnim.beginTime = Double(i) * 0.01
            
            let rectangleTransformAnim      = CAKeyframeAnimation(keyPath:"transform")
            rectangleTransformAnim.values   = [NSValue(CATransform3D: CATransform3DMakeRotation(CGFloat(M_PI_4), 0, 0, -1)),
                                               NSValue(CATransform3D: CATransform3DMakeRotation(CGFloat(M_PI), 0, 1, 0))]
            rectangleTransformAnim.keyTimes = [0, 1]
            rectangleTransformAnim.duration = 1.6
            rectangleTransformAnim.beginTime = Double(i) * 0.01

            let rectangleUntitled1Anim : CAAnimationGroup = QCMethod.groupAnimations([rectanglePositionAnim, rectangleTransformAnim], fillMode:fillMode)
            c.layer.addAnimation(rectangleUntitled1Anim, forKey:"rectangleUntitled1Anim")
        }
        
        collectionView2.layer.speed = 0.0
        collectionView2.layer.timeOffset = 0.0
    }
}

extension AnimViewController: UICollectionViewDataSource {
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 300
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell2", forIndexPath: indexPath)
        
        cell.backgroundColor = UIColor.blueColor()
        
        return cell
    }
}

extension AnimViewController: UICollectionViewDelegate {
    
    func collectionView(collectionView: UICollectionView, transitionLayoutForOldLayout fromLayout: UICollectionViewLayout, newLayout toLayout: UICollectionViewLayout) -> UICollectionViewTransitionLayout {
        
        return TransitionLayout(currentLayout: collectionView.collectionViewLayout, nextLayout: toLayout)

    }
}
