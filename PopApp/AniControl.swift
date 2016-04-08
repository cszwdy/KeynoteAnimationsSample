//
//  AniControl.swift
//  PopApp
//
//  Created by Emiaostein on 4/3/16.
//  Copyright © 2016 Emiaostein. All rights reserved.
//

import Foundation
import UIKit

class AniControl: NSObject {
    
    enum AniControlState {
        case Start
        case Playing(Float, Float)
        case Paused
        case Continued
        case Stoped
        case Completed
    }
    
    typealias AniControlHander = (AniControlState) -> ()
    
    struct AniControlInner {
        var duration: Float = 2.0
        var progress: Float = 0
        var currentFrame: Int = 0
        var totalFrames: Int = 0
        
        //play control
        var playing = false

        mutating func reset() {
            progress = 0
            currentFrame = 0
            totalFrames = 0
            playing = false
        }
    }
    
    var inner = AniControlInner()
    private lazy var displayLink: CADisplayLink = {
        let adisplayLink = CADisplayLink(target: self,selector: #selector(AniControl.displayFrameTick))
        adisplayLink.addToRunLoop(NSRunLoop.currentRunLoop(),forMode: NSRunLoopCommonModes)
        adisplayLink.paused = true
        return adisplayLink
    }()
    private var paused: Bool {
        get { return displayLink.paused }
        set { displayLink.paused = newValue }
    }
    
    private var playing: Bool {
        get { return inner.playing }
        set { inner.playing = newValue }
    }
    
    private var handler: AniControlHander?
    
    @objc private func displayFrameTick() {
        tick()
    }
    
    func start(duration: Float) {
        p_start(duration)
    }
    
    func pause() {
        p_pause()
    }
    
    func stop() {
        p_stop()
    }
    
    func callBack(handler: AniControlHander?) {
        self.handler = handler
    }
}

extension AniControl {
    private func tick() {
        if displayLink.duration > 0 && inner.totalFrames <= 0 {
            let frameRate = Float(displayLink.duration) / Float(displayLink.frameInterval)
            inner.totalFrames = Int(ceil(inner.duration / frameRate))
        }
        
        inner.currentFrame += 1
        if inner.currentFrame <= inner.totalFrames {
            if !inner.playing {
                inner.playing = true
            }
            inner.progress += 1.0 / Float(inner.totalFrames)
            handler?(.Playing(inner.progress, inner.duration))
        } else {
            
            inner.reset()
            displayLink.paused = true
            handler?(.Completed)
        }
    }
    
    private func p_start(duration: Float) {
        switch (playing, paused) {
        case (true, true): // paused
            paused = false; handler?(.Continued)
        case (true, false): // playing
            ()
        case (false, true): // stop or not start
            inner.reset()
            inner.duration = duration
            playing = true
            paused = false
            handler?(.Start)
        case (false, false):
            playing = true
        }
    }
    
    private func p_pause() {
        if !paused {
            paused = true
            handler?(.Paused)
        }
    }
    
    private func p_stop() {
        if inner.playing {
            paused = true
            inner.reset()
            handler?(.Stoped)
        }
    }
}