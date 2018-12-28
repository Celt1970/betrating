//
//  ForecastDetailed.swift
//  betrating
//
//  Created by Yuriy borisov on 18.01.2018.
//  Copyright © 2018 Yuriy borisov. All rights reserved.
//

import Foundation
import UIKit

struct ForecastByIdItem: Codable {
    let name: String
    let id: Int
    let leaguePreviewURL: URL
    let category: BetratingCategory
    let date: BetratingDate
    let permalink: URL
    let content: String
    let previewURL: URL
    var fullDate:String {
        return date.fullDate
    }
    var header: String {
        return [category.name, category.parent?.name].compactMap {return $0}.joined(separator: " • ")
    }
    var attrStr: NSAttributedString{
        return NSAttributedString.getAttributedStringFromHTML(from: content)
    }
    
    enum CodingKeys: String, CodingKey {
        case name
        case id
        case leaguePreviewURL = "league_preview"
        case date
        case permalink
        case content
        case previewURL = "preview"
        case category
    }
}
