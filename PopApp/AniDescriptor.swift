//
//  AniDescriptor.swift
//  PopApp
//
//  Created by Emiaostein on 4/3/16.
//  Copyright © 2016 Emiaostein. All rights reserved.
//

import Foundation
import UIKit
import pop
var v: AnyObject? = nil
struct AniDescriptor {
    
    let type: String
    let beganTimes: [String: CFTimeInterval]
    let durations: [String: CFTimeInterval]
    let values: [String: [AnyObject]]
    let keyTimes: [String: [NSNumber]]
    
    func configAnimationOn(layer: CALayer) {
        let fillMode : String = kCAFillModeBoth
        let c = layer
        
        let keyPaths = ["position", "transform"]
        
        var anims = [CAAnimation]()
        for k in keyPaths {
            let beganTime = beganTimes[k] ?? 0
            let duration = durations[k] ?? 0.3
            let value = values[k]
            let keyTime = keyTimes[k]
            
            let anim = CAKeyframeAnimation(keyPath:k)
            anim.values = value
            anim.keyTimes = keyTime
            anim.duration = duration
            anim.beginTime = beganTime
            
            anims.append(anim)
            if k == "position" {
                if let last = keyTime?.last as? Int {
                    switch last {
                    case 0:
                        c.setValue(value?.first, forKeyPath: k)
                    default:
                        c.setValue(value?.last, forKeyPath: k)
                    }
                    
                }
                
            } else {
            }
        }

        let animGroup = QCMethod.groupAnimations(anims, fillMode:fillMode)
        animGroup.removedOnCompletion = true
        c.addAnimation(animGroup, forKey: "\(type)Animation")
    }
}