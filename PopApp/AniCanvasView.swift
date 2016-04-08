//
//  CanvasView.swift
//  PopApp
//
//  Created by Emiaostein on 4/1/16.
//  Copyright © 2016 Emiaostein. All rights reserved.
//

import UIKit

extension CanvasView {
    
    func beganAnimationAt(targets: [NSIndexPath: AniContainer]) {
        guard targets.count > 0 else {
            return
        }
        for (i, c) in targets {
            beganAnimationAt(i, with: c)
        }
    }
    
    // 指定 containerCell 执行 有动画分好content 的 AniContainer, 每一个动画都对应一个 contentCell
    func beganAnimationAt(indexPath: NSIndexPath, with container: AniContainer) {
        guard let cell = containerCellAt(indexPath) else {
            return
        }
        cell.dataSource = container
        cell.delegate = container
        cell.reloadData { 
            for (i, d) in container.animations {
                if let c = cell.contentCellAt(NSIndexPath(forItem: i, inSection: 0)) {
                    d.configAnimationOn(c.contentView.layer)
                }
            }
        } 
    }
}