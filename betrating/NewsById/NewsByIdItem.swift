//
//  NewsByIdItem.swift
//  betrating
//
//  Created by Yuriy borisov on 20.01.2018.
//  Copyright © 2018 Yuriy borisov. All rights reserved.
//

import Foundation
import UIKit

struct NewsByIdItem: Codable {
    let id: Int
    let name: String
    let preview: URL
    let date: String
    let category: [String]
    let permalink: URL
    let tags: [String]
    let content: String
    
    var attrStr1: NSAttributedString{
        let firstStr = content.devideByTwo(isFirstHalf: true)
        return NSAttributedString.getAttributedStringFromHTML(from: firstStr)
    }
    var attrStr2: NSAttributedString{
        let secondStr = content.devideByTwo(isFirstHalf: false)
        return NSAttributedString.getAttributedStringFromHTML(from: secondStr)
    }
    var fullName: String {
        return name.replacingOccurrences(of: "&#171;", with: "\"").replacingOccurrences(of: "&#187;", with: "\"")
    }
    func getTags() -> String {
        return tags.map {
            return "#" + $0
        }.joined(separator: "\n")
    }
}
    
    

