//
//  ContentTextLayer.swift
//  PopApp
//
//  Created by Emiaostein on 4/7/16.
//  Copyright © 2016 Emiaostein. All rights reserved.
//

import UIKit

class TextView: UILabel {
    
    var insets: CGPoint = CGPoint.zero
    
    override func drawTextInRect(rect: CGRect) {
        
        let context = UIGraphicsGetCurrentContext()
        CGContextSaveGState(context)
        CGContextTranslateCTM(context, insets.x, insets.y)
        attributedText?.drawInRect(CGRect(origin: rect.origin, size: CGSize(width: rect.size.width - insets.x * 2, height: rect.size.height - insets.y * 2)))
        CGContextRestoreGState(context)
    }
}

//class TextLayer: CATextLayer {
//    
//}
