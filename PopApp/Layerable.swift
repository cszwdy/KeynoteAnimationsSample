//
//  Layerable.swift
//  PopApp
//
//  Created by Emiaostein on 4/3/16.
//  Copyright © 2016 Emiaostein. All rights reserved.
//

import Foundation
import UIKit

protocol Layerable {
    var position: CGPoint { get }
    var size: CGSize { get }
    var transform: CATransform3D { get }
}