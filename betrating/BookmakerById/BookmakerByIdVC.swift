//
//  BookmakerByIdVC.swift
//  betrating
//
//  Created by Yuriy borisov on 19.01.2018.
//  Copyright © 2018 Yuriy borisov. All rights reserved.
//

import UIKit

class BookmakerByIdVC: UIViewController {
    
    @IBOutlet weak var stackViewForStars: UIStackView!
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
    
    private func loadData() {
        update(condition: .start)
        service.getBookmakerByID(id: id) { [weak self] rate in
            guard let rate = rate else { return }
            
            self?.service.loadImage(url: rate.logo) { [weak self ] image in
                self?.bookmakerLogo.image = image
            }
            
            self?.populateUI(bookmaker: rate)
            self?.setupScrollView()
            self?.update(condition: .stop)
        }
    }
    
    private func populateUI(bookmaker rate: BookmakerById ) {
        self.firstText.attributedText  = rate.attrStr1
        self.secondText.attributedText = rate.attrStr2
        self.likesCounter.text = "\(rate.votes)"
        
        guard let stars = stackViewForStars.arrangedSubviews as? [UIImageView] else { return }
        
        for (index, star) in stars.enumerated() {
            if index >= rate.rating {
                star.removeFromSuperview()
            }
        }
        
    }
    
    private func update(condition: Condition) {
        switch condition {
        case .start:
            scrollView.isHidden = true
            activityIndicator.startAnimating()
        case .stop:
            self.scrollView.reloadInputViews()
            self.scrollView.isHidden = false
            self.activityIndicator.stopAnimating()
        }
    }
    
    private func setupScrollView() {
        var contentRect = CGRect.zero
        for view in scrollView.subviews {
            contentRect = contentRect.union(view.frame)
        }
        scrollView.contentSize = contentRect.size
    }
}
