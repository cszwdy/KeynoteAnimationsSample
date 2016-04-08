//
//  UISlider+Extension.swift
//  PopApp
//
//  Created by Emiaostein on 3/31/16.
//  Copyright © 2016 Emiaostein. All rights reserved.
//

import Foundation
import UIKit

class SliderTarget {
    var next: ((Float) -> ())?
    @objc func changed(sender: UISlider) {
        next?(sender.value)
    }
}

extension UISlider {
    
    struct Target {
       static let target = SliderTarget()
    }
    
    func start() -> SliderTarget {
        addTarget(Target.target, action: #selector(SliderTarget.changed(_:)), forControlEvents: .ValueChanged)
        return Target.target
    }
}