//
//  AniPlayCanvasView.swift
//  PopApp
//
//  Created by Emiaostein on 4/8/16.
//  Copyright © 2016 Emiaostein. All rights reserved.
//

import UIKit

protocol AniPlayCanvasViewDataSource: class {
    
    func animationsForAniPlayCanvasView(view: AniPlayCanvasView) -> [Animation]?
    func containerItemForAniPlayCanvasView(view: AniPlayCanvasView, containerID: String) -> AniCanvasAccessResult
}

class AniPlayCanvasView: CanvasView {

    weak var aniDataSource: AniPlayCanvasViewDataSource?
    var beganNode: AniNode?
    var currentNode: AniNode?
    let control = AniControl()

    func ready() {
        if layer.speed != 0 { layer.speed = 0 }
        control.stop()
        reset()
        setupAnimations()
        setupControl()
        currentNode = beganNode
        guard let aniNode = currentNode else { return }
        readyWith(aniNode)
    }
    
    func play() {
        if let currentNode = currentNode {
            control.start(Float(currentNode.duration))
        }
    }
    
    func pause() {
        control.pause()
    }
    
    func stop() {
        control.stop()
    }
}

extension AniPlayCanvasView {
    
    private func reset() {
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        removeAllAnimations()
        layer.timeOffset = 0
        CATransaction.commit()
    }
    
    private func setupAnimations() {
        guard let aniDataSource = aniDataSource, let animations = aniDataSource.animationsForAniPlayCanvasView(self) else {
            beganNode = nil
            currentNode = nil
            return
        }
        
        let node = AniNode(animations: animations)
        beganNode = node
    }
    
    private func readyWith(node: AniNode) -> Float {
        
        guard let aniDataSource = aniDataSource else { return 0 }
        
        let result = node.startWith(bounds.size) {[weak self] (containerID) -> AniNodeFinderResult in
            if let sf = self {
                switch aniDataSource.containerItemForAniPlayCanvasView(sf, containerID: containerID) {
                case .Success(let i , let container):
                    return AniNodeFinderResult.Success(i, container)
                    
                case .Failture:
                    return AniNodeFinderResult.NotFound
                }
            } else {
                return AniNodeFinderResult.NotFound
            }
        }
        beganAnimationAt(result.containers)
        return result.duration
    }
    
    private func setupControl() {
        
        control.callBack {[weak self] (state) in
            guard let sf = self else {
                return
            }
            switch state {
            case .Playing(let p, let d):
                sf.layer.timeOffset = CFTimeInterval(d) * CFTimeInterval(p)
            case .Completed:
                sf.reset()
                sf.currentNode = sf.currentNode?.nextNode
                guard let aniNode = sf.currentNode else {
                    return
                }
                sf.readyWith(aniNode)
                sf.control.start(Float(aniNode.duration))
            default:
                ()
            }
        }
    }
}

