//
//  File.swift
//  betrating
//
//  Created by Yuriy borisov on 20.01.2018.
//  Copyright © 2018 Yuriy borisov. All rights reserved.
//

import Foundation
import UIKit

struct NewsItem: Codable {
    let id: Int
    let name: String
    let preview: URL
    let date: String
    let category: [String]
    let permalink: URL
    let tags: [String]
    let content: String
    
    var attrStr1: NSAttributedString{
        let firstStr = getString(isFirstHalf: true)
        return getAttributedStrting(from: firstStr)
    }
    var attrStr2: NSAttributedString{
        let secondStr = getString(isFirstHalf: false)
        return getAttributedStrting(from: secondStr)
    }
    
    func getTags() -> String {
        return tags.map {
            return "#" + $0
        }.joined(separator: "\n")
    }
    
    private func getString(isFirstHalf: Bool) -> String {
        var str = content.components(separatedBy: "\n")
        let halfLenght = (str.count) / 2
        let second = (str.count) - halfLenght
        let firstPart = str[0...halfLenght - 1]
        let secondPart = str[second...(str.count) - 1]
        if isFirstHalf {
            let content1 = firstPart.joined(separator: "\n")
            return content1
        } else {
            let content1 = secondPart.joined(separator: "\n")
            return content1
        }
    }
    
    private func getAttributedStrting(from str: String) -> NSAttributedString {
        
        let attributedString = try!NSMutableAttributedString(data: str.data(using: String.Encoding.unicode,
                                                                            allowLossyConversion: true)!,
                                                             options: [.documentType: NSAttributedString.DocumentType.html,
                                                                       .characterEncoding: String.Encoding.utf8.rawValue],
                                                             documentAttributes:  nil)
        
        let range = NSRange(location: 0, length: attributedString.length)
        
        attributedString.enumerateAttributes(in: range, options: .init(rawValue: 0), using: { (object, range, stop) in
            if object.keys.contains(NSAttributedStringKey.attachment) {
                if let attachment = object[NSAttributedStringKey.attachment] as? NSTextAttachment {
                    let currentHeight = attachment.bounds.height
                    let currentWidth = attachment.bounds.width
                    let ratio = currentWidth / currentHeight
                    attachment.bounds = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width - 20, height: (UIScreen.main.bounds.width - 20) / ratio)
                }
            }
        })
        
        attributedString.enumerateAttribute(.font, in: range, options: .init(rawValue: 0), using: { (value, ranged, stop) in
            if let f = value as? UIFont{
                let new = f.withSize(17.0)
                attributedString.removeAttribute(.font, range: ranged)
                attributedString.addAttribute(.font, value: new, range: ranged)
            }
        })
        return attributedString
    }
}
