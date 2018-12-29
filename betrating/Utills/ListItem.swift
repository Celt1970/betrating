//
//  ListItem.swift
//  betrating
//
//  Created by Yuriy Borisov on 29/12/2018.
//  Copyright © 2018 Yuriy borisov. All rights reserved.
//

import Foundation

protocol ListItem {
    var name: String {get}
    var id: Int {get}
    var preview: URL {get}
    var date: String {get}
    var header: String {get}
}
