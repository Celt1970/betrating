//
//  BetratingCategory.swift
//  betrating
//
//  Created by Yuriy Borisov on 27/12/2018.
//  Copyright © 2018 Yuriy borisov. All rights reserved.
//

import Foundation

class BetratingCategory: Codable {
    let id: Int
    let slug: String
    let name: String
    let parent: BetratingCategory?
}
