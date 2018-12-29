//
//  RaitingVC.swift
//  betrating
// BookmakersListVC
//  Created by Yuriy borisov on 13.01.2018.
//  Copyright © 2018 Yuriy borisov. All rights reserved.
//

import UIKit

class BookmakersListVC: UIViewController {
    
    var activatedTriggers: [[Int]] = [[0],[0,0,0,0,0],[0],[0],[0,0,0],[0],[0],[0],[0],[0],[0],[0]]
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var collectionView: UICollectionView!
    var idToSend = 0
    
    
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    
    var service = NetworkService()
    var raitings = [BookmakersListItem2]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.isHidden = true
        activityIndicator.startAnimating()
        service.getBookmakersList(filters: activatedTriggers){ [weak self] ratings in
            
            guard let ratings = ratings else { return }
            self?.raitings = ratings
            self?.collectionView.reloadData()
            self?.collectionView.isHidden = false
            self?.activityIndicator.stopAnimating()
        }
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.minimumInteritemSpacing = 15
        layout.minimumLineSpacing = 15
        collectionView.collectionViewLayout = layout
        self.view.addSubview(collectionView)
    }
    @IBAction func filtersBtnPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "toFilters", sender: self)
    }
    @IBAction func unwindFromFilterVC(_ sender: UIStoryboardSegue){
        
    }
    
    @IBAction func unwindWithData(_ sender: UIStoryboardSegue){
        if sender.source is FiltersVC{
            if let senderVC = sender.source as? FiltersVC{
                activityIndicator.startAnimating()
                activatedTriggers = senderVC.activatedTriggers
                collectionView.setContentOffset(CGPoint(x: 0.0, y: 0.0), animated: true)
                service.getBookmakersList(filters: activatedTriggers){ [weak self] ratings in
                    
                    guard let ratings = ratings else { return }
                    self?.raitings = ratings
                    self?.activityIndicator.stopAnimating()
                    self?.collectionView.reloadData()
                }
            }
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toFilters"{
            if segue.destination is FiltersVC{
                if let destinationVC = segue.destination as? FiltersVC{
                    destinationVC.activatedTriggers = activatedTriggers
                }
            }
        }
        if segue.identifier == "toBookmaker"{
            if segue.destination is BookmakerDetailedVC{
                if let destinationVC = segue.destination as? BookmakerDetailedVC{
                    destinationVC.id = idToSend
                }
            }
        }
    }
    
}

