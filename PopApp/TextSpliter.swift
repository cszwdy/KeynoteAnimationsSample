//
//  TextSpliter.swift
//  TextSpliteSample
//
//  Created by Emiaostein on 4/6/16.
//  Copyright © 2016 Emiaostein. All rights reserved.
//

import Foundation
import UIKit

class TextSpliter {
    enum TextLineSpliteType {
        case AllatOnce
        case ByLine
    }
    
    enum TextSpliteType {
        case ByObject
        case ByCharacter
    }
    
    struct TextUnit {
        let text: String
        let attriubtes: [String: AnyObject]?
        let usedRect: CGRect
        let lineFragmentRect: CGRect
        let usedLineFragmentRect: CGRect
        let constraintSize: CGSize
        let section: Int
        let row: Int
    }
    
    class func spliteAttributeText(text: NSAttributedString, inConstraintSize size: CGSize) -> [TextUnit] {
        
        return []
    }
    
    class func spliteText(text: String, withAttributes attributes: [String: AnyObject]?, inConstraintSize size: CGSize, bySpliteType type: (TextLineSpliteType, TextSpliteType) = (.AllatOnce, .ByObject)) -> ([TextUnit], CGSize) {
        
        let constraintSize = size
        let storage = NSTextStorage(string: text, attributes: attributes)
        let container = NSTextContainer(size: constraintSize)
        let manager = NSLayoutManager()
        manager.addTextContainer(container)
        storage.addLayoutManager(manager)
        container.lineFragmentPadding = 0
        
        let glyphCount = manager.numberOfGlyphs
        
        var inSize = CGSize.zero
        var units = [TextUnit]()
        
        switch type {
        case (.AllatOnce, .ByObject):
            
            let usedRect = manager.usedRectForTextContainer(container)
            manager.enumerateLineFragmentsForGlyphRange(NSMakeRange(0, glyphCount), usingBlock: { (alineFragmentRect, usedlineFragmentRect, container, glyphRange, stop) in
                
                let r = manager.characterRangeForGlyphRange(glyphRange, actualGlyphRange: nil)
                //                let start = text.startIndex.advancedBy(r.location)
                //                let end = text.startIndex.advancedBy(r.location + r.length)
                let t = (text as NSString).substringWithRange(r)
                
                let lf = alineFragmentRect
                let ulf = usedlineFragmentRect
                let ur = ulf
                let cs = CGSize(width: constraintSize.width, height: usedRect.height)
                let unit = TextUnit(text: t, attriubtes: attributes, usedRect: ur, lineFragmentRect: lf, usedLineFragmentRect: ulf, constraintSize: cs, section: 0, row: 0)
                
                inSize = cs
                units.append(unit)
            })
            
        case (.AllatOnce, .ByCharacter):
            
            //            var section = 0
            //            var row = 0
            let text = text as NSString
            let usedRect = manager.usedRectForTextContainer(container)
            manager.enumerateLineFragmentsForGlyphRange(NSMakeRange(0, glyphCount), usingBlock: { (alineFragmentRect, usedlineFragmentRect, container, glyphRange, stop) in
                
                let location = glyphRange.location
                let length = glyphRange.length
                
                var nextLocation = location
                for l in location..<(location + length) {
                    
                    if l < nextLocation {
                        continue
                    }
                    
                    let r = NSMakeRange(l, 1)
                    
                    var p = r
                    let characterRange = manager.characterRangeForGlyphRange(r, actualGlyphRange: &p)
                    
                    if characterRange.length > 0 {
                        nextLocation = l + characterRange.length
                    }
                    //                    let start = text.startIndex.advancedBy(p.location)
                    //                    let end = text.startIndex.advancedBy(p.location + p.length)
                    let t = (text as NSString).substringWithRange(p)
                    
                    if t == " " || t == "\n" {
                        continue
                    }
                    
                    let lf = alineFragmentRect
                    let ulf = usedlineFragmentRect
                    let ur = manager.boundingRectForGlyphRange(r, inTextContainer: container)
                    let cs = CGSize(width: constraintSize.width, height: usedRect.height)
                    let unit = TextUnit(text: t, attriubtes: attributes, usedRect: ur, lineFragmentRect: lf, usedLineFragmentRect: ulf, constraintSize: cs, section: 0, row: l)
                    
                    inSize = cs
                    units.append(unit)
                    
                    //                    row += 1
                }
                
                //                section += 1
                //                row = 0
            })
            
            
        case (.ByLine, .ByObject):
            
            var section = 0
            let row = 0
            let usedRect = manager.usedRectForTextContainer(container)
            manager.enumerateLineFragmentsForGlyphRange(NSMakeRange(0, glyphCount), usingBlock: { (alineFragmentRect, usedlineFragmentRect, container, glyphRange, stop) in
                
                let r = manager.characterRangeForGlyphRange(glyphRange, actualGlyphRange: nil)
                //                let start = text.startIndex.advancedBy(r.location)
                //                let end = text.startIndex.advancedBy(r.location + r.length)
                let t = (text as NSString).substringWithRange(r)
                
                if t == " " || t == "\n" {
                    return
                }
                
                let lf = alineFragmentRect
                let ulf = usedlineFragmentRect
                let ur = ulf
                let cs = CGSize(width: constraintSize.width, height: usedRect.height)
                let unit = TextUnit(text: t, attriubtes: attributes, usedRect: ur, lineFragmentRect: lf, usedLineFragmentRect: ulf, constraintSize: cs, section: section, row: row)
                
                inSize = cs
                units.append(unit)
                
                section += 1
            })
            
        case (.ByLine, .ByCharacter):
            
            var section = 0
            var row = 0
            let text = text as NSString
            let usedRect = manager.usedRectForTextContainer(container)
            manager.enumerateLineFragmentsForGlyphRange(NSMakeRange(0, glyphCount), usingBlock: { (alineFragmentRect, usedlineFragmentRect, container, glyphRange, stop) in
                
                let location = glyphRange.location
                let length = glyphRange.length
                
                var nextLocation = location
                for l in location..<(location + length) {
                    
                    if l < nextLocation {
                        continue
                    }
                    
                    let r = NSMakeRange(l, 1)
                    
                    var p = r
                    let characterRange = manager.characterRangeForGlyphRange(r, actualGlyphRange: &p)
                    
                    if characterRange.length > 0 {
                        nextLocation = l + characterRange.length
                    }
                    //                    let start = text.startIndex.advancedBy(p.location)
                    //                    let end = text.startIndex.advancedBy(p.location + p.length)
                    let t = (text as NSString).substringWithRange(p)
                    
                    if t == " " || t == "\n" {
                        continue
                    }
                    
                    let lf = alineFragmentRect
                    let ulf = usedlineFragmentRect
                    let ur = manager.boundingRectForGlyphRange(r, inTextContainer: container)
                    let cs = CGSize(width: constraintSize.width, height: usedRect.height)
                    let unit = TextUnit(text: t, attriubtes: attributes, usedRect: ur, lineFragmentRect: lf, usedLineFragmentRect: ulf, constraintSize: cs, section: section, row: row)
                    
                    inSize = cs
                    units.append(unit)
                    
                    row += 1
                }
                
                section += 1
                row = 0
            })
        }
        
        return (units, inSize)
    }
}

