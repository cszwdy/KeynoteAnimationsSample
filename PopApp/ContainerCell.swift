//
//  ContainerCell.swift
//  PopApp
//
//  Created by Emiaostein on 4/3/16.
//  Copyright © 2016 Emiaostein. All rights reserved.
//

import UIKit

let containerItemIdentifier = "com.emiaostein.contentIdentifier"
class ContainerCell: UICollectionViewCell {
    
    var identifier = ""
    weak var dataSource: protocol<UICollectionViewDataSource, ContainerLayoutDataSource>? {
        didSet {
            layout.dataSource = dataSource
            collectionView.dataSource = dataSource
        }
    }
    weak var delegate: UICollectionViewDelegate? {
        didSet { collectionView.delegate = delegate }
    }
    private let collectionView: UICollectionView
    private var layout: ContainerLayout {
        return collectionView.collectionViewLayout as! ContainerLayout
    }
    
    override init(frame: CGRect) {
        let layout = ContainerLayout()
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
        collectionView.registerClass(ContentCell.self, forCellWithReuseIdentifier: containerItemIdentifier)
        contentView.layer.addSublayer(collectionView.layer)
        collectionView.layer.masksToBounds = false
        //        addSubview(collectionView)  use to debug
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = bounds
    }
}

extension ContainerCell {
    
    func contentCellAt(indexPath: NSIndexPath) -> ContentCell? {
        return collectionView.cellForItemAtIndexPath(indexPath) as? ContentCell
    }
    
    func reloadData(completed:() -> ()) {
        let cells = collectionView.visibleCells()
        for c in cells {
            c.contentView.layer.removeAllAnimations()
        }
        
//        collectionView.performBatchUpdates({ [weak self] in
//            guard let sf = self else { return }
//            sf.collectionView.reloadData()
//            }) { (finished) in
//                
//                if finished {
//                    completed()
//                }
//        }
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        collectionView.reloadSections(NSIndexSet(index: 0))
        CATransaction.commit()
        completed()
    }
    
    func removeAllAnimations() {
        let cells = collectionView.visibleCells()
        for c in cells {
            c.layer.removeAllAnimations()
            c.contentView.layer.removeAllAnimations()
        }
    }
}
