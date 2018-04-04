//
//  NewsList.swift
//  betrating
//
//  Created by Yuriy borisov on 20.01.2018.
//  Copyright © 2018 Yuriy borisov. All rights reserved.
//

import Foundation

class NewsListItem{
    var id: Int?
    var name: String?
    var preview: String?
    var date: String?
    var category: [String]?
    var allcategoryes: String{
        let str = category?.joined(separator: " • ") ?? ""
        return str
    }
    
    init (json: [String : Any]){
        self.id = json["id"] as? Int
        self.name = json["name"] as? String
        self.preview = json["preview"] as? String
        self.date = json["date"] as? String
        self.category = json["category"] as? [String]
    }
    
}
