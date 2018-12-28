//
//  Extension StringDevideByTwo.swift
//  betrating
//
//  Created by Yuriy Borisov on 28/12/2018.
//  Copyright © 2018 Yuriy borisov. All rights reserved.
//

import Foundation

extension String {
    func devideByTwo(isFirstHalf: Bool) -> String {
        var str = self.components(separatedBy: "\n")
        let halfLenght = (str.count) / 2
        let second = (str.count) - halfLenght
        let firstPart = str[0...halfLenght - 1]
        let secondPart = str[second...(str.count) - 1]
        if isFirstHalf {
            let content1 = firstPart.joined(separator: "\n")
            return content1
        } else {
            let content1 = secondPart.joined(separator: "\n")
            return content1
        }
    }
}
