//
//  ExtensionNSAttributedString.swift
//  betrating
//
//  Created by Yuriy Borisov on 28/12/2018.
//  Copyright © 2018 Yuriy borisov. All rights reserved.
//

import UIKit

extension NSAttributedString {
    static func getAttributedStringFromHTML(from str: String) -> NSAttributedString {
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
