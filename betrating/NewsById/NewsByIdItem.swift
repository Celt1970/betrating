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
        return name.htmlDecoded
    }
    func getTags() -> String {
        return tags.map {
            return "#" + $0
        }.joined(separator: "\n")
    }
}

extension String {
    var htmlDecoded: String {
        let decoded = try? NSAttributedString(data: Data(utf8), options: [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
            ], documentAttributes: nil).string
        
        return decoded ?? self
    }
}
