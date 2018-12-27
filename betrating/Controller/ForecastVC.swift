//
//  ForecastVC.swift
//  betrating
//
//  Created by Yuriy borisov on 15.01.2018.
//  Copyright © 2018 Yuriy borisov. All rights reserved.
//

import UIKit

class ForecastVC: UIViewController {
    
    enum Condition {
        case start, stop
    }
    
    @IBOutlet weak var allButton: UIButton!
    @IBOutlet weak var fotballButton: UIButton!
    @IBOutlet weak var hockeyButton: UIButton!
    @IBOutlet weak var tennisButton: UIButton!
    @IBOutlet weak var basketballButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var collectionB: UICollectionView!
    
    
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    
    var idToTransfer = 0
    
    let betRatingGreen = UIColor(red: 0, green: 169/255, blue: 103/255, alpha: 1)
    let betRatingGray = UIColor(red: 99/255, green: 99/255, blue: 99/255, alpha: 1)
    
    var all: [ForecastSmall]?
    var filteredCategory: [ForecastSmall] = []
    var service = NetworkService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadData()
        self.setupUI()
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
        let cat = forecastCategories(rawValue: sender.currentTitle!)!
        reload(category: cat)
    }
    
    private func reload(category: forecastCategories){
        self.update(.start)
        let newForecast = self.all?.filter { forecast in
            return forecast.slug == category.getCategory()
        }
        guard newForecast != nil, self.all != nil else { return }
        self.filteredCategory = newForecast!
        if category == .all {
            self.filteredCategory = self.all!
        }
        self.update(.stop)
    }
    
    private func update(_ condition:Condition ) {
        switch condition {
        case .start:
            collectionB.isHidden = true
            activityIndicator.startAnimating()
        case .stop:
            self.collectionB.isHidden = false
            self.collectionB.reloadData()
            self.collectionB.setContentOffset(CGPoint(x: 0.0, y: 0.0), animated: true)
            self.activityIndicator.stopAnimating()
        }
    }
    
    private func loadData() {
        self.update(.start)
        service.getForecastList(category: .all,
                                offset: 0,
                                limit: 100) { [weak self] list in
            guard let list = list else {return}
            self?.all = list
            self?.filteredCategory = list
            self?.update(.stop)
        }
    }
    
    private func setupUI() {
        collectionB.delegate = self
        collectionB.dataSource = self
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10,
                                           left: 10,
                                           bottom: 10,
                                           right: 10)
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
        return self.filteredCategory.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "forecastCell", for: indexPath) as! ForecastCell
        let currentForecast: ForecastSmall = filteredCategory[indexPath.row]
        cell.configCell(currentForecast: currentForecast,
                        service: service,
                        indexPath: indexPath)
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
        let currentForecast = filteredCategory[indexPath.row]
        let id = currentForecast.id
        self.idToTransfer = id
        performSegue(withIdentifier: "toForecastDetails", sender: self)
    }
}
