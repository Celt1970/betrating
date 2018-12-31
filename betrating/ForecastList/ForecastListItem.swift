//
//  ForecastSmall.swift
//  betrating
//
//  Created by Yuriy borisov on 17.01.2018.
//  Copyright © 2018 Yuriy borisov. All rights reserved.
//

import Foundation

struct ForecastListItem: Codable, ListItem {
    let name: String
    let id: Int
    let preview: URL
    var date: String {
        return fullDate.fullDate
    }
    let category: BetratingCategory
    let fullDate: BetratingDate
    
    var header: String {
        return [category.name, category.parent?.name].compactMap {return $0}.joined(separator: " • ")
    }
    var slug: String? {
        return category.parent?.parent?.slug
    }
    var fullName: String {
        return name.replacingOccurrences(of: "&#171;", with: "\"").replacingOccurrences(of: "&#187;", with: "\"")
    }
    
    enum CodingKeys: String, CodingKey {
        case name
        case id
        case preview = "league_preview"
        case fullDate = "date"
        case category
    }
}
