//
//  ForecastDetailed.swift
//  betrating
//
//  Created by Yuriy borisov on 18.01.2018.
//  Copyright © 2018 Yuriy borisov. All rights reserved.
//

import Foundation
import UIKit

struct ForecastDetailed: Codable {
    let name: String
    let id: Int
    let leaguePreviewURL: URL
    let category: BetratingCategory
    let date: BetratingDate
    let permalink: URL
    let content: String
    let previewURL: URL
    var fullDate:String {
        return date.fullDate
    }
    var header: String {
        return [category.name, category.parent?.name].compactMap {return $0}.joined(separator: " • ")
    }
    var attrStr: NSAttributedString{
        return getAttributedStrting(from: content)
    }
    
    enum CodingKeys: String, CodingKey {
        case name
        case id
        case leaguePreviewURL = "league_preview"
        case date
        case permalink
        case content
        case previewURL = "preview"
        case category
    }
    
    private func getAttributedStrting(from str: String) -> NSAttributedString {
        
        let attributedString = try!NSMutableAttributedString(data: str.data(using: String.Encoding.unicode,
                                                                            allowLossyConversion: true)!,
                                                             options: [.documentType: NSAttributedString.DocumentType.html,
                                                                       .characterEncoding: String.Encoding.utf8.rawValue],
                                                             documentAttributes:  nil)
        
        let range = NSRange(location: 0, length: attributedString.length)
        
        attributedString.enumerateAttributes(in: range, options: .init(rawValue: 0), using: { (object, range, stop) in
            if object.keys.contains(NSAttributedStringKey.attachment) {
                if let attachment = object[NSAttributedStringKey.attachment] as? NSTextAttachment {
                    let currentHeight = attachment.bounds.height
                    let currentWidth = attachment.bounds.width
                    let ratio = currentWidth / currentHeight
                    attachment.bounds = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width - 20, height: (UIScreen.main.bounds.width - 20) / ratio)
                }
            }
        })
        
        attributedString.enumerateAttribute(.font, in: range, options: .init(rawValue: 0), using: { (value, ranged, stop) in
            if let f = value as? UIFont{
                let new = f.withSize(17.0)
                attributedString.removeAttribute(.font, range: ranged)
                attributedString.addAttribute(.font, value: new, range: ranged)
            }
        })
        return attributedString
    }
    
}
