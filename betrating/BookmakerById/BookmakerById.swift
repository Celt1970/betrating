//
//  RatingByID.swift
//  betrating
//
//  Created by Yuriy borisov on 19.01.2018.
//  Copyright © 2018 Yuriy borisov. All rights reserved.
//

import Foundation
import UIKit

struct BookmakerById: Codable {
    let id: Int
    let name: String
    let logo: URL
    let votes: Int
    let rating: Int
    let description: String
    var attrStr1: NSAttributedString{
        let firstStr = description.devideByTwo(isFirstHalf: true)
        return NSAttributedString.getAttributedStringFromHTML(from: firstStr)
    }
    var attrStr2: NSAttributedString{
        let secondStr = description.devideByTwo(isFirstHalf: false)
        return NSAttributedString.getAttributedStringFromHTML(from: secondStr)
    }
    var fullName: String {
        return name.replacingOccurrences(of: "&#171;", with: "\"").replacingOccurrences(of: "&#187;", with: "\"")
    }
}
