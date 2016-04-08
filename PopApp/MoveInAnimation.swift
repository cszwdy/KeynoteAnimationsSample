//
//  MoveInAnimation.swift
//  PopApp
//
//  Created by Emiaostein on 4/4/16.
//  Copyright © 2016 Emiaostein. All rights reserved.
//

import Foundation
import UIKit

extension AniFactory {
    
   class func moveIn(canvasSize: CGSize, container: Container, content: Content, contentsCount: Int, index: Int, descriptor: Descriptor, beganTime: Float) -> AniDescriptor {
        
    let duration = descriptor.config.duration
    let time = duration * 0.6
    let interdelay = duration * (1 - 0.6) / Float(contentsCount - 1)
    let b = Float(contentsCount - 1 - index) * interdelay + beganTime + descriptor.config.delay
    
        let bt = [
            "position": CFTimeInterval(b),
            "opacity": CFTimeInterval(b),
            "transform": CFTimeInterval(b)]

        let ds = [
            "position": CFTimeInterval(time),
            "opacity": CFTimeInterval(time),
            "transform": CFTimeInterval(time)]
        
        // property value
        let length = sqrt(pow(Double(container.width), 2.0) + pow(Double(container.height), 2.0))
        let endc = CGPoint(x: canvasSize.width + CGFloat(length) / 2.0, y: CGFloat(container.positionY))
        let translation = CGPoint(x: endc.x - CGFloat(container.positionX), y: endc.y - CGFloat(container.positionY))
        let r = CGFloat(container.rotation) / 180.0 * CGFloat(M_PI)
        let tl = sqrt(pow(Double(translation.x), 2.0) + pow(Double(translation.y), 2.0))
        let tc = CGPoint(x: CGFloat(tl) * cos(r), y: -CGFloat(tl) * sin(r))
        let position = CGPoint(x: CGFloat(content.width / 2), y: CGFloat(content.height / 2))
        let nextPosition = CGPoint(x: position.x + tc.x, y: position.y + tc.y)
        let vs: [String: [AnyObject]] = [
            "position": [
             NSValue(CGPoint: position), NSValue(CGPoint: nextPosition)],
            "opacity": [0.0, 1.0],
            "transform": [
                NSValue(CATransform3D: CATransform3DMakeScale(1.0, 1.0, 1)),
                NSValue(CATransform3D: CATransform3DMakeScale(0.1, 0.1, 1)),
            ]
        ]
        
        let ks: [String: [NSNumber]] = [
            "position": [0, 1],
            "opacity": [0, 1],
            "transform": [0, 1]]
        
        return AniDescriptor(type: "MOVE_IN", beganTimes: bt, durations: ds, values: vs, keyTimes: ks)
    }
}