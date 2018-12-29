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
        scrollView.isHidden = true
        activityIndecator.startAnimating()
        separatingView.isHidden = true
        imageActivityIndicator.startAnimating()
        service.getNewsById(id: id) { [weak self] news  in
            guard let news = news else {return}
            
            self?.service.loadImage(url: news.preview, completion: { [ weak self ] image in
                self?.newsImage.image = image
                self?.imageActivityIndicator.stopAnimating()
            })
            
            self?.newsLabel.text = news.name
            self?.dateLabel.text = news.date
            self?.categoryLabel.text = news.category.joined(separator: " • ")
            self?.firstTextView.attributedText = news.attrStr1
            if news.attrStr2.string == ""{
                self?.secondTextView.isHidden = true
            }
            self?.secondTextView.attributedText = news.attrStr2
            self?.tagsLabel.text = news.getTags()
            self?.separatingView.isHidden = false
            self?.scrollView.isHidden = false
            self?.activityIndecator.stopAnimating()
        }
    }
}
