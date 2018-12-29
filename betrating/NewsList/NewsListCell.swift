//
//  NewsCell.swift
//  betrating
//
//  Created by Yuriy borisov on 14.01.2018.
//  Copyright © 2018 Yuriy borisov. All rights reserved.
//

import UIKit

class NewsCell: UICollectionViewCell, ConfigurableCell {
    
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var viewForLabels: UIView!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var groupLabel: UILabel!

    func configure(currentNews:ListItem?, indexPath: IndexPath ){
        self.configureCell(currentNews: currentNews, indexPath: indexPath)
        self.viewForLabels.backgroundColor = BetratingColors.betRatingBlackWithoutAlpha
    }
    
}

class NewsCellSmall: UICollectionViewCell, ConfigurableCell {
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var groupLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!

    func configure(currentNews:ListItem?, indexPath: IndexPath){
        self.configureCell(currentNews: currentNews, indexPath: indexPath)
    }
}
