//
//  CanvasView.swift
//  PopApp
//
//  Created by Emiaostein on 4/3/16.
//  Copyright © 2016 Emiaostein. All rights reserved.
//

import UIKit

let canvasItemIdentifier = "com.emiaostein.containerIdentifier"
class CanvasView: UIView {
    
    weak var dataSource: protocol<UICollectionViewDataSource, CanvasLayoutDataSource>? {
        didSet {
            layout.dataSource = dataSource
            collectionView.dataSource = dataSource
        }
    }
    weak var delegate: UICollectionViewDelegate? {
        didSet { collectionView.delegate = delegate }
    }
    private let collectionView: UICollectionView
    private var layout: CanvasLayout {
        return collectionView.collectionViewLayout as! CanvasLayout
    }
    
    override init(frame: CGRect) {
        let layout = CanvasLayout()
        collectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: layout)
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        let layout = CanvasLayout()
        collectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: layout)
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        collectionView.backgroundColor = UIColor.clearColor()
        collectionView.registerClass(ContainerCell.self, forCellWithReuseIdentifier: canvasItemIdentifier)
        layer.addSublayer(collectionView.layer)
//        addSubview(collectionView)  use to debug
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = bounds
        
    }
}

extension CanvasView {
    
    func containerCellAt(indexPath: NSIndexPath) -> ContainerCell? {
       return collectionView.cellForItemAtIndexPath(indexPath) as? ContainerCell
    }
    
    func removeAllAnimations() {
        let cells = collectionView.visibleCells() as! [ContainerCell]
        for c in cells {
            c.removeAllAnimations()
        }
    }
}
