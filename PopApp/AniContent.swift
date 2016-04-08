//
//  AniContent.swift
//  PopApp
//
//  Created by Emiaostein on 4/3/16.
//  Copyright © 2016 Emiaostein. All rights reserved.
//

import UIKit

class AniContent: NSObject {

    let content: Content
    
    init(content: Content) {
        self.content = content
    }
}

extension AniContent: Layerable {
    
    var position: CGPoint { return CGPoint(x: content.positionX, y: content.positionY) }
    var size: CGSize { return CGSize(width: content.width, height: content.height) }
    var transform: CATransform3D { return CATransform3DIdentity }
}
