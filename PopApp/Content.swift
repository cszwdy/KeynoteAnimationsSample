//
//  AniContent.swift
//  PopApp
//
//  Created by Emiaostein on 4/1/16.
//  Copyright © 2016 Emiaostein. All rights reserved.
//

import Foundation
struct Content {
    let height: Int
    let positionX: Int
    let positionY: Int
    let source: Source
    let width: Int
    init?(_ info: [String: AnyObject]) {
        guard let height = info["height"] as? Int else { return nil }
        guard let positionX = info["positionX"] as? Int else { return nil }
        guard let positionY = info["positionY"] as? Int else { return nil }
        guard let sourceJSONDictionary = info["source"] as? [String: AnyObject] else { return nil }
        guard let source = Source(sourceJSONDictionary) else { return nil }
        guard let width = info["width"] as? Int else { return nil }
        self.height = height
        self.positionX = positionX
        self.positionY = positionY
        self.source = source
        self.width = width
    }
    
    init(cx: Int, cy: Int, width: Int, height: Int, source: Source) {
        self.height = height
        self.positionX = cx
        self.positionY = cy
        self.width = width
        self.source = source
    }
}