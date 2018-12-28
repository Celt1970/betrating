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
    
    func configure(currentNews:NewsListItem?, service: NetworkService?, indexPath: IndexPath, collectionView: UICollectionView){
        
        self.configureCell(currentNews: currentNews, service: service, indexPath: indexPath)
        self.viewForLabels.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.7)
    }
    
}

class NewsCellSmall: UICollectionViewCell, ConfigurableNewsListCell {
    
    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var newsLabel: UILabel!
    @IBOutlet weak var groupLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    func configure(currentNews:NewsListItem?, service: NetworkService?, indexPath: IndexPath, collectionView: UICollectionView){
        self.configureCell(currentNews: currentNews, service: service, indexPath: indexPath)
    }
    
}

 protocol ConfigurableNewsListCell: class {
    var newsImage: UIImageView! {get set}
    var newsLabel: UILabel! {get set}
    var groupLabel: UILabel! {get set}
    var dateLabel: UILabel! {get set}
    
    func configureCell(currentNews:NewsListItem?, service: NetworkService?, indexPath: IndexPath)
}

extension ConfigurableNewsListCell where Self: UICollectionViewCell {
    func configureCell(currentNews:NewsListItem?, service: NetworkService?, indexPath: IndexPath) {
        self.newsImage.image = nil
        self.tag = indexPath.row
        
        self.newsLabel.text = currentNews?.name
        self.groupLabel.text = currentNews?.allcategoryes
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
        if currentNews?.preview != nil{
            guard service != nil else {return}
            
            service?.loadImage(url: (currentNews?.preview)!, completion: { image, connect in
                if connect == true{
                    return
                }
                if self.tag == indexPath.row{
                    self.newsImage.image = image
                }
            })
        }
    
    }
}
