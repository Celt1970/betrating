//
//  ScrollTest.swift
//  betrating
//
//  Created by Yuriy borisov on 15.01.2018.
//  Copyright © 2018 Yuriy borisov. All rights reserved.
//

import UIKit

class DetailedVC: UIViewController {
    @IBOutlet var myScroll: UIScrollView!
    
    @IBOutlet weak var forecastImage: UIImageView!
    @IBOutlet weak var leagueImage: UIImageView!
    @IBOutlet weak var leagueLabel: UILabel!
    @IBOutlet weak var forecastTextView: UITextView!
    @IBOutlet weak var darkView: UIView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var forecastLabel: UILabel!
    @IBOutlet weak var forecastDate: UILabel!
    
    var service: NetworkService?
    var session: URLSession{
        var config = URLSessionConfiguration.default
        return URLSession(configuration: config)
    }
    var id = 0
    var forecast: ForecastDetailed?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        service = NetworkService()
        darkView.isHidden = true
        activityIndicator.startAnimating()
        
        
        
        service?.getForecastById2(id, completion: { [weak self] forecast in
            
          
            guard forecast != nil else { return }
            self?.forecast = forecast!
            
            self?.leagueLabel.text = forecast!.category
            self?.forecastLabel.text = forecast!.name
            self?.forecastDate.text = forecast!.date
            
            self?.service?.loadImage(url: forecast!.preview!, completion: { image, connect2 in
                if connect2 == true {
                    return
                }
                guard image != nil else {return}
                self?.forecastImage.image = image
            })
            self?.service?.loadImage(url: forecast!.leaguePreview!, completion: { image, connect3 in
                if connect3 == true{
                    return
                }
                guard image != nil else {return}
                self?.leagueImage.image = image
            })
            self?.forecastTextView.attributedText = forecast!.attrStr

            self?.myScroll.reloadInputViews()
            self?.darkView.isHidden = false
            self?.activityIndicator.stopAnimating()

        })
        
        var contentRect = CGRect.zero
        
        for view in myScroll.subviews {
            contentRect = contentRect.union(view.frame)
        }
        myScroll.contentSize = contentRect.size

    }

}
