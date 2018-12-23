//
//  DetailedNewsVC.swift
//  betrating
//
//  Created by Yuriy borisov on 20.01.2018.
//  Copyright © 2018 Yuriy borisov. All rights reserved.
//

import UIKit

class DetailedNewsVC: UIViewController {
    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var newsLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var firstTextView: UITextView!
    @IBOutlet weak var secondTextView: UITextView!
    @IBOutlet weak var tagsLabel: UILabel!
    @IBOutlet weak var separatingView: UIView!
    @IBOutlet weak var activityIndecator: UIActivityIndicatorView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    

    var id = 0
    var service : NetworkService?
    var session: URLSession{
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration)
        return session
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        service = NetworkService()
        scrollView.isHidden = true
        activityIndecator.startAnimating()
        
        
        separatingView.isHidden = true
        
        service?.getNewsById(id: id) { [weak self] news  in
            guard news != nil else {return}
            
            self?.service?.loadImage(url: news!.preview, completion: { [ weak self ] image, connect in
                if connect == true{
                    return
                }
                guard image != nil else {return}
                self?.newsImage.image = image
            })
            
            self?.newsLabel.text = news?.name
            self?.dateLabel.text = news?.date
            self?.categoryLabel.text = news?.category?.joined(separator: " • ")
            self?.firstTextView.attributedText = news?.attrStr1
            if news?.attrStr2.string == ""{
                self?.secondTextView.isHidden = true
            }
            self?.secondTextView.attributedText = news?.attrStr2
            
            let tags = news?.tags!.map({ (str: String) -> String in
                let some  = "#" + str
                return some
            })
            
            self?.tagsLabel.text = tags?.joined(separator: "\n")
            self?.separatingView.isHidden = false
            self?.scrollView.isHidden = false
            self?.activityIndecator.stopAnimating()
        }
//        service?.getNewsByID(id: id, completion: { [weak self] news, connect in
//            if connect == true{
//                return
//            }
//            guard news != nil else {return}
//
//            self?.service?.loadImage(url: news!.preview, completion: { [ weak self ] image, connect in
//                if connect == true{
//                    return
//                }
//                guard image != nil else {return}
//                self?.newsImage.image = image
//            })
//
//            self?.newsLabel.text = news?.name
//            self?.dateLabel.text = news?.date
//            self?.categoryLabel.text = news?.category?.joined(separator: " • ")
//            self?.firstTextView.attributedText = news?.attrStr1
//            if news?.attrStr2.string == ""{
//                self?.secondTextView.isHidden = true
//            }
//            self?.secondTextView.attributedText = news?.attrStr2
//
//            let tags = news?.tags!.map({ (str: String) -> String in
//                let some  = "#" + str
//                return some
//            })
//
//            self?.tagsLabel.text = tags?.joined(separator: "\n")
//            self?.separatingView.isHidden = false
//            self?.scrollView.isHidden = false
//            self?.activityIndecator.stopAnimating()
//        })
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
