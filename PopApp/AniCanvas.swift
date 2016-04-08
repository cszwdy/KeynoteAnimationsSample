//
//  AniCanvas.swift
//  PopApp
//
//  Created by Emiaostein on 4/3/16.
//  Copyright © 2016 Emiaostein. All rights reserved.
//

import UIKit

enum AniCanvasAccessResult {
    case Success(Int, Container)
    case Failture
}

class AniCanvas: NSObject {
    let canvas: Canvas
    let containers: [AniContainer]
    var size: CGSize { return CGSize(width: canvas.width, height: canvas.height) }
    
    init(canvas: Canvas) {
        var cs = [AniContainer]()
        for c in canvas.containers {
            let container = AniContainer(container: c)
            cs.append(container)
        }
        self.containers = cs
        self.canvas = canvas
    }
    
    func accessContainerBy(ID: String) -> AniCanvasAccessResult {
        if let i = (canvas.containers.indexOf{$0.identifier == ID}) {
            return AniCanvasAccessResult.Success(i, canvas.containers[i])
        } else {
            return AniCanvasAccessResult.Failture
        }
    }
}

extension AniCanvas: UICollectionViewDataSource {
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return containers.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath)
        -> UICollectionViewCell {
            
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier(canvasItemIdentifier, forIndexPath: indexPath)
                as! ContainerCell
            
            cell.dataSource = containers[indexPath.item]
            cell.delegate = containers[indexPath.item]
            
            return cell
    }
}

extension AniCanvas: CanvasLayoutDataSource {
    
    func layerAttributesForItemAtIndexPath(indexPath: NSIndexPath) -> Layerable? {
        if indexPath.item < containers.count {
            return containers[indexPath.item]
        } else {
            return nil
        }
    }
}

extension AniCanvas: AniPlayCanvasViewDataSource {
    
    func animationsForAniPlayCanvasView(view: AniPlayCanvasView) -> [Animation]? {
        
        return canvas.animations
    }
    func containerItemForAniPlayCanvasView(view: AniPlayCanvasView, containerID: String) -> AniCanvasAccessResult {
        return accessContainerBy(containerID)
    }
}
