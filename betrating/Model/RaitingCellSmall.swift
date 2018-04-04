//
//  RaitingCellSmall.swift
//  betrating
//
//  Created by Yuriy borisov on 13.01.2018.
//  Copyright © 2018 Yuriy borisov. All rights reserved.
//

import UIKit

class RaitingCellSmall: UICollectionViewCell {
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var likesCounter: UILabel!
    @IBOutlet weak var heartImage: UIImageView!
    
    @IBOutlet weak var firstStar: UIImageView!
    @IBOutlet weak var secondStar: UIImageView!
    @IBOutlet weak var thirdStar: UIImageView!
    @IBOutlet weak var fourthStar: UIImageView!
    @IBOutlet weak var fifthStar: UIImageView!
    
    func configure(raiting: RaitingsList, service: NetworkService?, indexPath: IndexPath, collectionView: UICollectionView){
        self.logoImage.image = nil
        self.tag = indexPath.row
        
        self.likesCounter.text = "\(String(describing: raiting.votes!))"
        switch raiting.rating! {
        case 1:
            firstStar.image = #imageLiteral(resourceName: "Star")
            secondStar.image = #imageLiteral(resourceName: "emptyStar")
            thirdStar.image = #imageLiteral(resourceName: "emptyStar")
            fourthStar.image = #imageLiteral(resourceName: "emptyStar")
            fifthStar.image = #imageLiteral(resourceName: "emptyStar")
        case 2:
            firstStar.image = #imageLiteral(resourceName: "Star")
            secondStar.image = #imageLiteral(resourceName: "Star")
            thirdStar.image = #imageLiteral(resourceName: "emptyStar")
            fourthStar.image = #imageLiteral(resourceName: "emptyStar")
            fifthStar.image = #imageLiteral(resourceName: "emptyStar")

        case 3:
            firstStar.image = #imageLiteral(resourceName: "Star")
            secondStar.image = #imageLiteral(resourceName: "Star")
            thirdStar.image = #imageLiteral(resourceName: "Star")
            fourthStar.image = #imageLiteral(resourceName: "emptyStar")
            fifthStar.image = #imageLiteral(resourceName: "emptyStar")

        case 4:
            firstStar.image = #imageLiteral(resourceName: "Star")
            secondStar.image = #imageLiteral(resourceName: "Star")
            thirdStar.image = #imageLiteral(resourceName: "Star")
            fourthStar.image = #imageLiteral(resourceName: "Star")
            fifthStar.image = #imageLiteral(resourceName: "emptyStar")

        case 5:
            firstStar.image = #imageLiteral(resourceName: "Star")
            secondStar.image = #imageLiteral(resourceName: "Star")
            thirdStar.image = #imageLiteral(resourceName: "Star")
            fourthStar.image = #imageLiteral(resourceName: "Star")
            fifthStar.image = #imageLiteral(resourceName: "Star")

        default:
            print("default")
            break
        }
        self.bounds.size.width = (collectionView.bounds.size.width - 20 ) / 2 - 3.5
        self.bounds.size.height = collectionView.bounds.size.width / 3
        
        self.contentView.layer.cornerRadius = 5.0
        self.contentView.layer.borderWidth = 1.0
        self.contentView.layer.borderColor = UIColor.clear.cgColor
        self.contentView.layer.masksToBounds = true
        
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 4.0)
        self.layer.shadowRadius = 3.0
        self.layer.shadowOpacity = 0.8
        self.layer.masksToBounds = false
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.contentView.layer.cornerRadius).cgPath
        guard service != nil else {return}
        
        service?.loadImage(url: raiting.logo!, completion: { [ weak self ] image, connect in
            if connect == true{
                return
            }
            if self?.tag == indexPath.row{
                self?.logoImage.image = image
            }
        })
    }
}
