//
//  ViewController.swift
//  PopApp
//
//  Created by Emiaostein on 1/19/16.
//  Copyright © 2016 Emiaostein. All rights reserved.
//

import UIKit
import pop

class ViewController: UIViewController {

    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var aniView: CustomView!
    override func viewDidLoad() {
        super.viewDidLoad()
        aniView.backgroundColor = UIColor.blueColor()
    }
    
    

    @IBAction func sliderChanged(sender: UISlider) {
        aniView.moveAnimProgress = CGFloat(sender.value)
    }
}

