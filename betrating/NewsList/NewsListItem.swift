//
//  NewsList.swift
//  betrating
//
//  Created by Yuriy borisov on 20.01.2018.
//  Copyright © 2018 Yuriy borisov. All rights reserved.
//

import Foundation

struct NewsListItem: Codable {
    var id: Int
    var name: String
    var preview: URL
    var date: String
    var category: [String]
    var allcategoryes: String{
        let str = category.joined(separator: " • ")
        return str
    }
}
