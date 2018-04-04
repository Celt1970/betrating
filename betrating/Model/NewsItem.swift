//
//  File.swift
//  betrating
//
//  Created by Yuriy borisov on 20.01.2018.
//  Copyright © 2018 Yuriy borisov. All rights reserved.
//

import Foundation
import UIKit

class NewsItem{
    var id: Int?
    var name: String?
    var preview: String?
    var date: String?
    var category: [String]?
    var content: String?
    var tags: [String]?
    
    
    var firstStr: String{
        var str1 = content?.components(separatedBy: "\n")
        let halfLenght = (str1?.count)! / 2
        let firstHalf = str1![0...halfLenght - 1]
        let content1 = firstHalf.joined(separator: "\n")
        return content1
    }
    var ssecondStr: String{
        var str1 = content?.components(separatedBy: "\n")
        let halfLenght = (str1?.count)! / 2
        let second = (str1?.count)! - halfLenght
        let firstHalf = str1![second...(str1?.count)! - 1]
        let content1 = firstHalf.joined(separator: "\n")
        return content1
    }
    var attrStr1: NSAttributedString{
        //            print(description)
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
        //            print(description)
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
    
    init (json: [ String : Any ]){
        self.id = json["id"] as? Int
        self.name = json["name"] as? String
        self.preview = json["preview"] as? String
        self.date = json["date"] as? String
        self.category = json["category"] as? [String]
        self.content = json["content"] as? String
        self.tags = json["tags"] as? [String]

    }
}
