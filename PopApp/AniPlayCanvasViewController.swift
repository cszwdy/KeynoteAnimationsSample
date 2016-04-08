//
//  AniPlayCanvasViewController.swift
//  PopApp
//
//  Created by Emiaostein on 4/8/16.
//  Copyright © 2016 Emiaostein. All rights reserved.
//

import UIKit

class AniPlayCanvasViewController: UIViewController {

    var aniCanvasView: AniPlayCanvasView!
    
    let canvas: AniCanvas = {
        let json = NSBundle.mainBundle().pathForResource("canvas2", ofType: "json")!
        let data = NSData(contentsOfFile: json)!
        let dic = try! NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.init(rawValue: 0)) as! [String: AnyObject]
        let c = Canvas(dic)!
        let ac = AniCanvas(canvas: c)
        return ac
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    private func setup() {
        
        aniCanvasView = AniPlayCanvasView(frame: CGRect(origin: CGPoint.zero, size: canvas.size))
        aniCanvasView.backgroundColor = UIColor.groupTableViewBackgroundColor()
        aniCanvasView.dataSource = canvas
        aniCanvasView.aniDataSource = canvas
        //        view.layer.addSublayer(canvasView.layer)
        view.addSubview(aniCanvasView) // debug
    }
}

// MARK: - Actions
extension AniPlayCanvasViewController {
    
    @IBAction func ready(sender: AnyObject) {
        aniCanvasView.ready()
    }
    
    @IBAction func play(sender: AnyObject) {
        aniCanvasView.play()
    }
    
    @IBAction func pause(sender: AnyObject) {
        aniCanvasView.pause()
    }
}