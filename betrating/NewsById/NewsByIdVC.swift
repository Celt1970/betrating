//
//  NewsByIdVC.swift
//  betrating
//
//  Created by Yuriy borisov on 20.01.2018.
//  Copyright © 2018 Yuriy borisov. All rights reserved.
//

import UIKit

class NewsByIdVC: UIViewController {
    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var newsLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var firstTextView: UITextView!
    @IBOutlet weak var secondTextView: UITextView!
    @IBOutlet weak var tagsLabel: UILabel!
    @IBOutlet weak var separatingView: UIView!
    @IBOutlet weak var activityIndecator: UIActivityIndicatorView!
    @IBOutlet weak var imageActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var id = 0
    var service = NetworkService()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        update(view: self.scrollView, activityIndicator: self.activityIndecator, condition: .start)
        update(view: separatingView, activityIndicator: imageActivityIndicator, condition: .start)

        service.getNewsById(id: id) { [weak self] news  in
            guard let news = news else {return}
            
            self?.service.loadImage(url: news.preview, completion: { [ weak self ] image in
                self?.newsImage.image = image
                self?.update(view: self?.separatingView, activityIndicator: self?.activityIndecator, condition: .stop)
            })
            
            self?.newsLabel.text = news.fullName
            self?.dateLabel.text = news.date
            self?.categoryLabel.text = news.category.joined(separator: " • ")
            self?.firstTextView.attributedText = news.attrStr1
            if news.attrStr2.string == ""{
                self?.secondTextView.isHidden = true
            }
            self?.secondTextView.attributedText = news.attrStr2
            self?.tagsLabel.text = news.getTags()

            self?.update(view: self?.scrollView, activityIndicator: self?.activityIndecator, condition: .stop)
        }
    }
}
