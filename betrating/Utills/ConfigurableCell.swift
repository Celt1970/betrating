//
//  ConfigurableNewsListCell.swift
//  betrating
//
//  Created by Yuriy Borisov on 28/12/2018.
//  Copyright © 2018 Yuriy borisov. All rights reserved.
//

import Foundation
import UIKit

protocol ConfigurableCell: class {
    var image: UIImageView! {get set}
    var contentLabel: UILabel! {get set}
    var groupLabel: UILabel! {get set}
    var dateLabel: UILabel! {get set}
    var tag: Int {get}
    
    func configureCell(currentNews:ListItem?, indexPath: IndexPath)
    func configure(currentNews:ListItem?, indexPath: IndexPath )
}

extension ConfigurableCell where Self: UICollectionViewCell {
    func configureCell(currentNews:ListItem?, indexPath: IndexPath) {
        self.image.image = nil
        tag = indexPath.row
        
        self.contentLabel.text = currentNews?.name
        self.groupLabel.text = currentNews?.header
        self.dateLabel.text = currentNews?.date
        self.contentView.layer.cornerRadius = 5.0
        self.contentView.layer.borderWidth = 1.01
        self.contentView.layer.borderColor = UIColor.clear.cgColor
        self.contentView.layer.masksToBounds = true
        
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 5.0)
        self.layer.shadowRadius = 3.0
        self.layer.shadowOpacity = 0.8
        self.layer.masksToBounds = false
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.contentView.layer.cornerRadius).cgPath
    }
}
