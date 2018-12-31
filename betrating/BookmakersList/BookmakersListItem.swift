//
//  BookmakersListItem.swift
//  betrating
//
//  Created by Yuriy borisov on 18.01.2018.
//  Copyright © 2018 Yuriy borisov. All rights reserved.
//

import Foundation
import UIKit

struct BookmakersListItem2: Codable, BookmakerCompare {
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

protocol BookmakerCompare {
    var rating: Int {get}
    var russianLanguage: Bool{get}
    var russianSupport: Bool{get}
    var live: Bool{get}
    var bonus: Int{get}
    var hasProfeesional: Bool{get}
    var hasDemo: Bool{get}
    var hasBetting: Bool{get}
    var hasMobileMode: Bool{get}
    var legal: Bool {get}

    func isEqualTo (_ rhs: BookmakersListItem2) -> Bool
}

extension BookmakerCompare {
    func isEqualTo (_ rhs: BookmakersListItem2) -> Bool {
        if self.legal == rhs.legal,
            self.rating >= rhs.rating,
            self.russianLanguage == rhs.russianLanguage,
            self.russianSupport == rhs.russianSupport,
            self.live == rhs.live,
            self.hasProfeesional == rhs.hasProfeesional,
            self.hasDemo == rhs.hasDemo,
            self.hasBetting == rhs.hasBetting,
            self.hasMobileMode == rhs.hasMobileMode,
            self.bonus == rhs.bonus
            {
            return true
        } else {
            return false
        }
    }
}

struct BookMakerListItemMock: BookmakerCompare {
    var hasMobileMode: Bool
    var legal: Bool
    var rating: Int
    var russianLanguage: Bool
    var russianSupport: Bool
    var live: Bool
    var bonus: Int
    var hasProfeesional: Bool
    var hasDemo: Bool
    var hasBetting: Bool
}
