//
//  ForecastVC.swift
//  betrating
//ForecastListVC
//  Created by Yuriy borisov on 15.01.2018.
//  Copyright © 2018 Yuriy borisov. All rights reserved.
//

import UIKit

class ForecastListVC: UIViewController {
    
    @IBOutlet weak var allButton: UIButton!
    @IBOutlet weak var fotballButton: UIButton!
    @IBOutlet weak var hockeyButton: UIButton!
    @IBOutlet weak var tennisButton: UIButton!
    @IBOutlet weak var basketballButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var collectionB: UICollectionView!
    
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    let insets: CGFloat = 10
    
    var idToTransfer = 0
    
    var all: [ForecastListItem]?
    var filteredCategory: [ForecastListItem] = []
    var service = NetworkService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadData()
        self.setupUI()
    }
    
    @IBAction func sportButtonPressed(_ sender: UIButton) {
        if sender.currentTitleColor == BetratingColors.betRatingGreen {
            collectionB.setContentOffset(CGPoint(x: 0.0, y: 0.0), animated: true)
            return
        }
        let buttons = [allButton, fotballButton, hockeyButton, tennisButton, basketballButton]
        for button in buttons {
            if button == sender{
                sender.setTitleColor(BetratingColors.betRatingGreen, for: .normal)
            } else {
                button?.setTitleColor(BetratingColors.betRatingGray, for: .normal)
            }
        }
        let category = ForecastCategories(rawValue: sender.currentTitle!)!
        changeCategory(category)
    }
    
    private func changeCategory(_ category: ForecastCategories) {
        let newForecast = self.all?.filter { forecast in
            return forecast.slug == category.getCategory()
        }
        guard newForecast != nil, self.all != nil else { return }
        self.filteredCategory = newForecast!
        if category == .all {
            self.filteredCategory = self.all!
        }
        update(view: self.collectionB, activityIndicator: activityIndicator, condition: .stop)
        self.collectionB.setContentOffset(CGPoint(x: 0.0, y: 0.0), animated: true)
    }
    

    
    private func loadData() {
        self.update(view: collectionB, activityIndicator: activityIndicator, condition: .start)
        service.getForecastList(category: .all,
                                offset: 0,
                                limit: 100)
        { [weak self] list in
            guard let list = list else {
                self?.update(view: self?.collectionB, activityIndicator: self?.activityIndicator, condition: .stop)
                return
            }
            self?.all = list
            self?.filteredCategory = list
            self?.update(view: self?.collectionB, activityIndicator: self?.activityIndicator, condition: .stop)
        }
    }
    
    private func setupUI() {
        collectionB.delegate = self
        collectionB.dataSource = self
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: insets,
                                           left: insets,
                                           bottom: insets,
                                           right: insets)
        layout.itemSize = CGSize(width: screenWidth  - 20,
                                 height: collectionB.bounds.width  / 3)
        layout.minimumInteritemSpacing = insets
        layout.minimumLineSpacing = insets
        collectionB.collectionViewLayout = layout
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toForecastDetails"{
            if segue.destination is ForecastByIdVC{
                let destinationVC = segue.destination as! ForecastByIdVC
                destinationVC.id = self.idToTransfer
            }
        }
    }
}

