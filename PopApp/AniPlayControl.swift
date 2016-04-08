//
//  AniPlayControl.swift
//  PopApp
//
//  Created by Emiaostein on 4/1/16.
//  Copyright © 2016 Emiaostein. All rights reserved.
//

import Foundation
import UIKit
class AniPlayControl: NSObject {
    
    private lazy var displayLink: CADisplayLink = {
        let adisplayLink = CADisplayLink(
            target: self,
            selector: #selector(AniPlayControl.displayFrameTick))
        adisplayLink.addToRunLoop(
            NSRunLoop.currentRunLoop(),
            forMode: NSRunLoopCommonModes)
        
        adisplayLink.paused = true
        return adisplayLink
    }()
    private(set) var playing: Bool = false
    var paused: Bool {
        return displayLink.paused
    }
    
    var duration: Float = 1.0
    var progressHandler: ((Float) -> ())?
    var finishedHandler: (() -> ())?
    var stopedHandler:(() -> ())?
    var startHandler: (() -> ())?
    private(set) var progress: Float = 0.0
    private var currentFrame: Int = 0
    private var totalFrames: Int = 0
    
    func displayFrameTick() {
        if displayLink.duration > 0.0 && totalFrames == 0 {
            let frameRate = Float(displayLink.duration) / Float(displayLink.frameInterval)
            totalFrames = Int(ceil(duration / frameRate))
        }
        
        currentFrame += 1
        
        if currentFrame <= totalFrames {
            playing = true
            progress += 1.0 / Float(totalFrames)
            progressHandler?(progress)
        } else {
            
            progress = 0.0
            currentFrame = 0
            totalFrames = 0
            displayLink.paused = true
            playing = false
            finishedHandler?()
        }
    }
    
    func start() {
        
        switch (playing, paused) {
        case (true, true):
            // continue
            displayLink.paused = false
        case (true, false):
            // nothing
            ()
        case (false, true):
            // start
            playing = true
            displayLink.paused = false
            startHandler?()
        case (false, false):
            // need pause
            pause()
        }
    }
    
    func pause() {
        displayLink.paused = true
    }
    
    func stop() {
        displayLink.paused = true
        playing = false
        progress = 0.0
        currentFrame = 0
        totalFrames = 0
        stopedHandler?()
    }
}