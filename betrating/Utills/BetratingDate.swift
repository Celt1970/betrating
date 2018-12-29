//
//  BetratingDate.swift
//  betrating
//
//  Created by Yuriy Borisov on 27/12/2018.
//  Copyright © 2018 Yuriy borisov. All rights reserved.
//

import Foundation

struct BetratingDate: Codable {
    let day: String
    let month: String
    let time: String
    
    var fullDate: String{
        return "\(day) \(month) \(time)"
    }
}
