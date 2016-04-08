//
//  ContentCell.swift
//  PopApp
//
//  Created by Emiaostein on 4/3/16.
//  Copyright © 2016 Emiaostein. All rights reserved.
//

import UIKit

class ContentCell: UICollectionViewCell {
    
//    private let textLayer = TextLayer()
//    
//    var text: NSAttributedString? {
//        get { return textLayer.string as? NSAttributedString }
//        set { textLayer.string = newValue }
//    }
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setup()
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//        setup()
//    }
//    
//    private func setup() {
//        contentView.layer.addSublayer(textLayer)
//        textLayer.backgroundColor = UIColor.redColor().CGColor
//    }
//    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        let append: CGFloat = 4.0
////        textLayer.insets = CGPoint(x: bounds.width * append * 0.5 * 0.5, y: 0)
//        textLayer.bounds.size = CGSize(width: bounds.width, height: bounds.height)
//        textLayer.position = CGPoint(x: contentView.bounds.midX, y: contentView.bounds.midY)
//    }
    
    
    
    
    var text: NSAttributedString? {
        get { return textLayer.attributedText }
        set {
            textLayer.attributedText = newValue
        }
    }
    
    let textLayer = TextView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        contentView.addSubview(textLayer)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        let append: CGFloat = 4.0
        textLayer.insets = CGPoint(x: bounds.width * append * 0.5 * 0.5, y: 0)
        textLayer.bounds.size = CGSize(width: bounds.width * (1.0 + append), height: bounds.height)
        textLayer.center = CGPoint(x: contentView.bounds.midX, y: contentView.bounds.midY)
    }
}
