//
//  AniDescriptor.swift
//  PopApp
//
//  Created by Emiaostein on 4/3/16.
//  Copyright © 2016 Emiaostein. All rights reserved.
//

import Foundation
struct Descriptor {
    struct Config {
        
        let bounce: Bool
        let deiveryFrom: Int
        let delivery: String
        let deliveryTo: Int
        let direction: String
        let delay: Float
        let duration: Float
        let textDelivery: String
        let textDeliveryFrom: String
        init?(_ info: [String: AnyObject]) {
            guard let bounce = info["bounce"] as? Bool else { return nil }
            guard let deiveryFrom = info["deiveryFrom"] as? Int else { return nil }
            guard let delivery = info["delivery"] as? String else { return nil }
            guard let deliveryTo = info["deliveryTo"] as? Int else { return nil }
            guard let direction = info["direction"] as? String else { return nil }
            guard let delay = info["delay"] as? Float else { return nil }
            guard let duration = info["duration"] as? Float else { return nil }
            guard let textDelivery = info["textDelivery"] as? String else { return nil }
            guard let textDeliveryFrom = info["textDeliveryFrom"] as? String else { return nil }
            self.bounce = bounce
            self.deiveryFrom = deiveryFrom
            self.delivery = delivery
            self.deliveryTo = deliveryTo
            self.direction = direction
            self.delay = delay
            self.duration = duration
            self.textDelivery = textDelivery
            self.textDeliveryFrom = textDeliveryFrom
        }
    }
    let config: Config
    let type: String
    init?(_ info: [String: AnyObject]) {
        guard let configJSONDictionary = info["config"] as? [String: AnyObject] else { return nil }
        guard let config = Config(configJSONDictionary) else { return nil }
        guard let type = info["type"] as? String else { return nil }
        self.config = config
        self.type = type
    }
}
