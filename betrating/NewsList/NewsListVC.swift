//
//  NewsVC.swift
//  betrating
//
//  Created by Yuriy borisov on 14.01.2018.
//  Copyright © 2018 Yuriy borisov. All rights reserved.
//

import UIKit


class NewsVC: UICollectionViewController, UICollectionViewDelegateFlowLayout{
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    var news: [NewsListItem]?
    var service = NetworkService()
    var idToSend = 0
    let numberOfSections = 1
    var cachedImages: [Int: UIImage] = [:]
    let insets: CGFloat = 10

    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
    
    private func loadData() {
        update(view: self.collectionView, activityIndicator: activityIndicator, condition: .start)
        service.getNewsList(completion: {[ weak self ] news in
            guard let news = news else {return}
            self?.news = news
            self?.collectionView?.reloadData()
            self?.loadAllImages()
            self?.update(view: self?.collectionView, activityIndicator: self?.activityIndicator, condition: .stop)
        })
        setupLayout()
    }
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toCurrentNews" && segue.destination is NewsByIdVC{
            if let destinationVC = segue.destination as? NewsByIdVC{
                destinationVC.id = idToSend
            }
        }
    }
    
     func getImageWithIndexAndUrl(index: Int,url: URL, completion: @escaping (UIImage) -> Void) {
        if cachedImages[index] == nil {
            service.loadImage(url: url) { [weak self] image in
                self?.cachedImages[index] = image
                completion(image)
            }
        } else {
            completion(cachedImages[index]!)
        }
    }
    
    private func loadAllImages() {
        guard let news = news else {return}
        for (index, item) in news.enumerated() {
            if cachedImages[index] == nil {
                service.loadImage(url: item.preview) { [weak self] image in
                    if self?.cachedImages[index] == nil {
                        self?.cachedImages[index] = image
                        self?.collectionView?.reloadItems(at: [IndexPath(row: index, section: 0)])
                    }
                }
            }
        }
    }
}
