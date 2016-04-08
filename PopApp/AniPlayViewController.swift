//
//  AniPlayViewController.swift
//  PopApp
//
//  Created by Emiaostein on 4/3/16.
//  Copyright © 2016 Emiaostein. All rights reserved.
//

import UIKit

class AniPlayViewController: UIViewController {

    var canvasView: CanvasView!
    let canvas: AniCanvas = {
        let json = NSBundle.mainBundle().pathForResource("canvas2", ofType: "json")!
        let data = NSData(contentsOfFile: json)!
        let dic = try! NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.init(rawValue: 0)) as! [String: AnyObject]
        let c = Canvas(dic)!
        let ac = AniCanvas(canvas: c)
        return ac
    }()
    @IBOutlet weak var slider: UISlider!
    var beganNode: AniNode?
    var currentNode: AniNode?
    let control = AniControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        canvasView = CanvasView(frame: CGRect(origin: CGPoint.zero, size: canvas.size))
        canvasView.backgroundColor = UIColor.groupTableViewBackgroundColor()
        canvasView.center = view.center
        canvasView.dataSource = canvas
        canvasView.layer.speed = 0
//        view.layer.addSublayer(canvasView.layer)
        view.addSubview(canvasView) // debug
        
        setupNodes()

        control.callBack {[weak self] (state) in
            guard let sf = self else {
                return
            }
            switch state {
            case .Playing(let p, let d):
                sf.slider.value = d * p
                sf.canvasView.layer.timeOffset = CFTimeInterval(d) * CFTimeInterval(p)
            case .Completed:
                sf.reset()
                sf.currentNode = sf.currentNode?.nextNode
                guard let aniNode = sf.currentNode else {
                    return
                }
                sf.slider.maximumValue = aniNode.duration
                sf.slider.value = 0
                sf.readyWith(aniNode)
                sf.control.start(Float(aniNode.duration))
                
            default:
                ()
            }
        }
    }
    
    func setupNodes() {
        // TODO: Group AniNode by 「Follow Former」? -- EMIAOSTEIN, 7/04/16, 17:05
        let node = AniNode(animations: canvas.canvas.animations)
        var current = node
        for i in 0..<2 {
            var a = canvas.canvas.animations[i % 2]
            a.targetID = "QWERTY\(i % 2 + 1)"
            let anode = AniNode(animations: [a])
            current.nextNode = anode
            current = anode
        }
        
        beganNode = node
    }
    
    func reset() {
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        canvasView.removeAllAnimations()
        canvasView.layer.timeOffset = 0
        CATransaction.commit()
    }
    
    func readyWith(node: AniNode) -> Float {
        let result = node.startWith(canvas.size) {[weak self] (containerID) -> AniNodeFinderResult in
            if let sf = self {
                switch sf.canvas.accessContainerBy(containerID) {
                case .Success(let i , let container):
                    return AniNodeFinderResult.Success(i, container)
                    
                case .Failture:
                    return AniNodeFinderResult.NotFound
                }
            } else {
                return AniNodeFinderResult.NotFound
            }
        }
        canvasView.beganAnimationAt(result.containers)
        return result.duration
    }
}

extension AniPlayViewController {
    
    @IBAction func ready(sender: AnyObject) {
        control.stop()
        reset()
        currentNode = beganNode
        guard let aniNode = currentNode else { return }
        readyWith(aniNode)
    }
    
    @IBAction func play(sender: AnyObject) {
        if let currentNode = currentNode {
            control.start(Float(currentNode.duration))
        }
    }
    
    @IBAction func pause(sender: AnyObject) {
        control.pause()
    }
    
    @IBAction func stop(sender: AnyObject) {
        control.stop()
    }
    
    @IBAction func sliderChanged(sender: UISlider) {
        control.pause()
        canvasView.layer.timeOffset = CFTimeInterval(sender.value)
    }
}
