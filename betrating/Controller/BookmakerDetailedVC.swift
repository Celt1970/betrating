//
//  BookmakerDetailedVC.swift
//  betrating
//
//  Created by Yuriy borisov on 19.01.2018.
//  Copyright © 2018 Yuriy borisov. All rights reserved.
//

import UIKit

class BookmakerDetailedVC: UIViewController {
    
    @IBOutlet weak var bookmakerLogo: UIImageView!
    @IBOutlet weak var firstStar: UIImageView!
    @IBOutlet weak var secondStar: UIImageView!
    @IBOutlet weak var thirdStar: UIImageView!
    @IBOutlet weak var fourthStar: UIImageView!
    @IBOutlet weak var fifthStar: UIImageView!
    @IBOutlet weak var likesCounter: UILabel!
    @IBOutlet weak var firstText: UITextView!
    @IBOutlet weak var secondText: UITextView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    var id = 0
    var service = NetworkService()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
    
    func loadData() {
        scrollView.isHidden = true
        activityIndicator.startAnimating()
        service.getBookmakerByID(id: id) { [weak self] rate in
            guard rate != nil else {return}
            
            self?.service.loadImage(url: rate!.logo!, completion: { [weak self ] image, connect in
                if connect == true{
                    return
                }
                guard image != nil else {return}
                self?.bookmakerLogo.image = image
            })
            
            
            self?.firstText.attributedText  = rate!.attrStr1
            self?.secondText.attributedText = rate!.attrStr2
            self?.likesCounter.text = "\(rate!.votes!)"
            self?.scrollView.reloadInputViews()
            self?.scrollView.isHidden = false
            self?.activityIndicator.stopAnimating()
        }
        var contentRect = CGRect.zero
        
        for view in scrollView.subviews {
            contentRect = contentRect.union(view.frame)
        }
        scrollView.contentSize = contentRect.size
    }
}
