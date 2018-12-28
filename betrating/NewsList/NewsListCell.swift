//
//  NewsCell.swift
//  betrating
//
//  Created by Yuriy borisov on 14.01.2018.
//  Copyright © 2018 Yuriy borisov. All rights reserved.
//

import UIKit

class NewsCell: UICollectionViewCell, ConfigurableNewsListCell {
    
    
    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var viewForLabels: UIView!
    @IBOutlet weak var newsLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var groupLabel: UILabel!

    func configure(currentNews:NewsListItem?, indexPath: IndexPath ){
        self.configureCell(currentNews: currentNews, indexPath: indexPath)
        self.viewForLabels.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.7)
    }
    
}

class NewsCellSmall: UICollectionViewCell, ConfigurableNewsListCell {
    
    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var newsLabel: UILabel!
    @IBOutlet weak var groupLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!

    func configure(currentNews:NewsListItem?, indexPath: IndexPath){
        self.configureCell(currentNews: currentNews, indexPath: indexPath)
    }
}
