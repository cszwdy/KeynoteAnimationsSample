//
//  AniAnimation.swift
//  PopApp
//
//  Created by Emiaostein on 4/1/16.
//  Copyright © 2016 Emiaostein. All rights reserved.
//

import Foundation
struct Animation {
    let ID: String
    let descriptor: Descriptor
    var targetID: String
    init?(_ info: [String: AnyObject]) {
        guard let ID = info["ID"] as? String else { return nil }
        guard let descriptorJSONDictionary = info["descriptor"] as? [String: AnyObject] else { return nil }
        guard let descriptor = Descriptor(descriptorJSONDictionary) else { return nil }
        guard let targetID = info["targetID"] as? String else { return nil }
        self.ID = ID
        self.descriptor = descriptor
        self.targetID = targetID
    }
}