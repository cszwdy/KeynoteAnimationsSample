//
//  AniPage.swift
//  PopApp
//
//  Created by Emiaostein on 4/1/16.
//  Copyright © 2016 Emiaostein. All rights reserved.
//

import Foundation

struct Canvas {
    let animations: [Animation]
    let containers: [Container]
    let height: Int
    let width: Int
    init?(_ info: [String: AnyObject]) {
        guard let animationsJSONArray = info["animations"] as? [[String: AnyObject]] else { return nil }
        let animations = animationsJSONArray.map({ Animation($0) }).flatMap({ $0 })
        guard let containersJSONArray = info["containers"] as? [[String: AnyObject]] else { return nil }
        let containers = containersJSONArray.map({ Container($0) }).flatMap({ $0 })
        guard let height = info["height"] as? Int else { return nil }
        guard let width = info["width"] as? Int else { return nil }
        self.animations = animations
        self.containers = containers
        self.height = height
        self.width = width
    }
}