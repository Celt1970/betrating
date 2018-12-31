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
        service.getBookmakersList { [weak self] ratings in
            
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
    
    @IBAction func unwindFromFilterVC(_ sender: UIStoryboardSegue){
        
    }
 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toBookmaker"{
            if segue.destination is BookmakerByIdVC{
                if let destinationVC = segue.destination as? BookmakerByIdVC{
                    destinationVC.id = idToSend
                }
            }
        }
    }
    
}

