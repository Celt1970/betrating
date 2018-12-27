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
    let league: URL
    let date: ForecastDate
    let category: ForecastCategory
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
        case league = "league_preview"
        case date
        case category
    }
    
    struct ForecastDate: Codable {
        let day: String
        let month: String
        let time: String
        
        var fullDate: String{
           return "\(day) \(month) \(time)"
        }
    }
    
    class ForecastCategory: Codable {
        let id: Int
        let slug: String
        let name: String
        let parent: ForecastCategory?
    }
}
