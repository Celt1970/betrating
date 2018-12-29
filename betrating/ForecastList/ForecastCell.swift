//
//  ForecastCell.swift
//  betrating
//
//  Created by Yuriy borisov on 15.01.2018.
//  Copyright © 2018 Yuriy borisov. All rights reserved.
//

import UIKit

class ForecastCell: UICollectionViewCell, ConfigurableCell {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var groupLabel: UILabel!
    
    func configure(currentNews: ListItem?, indexPath: IndexPath) {
        self.configureCell(currentNews: currentNews, indexPath: indexPath)
    }
}
