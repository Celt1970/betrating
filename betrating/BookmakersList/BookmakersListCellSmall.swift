//
//  BookmakersListCellSmall.swift
//  betrating
//
//  Created by Yuriy borisov on 13.01.2018.
//  Copyright © 2018 Yuriy borisov. All rights reserved.
//

import UIKit

class BookmakersListCellSmall: UICollectionViewCell {
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var likesCounter: UILabel!
    @IBOutlet weak var heartImage: UIImageView!
    
    @IBOutlet weak var stackViewForStars: UIStackView!
    @IBOutlet weak var firstStar: UIImageView!
    @IBOutlet weak var secondStar: UIImageView!
    @IBOutlet weak var thirdStar: UIImageView!
    @IBOutlet weak var fourthStar: UIImageView!
    @IBOutlet weak var fifthStar: UIImageView!
    
    func configure(raiting: BookmakersListItem,
                   service: NetworkService,
                   indexPath: IndexPath){
        
        self.logoImage.image = nil
        self.tag = indexPath.row
        
        self.likesCounter.text = "\(String(describing: raiting.votes!))"
        if let stars = stackViewForStars.arrangedSubviews as? [UIImageView] {
            for (index, star) in stars.enumerated() {
                if index < raiting.rating! {
                    star.image = UIImage(named: "Star")
                } else {
                    star.image = UIImage(named: "emptyStar")
                }
            }
        }
        
        self.contentView.layer.cornerRadius = 5.0
        self.contentView.layer.borderWidth = 1.0
        self.contentView.layer.borderColor = UIColor.clear.cgColor
        self.contentView.layer.masksToBounds = true
        
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 4.0)
        self.layer.shadowRadius = 3.0
        self.layer.shadowOpacity = 0.8
        self.layer.masksToBounds = false
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds,
                                             cornerRadius: self.contentView.layer.cornerRadius).cgPath
        
        service.loadImage(url: raiting.logo!, completion: { [ weak self ] image, connect in
            if connect == true{
                return
            }
            if self?.tag == indexPath.row{
                self?.logoImage.image = image
            }
        })
    }
}
