//
//  AniResource.swift
//  PopApp
//
//  Created by Emiaostein on 4/1/16.
//  Copyright © 2016 Emiaostein. All rights reserved.
//

import Foundation
struct Source {
    let text: String
    let attributes: [String: AnyObject]?
    init?(_ info: [String: AnyObject]) {
        guard let text = info["text"] as? String else { return nil }
        let attributes = info["attributes"] as? [String: AnyObject]
        self.text = text
        self.attributes = attributes
    }
    
    init(text: String, attributes: [String: AnyObject]?) {
        self.text = text
        self.attributes = attributes
    }
}