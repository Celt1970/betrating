//
//  ForecastCell.swift
//  betrating
//
//  Created by Yuriy borisov on 15.01.2018.
//  Copyright © 2018 Yuriy borisov. All rights reserved.
//

import UIKit

class ForecastCell: UICollectionViewCell {
    
    @IBOutlet weak var forecastImage: UIImageView!
    @IBOutlet weak var forecastTextLabel: UILabel!
    @IBOutlet weak var leagueLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    func configCell(currentForecast: ForecastListItem?, service: NetworkService?, indexPath: IndexPath){
        self.dateLabel.text = currentForecast?.fullDate
        self.forecastTextLabel.text = currentForecast?.name
        self.leagueLabel.text = currentForecast?.header
        
        self.forecastImage.image = nil
        self.tag = indexPath.row
        if currentForecast?.leaguePreviewURL != nil{
            guard service != nil else {return}

            service!.loadImage(url: currentForecast?.leaguePreviewURL.absoluteString, completion: { image, connect in
                if connect == true{
                    return
                }
                if self.tag == indexPath.row{
                    self.forecastImage.image = image
                }
            })
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
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.contentView.layer.cornerRadius).cgPath
    }
}
