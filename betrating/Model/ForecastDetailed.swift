//
//  ForecastDetailed.swift
//  betrating
//
//  Created by Yuriy borisov on 18.01.2018.
//  Copyright © 2018 Yuriy borisov. All rights reserved.
//

import Foundation
import UIKit

class ForecastDetailed{
    var id: Int?
    var name: String?
    var leaguePreview: String?
    var preview: String?
    var date: String?
    var category: String?
    var content: String?
    var publishedAt: String?
    var firstParent: String?
    var secondParent: String?
    var thirdParent: String?
    var attrStr: NSAttributedString{
        let str = try!NSMutableAttributedString(data: content!.data(using: String.Encoding.unicode, allowLossyConversion: true)!,
                                          options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue],
                                          documentAttributes:  nil)
        let range = NSRange(location: 0, length: str.length)

        str.addAttribute(NSAttributedStringKey.font, value: UIFont(name: "Helvetica", size: 15.0)!, range: range)
        return str
    }
    init (json: [String:Any]){
        self.name = (json["name"] as? String) ?? ""
        self.leaguePreview = (json["league_preview"] as? String) ?? ""
        self.id = (json["id"] as? Int) ?? 0
        let date = json["date"] as! [String : Any]
        let month = date["month"] as! String
        let day = date["day"] as! String
        let time = date["time"] as! String
        self.date = "\(day) \(month) \(time)"
        self.preview = (json["preview"] as? String) ?? ""
        self.content = json["content"] as? String
        let cat = (json["category"] as? [String:Any])
        if cat != nil{
            self.category = (cat!["name"] as? String) ?? ""
        }
    }
}
