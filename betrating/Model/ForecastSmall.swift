//
//  ForecastSmall.swift
//  betrating
//
//  Created by Yuriy borisov on 17.01.2018.
//  Copyright © 2018 Yuriy borisov. All rights reserved.
//

import Foundation

struct ForecastSmall: Codable {
    let name: String
    let id: Int
    let leaguePreviewURL: URL
    let date: BetratingDate
    let category: BetratingCategory
    var fullDate:String {
        return date.fullDate
    }
    var header: String {
        return [category.name, category.parent?.name].compactMap {return $0}.joined(separator: " • ")
    }
    var slug: String? {
        return category.parent?.parent?.slug
    }
    
    enum CodingKeys: String, CodingKey {
        case name
        case id
        case leaguePreviewURL = "league_preview"
        case date
        case category
    }
}
