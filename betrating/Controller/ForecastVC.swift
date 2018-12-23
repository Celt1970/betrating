//
//  ForecastVC.swift
//  betrating
//
//  Created by Yuriy borisov on 15.01.2018.
//  Copyright © 2018 Yuriy borisov. All rights reserved.
//

import UIKit

class ForecastVC: UIViewController {
    @IBOutlet weak var allButton: UIButton!
    @IBOutlet weak var fotballButton: UIButton!
    @IBOutlet weak var hockeyButton: UIButton!
    @IBOutlet weak var tennisButton: UIButton!
    @IBOutlet weak var basketballButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var collectionB: UICollectionView!
    
    
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    
    var offset = 50
    var idToTransfer = 0
    
    let betRatingGreen = UIColor(red: 0, green: 169/255, blue: 103/255, alpha: 1)
    let betRatingGray = UIColor(red: 99/255, green: 99/255, blue: 99/255, alpha: 1)
    
    var all: [ForecastSmall]?
    var soccer: [ForecastSmall]?
    var hockey: [ForecastSmall]?
    var tennis: [ForecastSmall]?
    var basketball: [ForecastSmall]?
    
    var category1: forecastCategories = .all
    var loadMoreStatus = false
    
    
    var session: URLSession{
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration)
        return session
    }
    var service = NetworkService()
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentOffset = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
        let deltaOffset = maximumOffset - currentOffset
        
        if deltaOffset <= 0 {
//            loadMore()
        }
    }
    func loadMore(){
        if loadMoreStatus == false{
            self.loadMoreStatus = true
            
            service.getForecastList(category: category1, offset: offset, limit: 100) { [weak self] list in
                guard list != nil else {return}
                if list!.isEmpty{
                    self?.loadMoreStatus = false
                    return
                }
                if self?.all != nil{
                    
                    switch self!.category1 {
                    case .all:
                        if self?.all != nil{
                            self?.all! +=  list!
                        }
                    case .soccer:
                        if self?.soccer != nil{
                            self?.soccer! +=  list!
                        }
                    case .hockey:
                        if self?.hockey != nil{
                            self?.hockey! +=  list!
                        }
                    case .tennis:
                        if self?.tennis != nil{
                            self?.tennis! +=  list!
                        }
                    case .basketball:
                        if self?.basketball != nil{
                            self?.basketball! +=  list!
                        }
                        
                    }
                    
                    self?.collectionB.reloadData()
                    self?.loadMoreStatus = false
                    self?.offset += 50
                }
            }
        }
    }
    
    @IBAction func sportButtonPressed(_ sender: UIButton) {
        if sender.currentTitleColor == betRatingGreen{
            collectionB.setContentOffset(CGPoint(x: 0.0, y: 0.0), animated: true)
            return
        }
        let buttons = [allButton, fotballButton, hockeyButton, tennisButton, basketballButton]
        for button in buttons{
            if button == sender{
                sender.setTitleColor(betRatingGreen, for: .normal)
            }else{
                button?.setTitleColor(betRatingGray, for: .normal)
            }
        }
        category1 = forecastCategories(rawValue: sender.currentTitle!)!
        let cat = category1
        offset = 50
        switch category1{
        case .all:
            if self.all != nil && self.all?.isEmpty != true{
                collectionB.setContentOffset(CGPoint(x: 0.0, y: 0.0), animated: true)
                collectionB.reloadData()
            }else{
                reload(category: cat)
            }
        case .soccer:
            if self.soccer != nil && self.soccer?.isEmpty != true{
                collectionB.setContentOffset(CGPoint(x: 0.0, y: 0.0), animated: true)
                collectionB.reloadData()
                
            }else{
                reload(category: cat)
            }
        case .hockey:
            if self.hockey != nil && self.hockey?.isEmpty != true{
                collectionB.setContentOffset(CGPoint(x: 0.0, y: 0.0), animated: true)
                collectionB.reloadData()
                
            }else{
                reload(category: cat)
            }
        case .tennis:
            if self.tennis != nil && self.tennis?.isEmpty != true{
                collectionB.setContentOffset(CGPoint(x: 0.0, y: 0.0), animated: true)
                collectionB.reloadData()
                
            }else{
                reload(category: cat)
            }
        case .basketball:
            if self.basketball != nil && self.basketball?.isEmpty != true{
                collectionB.setContentOffset(CGPoint(x: 0.0, y: 0.0), animated: true)
                collectionB.reloadData()
                
            }else{
                reload(category: cat)
            }
        }
    }
    
    func reload(category: forecastCategories){
        collectionB.isHidden = true
        activityIndicator.startAnimating()
        
        service.getForecastList(category: category, offset: 0, limit: 50) { [weak self] list in
            
            guard list != nil else {return}
            switch category {
            case .all:
                self?.all = list!
            case .soccer:
                self?.soccer = list!
            case .hockey:
                self?.hockey = list!
            case .tennis:
                self?.tennis = list!
            case .basketball:
                self?.basketball = list!
            }
            self?.collectionB.isHidden = false
            self?.collectionB.reloadData()
            self?.collectionB.setContentOffset(CGPoint(x: 0.0, y: 0.0), animated: true)
            self?.activityIndicator.stopAnimating()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionB.isHidden = true
        activityIndicator.startAnimating()
        service = NetworkService()
        service.getForecastList(category: .all, offset: 0, limit: 100) { [weak self] list in
            
            guard list != nil else {return}
            
            switch self!.category1 {
            case .all:
                self?.all = list!
            case .soccer:
                self?.soccer = list!
            case .hockey:
                self?.hockey = list!
            case .tennis:
                self?.tennis = list!
            case .basketball:
                self?.basketball = list!
            }
            
            self?.collectionB.isHidden = false
            
            self?.collectionB.reloadData()
            self?.activityIndicator.stopAnimating()
        }

        collectionB.delegate = self
        collectionB.dataSource = self
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: screenWidth  - 20,
                                 height: collectionB.bounds.width  / 3)
        layout.minimumInteritemSpacing = 15
        layout.minimumLineSpacing = 15
        
        collectionB.collectionViewLayout = layout
    }
    
    
    
}

extension ForecastVC: UICollectionViewDelegate, UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch category1 {
        case .all:
            return all?.count ?? 0
        case .soccer:
            return soccer?.count ?? 0
        case .hockey:
            return hockey?.count ?? 0
        case .tennis:
            return tennis?.count ?? 0
        case .basketball:
            return basketball?.count ?? 0
        
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "forecastCell", for: indexPath) as! ForecastCell
        
        let currentForecast: ForecastSmall?
        
        switch category1 {
        case .all:
            currentForecast = all?[indexPath.row]
        case .soccer:
            currentForecast = soccer?[indexPath.row]
        case .hockey:
            currentForecast = hockey?[indexPath.row]
        case .tennis:
            currentForecast = tennis?[indexPath.row]
        case .basketball:
            currentForecast = basketball?[indexPath.row]
        }
        cell.configCell(currentForecast: currentForecast, service: service, indexPath: indexPath)
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toForecastDetails"{
            if segue.destination is DetailedVC{
                let destinationVC = segue.destination as! DetailedVC
                destinationVC.id = self.idToTransfer
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch category1{
        case .all:
            guard let currentForecast = all?[indexPath.row] else {return}
            let id = currentForecast.id
            self.idToTransfer = id
        case .basketball:
            guard let currentForecast = basketball?[indexPath.row] else {return}
            let id = currentForecast.id
            self.idToTransfer = id
        case .soccer:
            guard let currentForecast = soccer?[indexPath.row] else {return}
            let id = currentForecast.id
            self.idToTransfer = id
        case .tennis:
            guard let currentForecast = tennis?[indexPath.row] else {return}
            let id = currentForecast.id
            self.idToTransfer = id
        case .hockey:
            guard let currentForecast = hockey?[indexPath.row] else {return}
            let id = currentForecast.id
            self.idToTransfer = id
        }
        
        
        performSegue(withIdentifier: "toForecastDetails", sender: self)
    }
}
