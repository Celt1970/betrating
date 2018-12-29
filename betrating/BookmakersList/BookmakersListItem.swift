//
//  BookmakersListItem.swift
//  betrating
//
//  Created by Yuriy borisov on 18.01.2018.
//  Copyright © 2018 Yuriy borisov. All rights reserved.
//

import Foundation
import UIKit

class BookmakersListItem {
    var id: Int?
    var name: String?
    var logo: String?
    var votes: Int?
    var legal: Bool?
    var rating: Int?
    var russianLanguage: Bool?
    var russianSupport: Bool?
    var currensies: [String]?
    var live: Bool?
    var bonus: Int?
    var hasProfeesional: Bool?
    var hasDemo: Bool?
    var hasBetting: Bool?
    var hasMobileMode: Bool?

    
    init(json: [String : Any]) {
        self.id = json["id"] as? Int
        self.name = json["name"] as? String
        self.logo = json["logo"] as? String
        self.votes = json["votes"] as? Int
        self.legal = json["legal"] as? Bool
        self.rating = json ["rating"] as? Int
        self.russianLanguage = json["russian_language"] as? Bool
        self.russianSupport = json["russian_support"] as? Bool
        self.currensies = json["currencies"] as? [String]
        self.live = json["live"] as? Bool
        self.bonus = json["bonus"] as? Int
        self.hasProfeesional = json["has_professional"] as? Bool
        self.hasDemo = json["has_demo"] as? Bool
        self.hasBetting = json["has_betting"] as? Bool
        self.hasMobileMode = json["has_mobile_mode"] as? Bool
    }
}

struct BookmakersListItem2: Codable {
    let id: Int
    let name: String
    let logo: String
    let votes: Int
    let legal: Bool
    let rating: Int
    let russianLanguage: Bool
    let russianSupport: Bool
    let live: Bool
    let bonus: Int
    let hasProfeesional: Bool
    let hasDemo: Bool
    let hasBetting: Bool
    let hasMobileMode: Bool
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case logo
        case votes
        case legal
        case rating
        case russianLanguage = "russian_language"
        case russianSupport = "russian_support"
        case live
        case bonus
        case hasProfeesional = "has_professional"
        case hasDemo = "has_demo"
        case hasBetting = "has_betting"
        case hasMobileMode = "has_mobile_mode"
    }
}

