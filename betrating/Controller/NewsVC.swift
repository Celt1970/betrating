//
//  NewsVC.swift
//  betrating
//
//  Created by Yuriy borisov on 14.01.2018.
//  Copyright © 2018 Yuriy borisov. All rights reserved.
//

import UIKit


class NewsVC: UICollectionViewController, UICollectionViewDelegateFlowLayout{
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var news: [NewsListItem]?
    var session: URLSession{
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration)
        return session
    }
    var service: NetworkService?
    var idToSend = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        service = NetworkService(session: session)
        activityIndicator.startAnimating()
        service?.getNewsList(completion: {[ weak self ] news, connect in
            if connect == true{
                return
            }
            guard news != nil else {return}
            self?.news = news
            self?.collectionView?.reloadData()
            self?.activityIndicator.stopAnimating()
        })
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        
        collectionView?.collectionViewLayout = layout
        
        
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toCurrentNews" && segue.destination is DetailedNewsVC{
            if let destinationVC = segue.destination as? DetailedNewsVC{
                destinationVC.id = idToSend
            }
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        idToSend = news?[indexPath.row].id ?? 0
        performSegue(withIdentifier: "toCurrentNews", sender: self)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let big = CGSize(width: collectionView.bounds.size.width - 20 , height:  collectionView.bounds.size.width  / 1.77 )
        let small =  CGSize(width: collectionView.bounds.size.width - 20, height:  screenWidth  / 3.26 )
        
        if indexPath.row == 0{
            return big
        }else{
            return small
        }
    }
    
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return news?.count ?? 0
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row != 0{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "newsCellSmall", for: indexPath) as! NewsCellSmall
            
            let currentNews = news?[indexPath.row]
            guard currentNews != nil else {return cell}
            cell.configure(currentNews: currentNews, service: service, indexPath: indexPath, collectionView: collectionView)
            
            return cell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "newsCellBig", for: indexPath) as! NewsCell
        let currentNews = news?[indexPath.row]
        guard currentNews != nil else {return cell}
        cell.configure(currentNews: currentNews, service: service, indexPath: indexPath, collectionView: collectionView)
        return cell
    }
    
    
    
}
