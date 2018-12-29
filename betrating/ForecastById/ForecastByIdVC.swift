//
//  ScrollTest.swift
//  betrating
//ForecastByIdVC
//  Created by Yuriy borisov on 15.01.2018.
//  Copyright © 2018 Yuriy borisov. All rights reserved.
//

import UIKit

class ForecastByIdVC: UIViewController {
    @IBOutlet var myScroll: UIScrollView!
    @IBOutlet weak var forecastImage: UIImageView!
    @IBOutlet weak var leagueImage: UIImageView!
    @IBOutlet weak var leagueLabel: UILabel!
    @IBOutlet weak var forecastTextView: UITextView!
    @IBOutlet weak var darkView: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var forecastLabel: UILabel!
    @IBOutlet weak var forecastDate: UILabel!
    @IBOutlet weak var contentView: UIView!
    
    var service = NetworkService()
    var id = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        update(.start)
        fetchData()
    }
    private func fetchData() {
        service.getForecastById(id, completion: { [weak self] forecast in
            guard let forecast = forecast else {
                self?.update(.stop)
                return
            }
            self?.populateUI(forecast: forecast)
            self?.setupScrollView()
        })
    }
    
    private func populateUI(forecast: ForecastByIdItem) {
        let dispatchGroup: DispatchGroup = DispatchGroup()
        var tempForecastImage: UIImage? = nil
        var tempLeagueImage: UIImage? = nil
        
        dispatchGroup.enter()
        service.loadImage(url: forecast.previewURL, completion: { image in
            tempForecastImage = image
            dispatchGroup.leave()
        })
        
        dispatchGroup.enter()
        service.loadImage(url: forecast.leaguePreviewURL, completion: { image in
            tempLeagueImage = image
            dispatchGroup.leave()
        })
        
        dispatchGroup.notify(queue: DispatchQueue.main) {
            self.update(.stop)
            self.leagueImage.image = tempLeagueImage
            self.forecastImage.image = tempForecastImage
            self.leagueLabel.text = forecast.header
            self.forecastLabel.text = forecast.name
            self.forecastDate.text = forecast.fullDate
            self.forecastTextView.attributedText = forecast.attrStr

        }
    }
    
    private func setupScrollView() {
        var contentRect = CGRect.zero
        for view in myScroll.subviews {
            contentRect = contentRect.union(view.frame)
        }
        myScroll.contentSize = contentRect.size
    }
    
    private func update(_ condition: Condition) {
        switch condition {
        case .start:
            darkView.isHidden = true
            activityIndicator.startAnimating()
        case .stop:
            myScroll.reloadInputViews()
            darkView.isHidden = false
            activityIndicator.stopAnimating()
        }
    }
    

    
}
