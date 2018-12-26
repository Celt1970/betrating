//
//  RatingByID.swift
//  betrating
//
//  Created by Yuriy borisov on 19.01.2018.
//  Copyright © 2018 Yuriy borisov. All rights reserved.
//

import Foundation
import UIKit

class RatingByID{
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
    var description: String?
    var firstStr: String{
        var str1 = description?.components(separatedBy: "\n")
        let halfLenght = (str1?.count)! / 2
        let firstHalf = str1![0...halfLenght - 1]
        let content1 = firstHalf.joined(separator: "\n")
        return content1
    }
    var ssecondStr: String{
        var str1 = description?.components(separatedBy: "\n")
        let halfLenght = (str1?.count)! / 2
        let second = (str1?.count)! - halfLenght
        let firstHalf = str1![second...(str1?.count)! - 1]
        let content1 = firstHalf.joined(separator: "\n")
        return content1
    }
    var attrStr1: NSAttributedString{
        let str1 = try!NSMutableAttributedString(data: firstStr.data(using: String.Encoding.unicode, allowLossyConversion: true)!,
                                                 options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue],
                                                 documentAttributes:  nil)
        let range = NSRange(location: 0, length: str1.length)
        
//        str1.addAttribute(NSAttributedStringKey.font, value: UIFont(name: "Helvetica", size: 15.0)!, range: range)
        str1.enumerateAttributes(in: range, options: .init(rawValue: 0), using: { (object, range, stop) in
            if object.keys.contains(NSAttributedStringKey.attachment) {
                if let attachment = object[NSAttributedStringKey.attachment] as? NSTextAttachment {
                    let currentHeight = attachment.bounds.height
                    let currentWidth = attachment.bounds.width
                    let ratio = currentWidth / currentHeight
                    attachment.bounds = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width - 20, height: (UIScreen.main.bounds.width - 20) / ratio)
                }
            }        
        })
        
        str1.enumerateAttribute(.font, in: range, options: .init(rawValue: 0), using: { (value, ranged, stop) in
            if let f = value as? UIFont{
                let new = f.withSize(17.0)
                str1.removeAttribute(.font, range: ranged)
                str1.addAttribute(.font, value: new, range: ranged)
            }
        })
        
        
        return str1
    }
        var attrStr2: NSAttributedString{
            let str1 = try!NSMutableAttributedString(data: ssecondStr.data(using: String.Encoding.unicode, allowLossyConversion: true)!,
                                                     options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue],
                                                     documentAttributes:  nil)
            let range = NSRange(location: 0, length: str1.length)
            
            //        str1.addAttribute(NSAttributedStringKey.font, value: UIFont(name: "Helvetica", size: 15.0)!, range: range)
            str1.enumerateAttributes(in: range, options: .init(rawValue: 0), using: { (object, range, stop) in
                if object.keys.contains(NSAttributedStringKey.attachment) {
                    if let attachment = object[NSAttributedStringKey.attachment] as? NSTextAttachment {
                        let currentHeight = attachment.bounds.height
                        let currentWidth = attachment.bounds.width
                        let ratio = currentWidth / currentHeight
                        attachment.bounds = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width - 20, height: (UIScreen.main.bounds.width - 20) / ratio)
                    }
                }
            })
            
            str1.enumerateAttribute(.font, in: range, options: .init(rawValue: 0), using: { (value, ranged, stop) in
                if let f = value as? UIFont{
                    let new = f.withSize(17.0)
                    str1.removeAttribute(.font, range: ranged)
                    str1.addAttribute(.font, value: new, range: ranged)
                }
            })
            
            
            return str1
        }
    
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
        self.description = json["description"] as? String
    }
}
