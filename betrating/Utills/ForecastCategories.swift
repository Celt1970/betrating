//
//  ForecastCategories.swift
//  betrating
//
//  Created by Yuriy Borisov on 28/12/2018.
//  Copyright © 2018 Yuriy borisov. All rights reserved.
//

import Foundation

enum ForecastCategories: String{
    case all = "Все"
    case soccer = "Футбол"
    case hockey = "Хоккей"
    case tennis = "Теннис"
    case basketball = "Баскетбол"
    
    func getCategory() -> String{
        switch self {
        case .all:
            return "all"
        case .soccer:
            return "soccer"
        case .hockey:
            return "hockey"
        case .tennis:
            return "tennis"
        case .basketball:
            return "basketball"
        }
        
    }
}
