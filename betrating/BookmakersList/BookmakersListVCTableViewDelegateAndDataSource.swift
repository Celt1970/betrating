//
//  ExtensionGamesTableViewDelegateAndDataSource.swift
//  betrating
//
//  Created by Yuriy borisov on 22.01.2018.
//  Copyright © 2018 Yuriy borisov. All rights reserved.
//

import Foundation
import UIKit

extension BookmakersListVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        idToSend = raitings[indexPath.row].id
        performSegue(withIdentifier: "toBookmaker", sender: self)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let big = CGSize(width: collectionView.bounds.size.width - 20 , height:  collectionView.bounds.size.width  / 3 )
        let small =  CGSize(width: (collectionView.bounds.size.width - 35) / 2 , height:  collectionView.bounds.size.width  / 3 )
        
        if indexPath.row == 0 {
            return big
        } else {
            return small
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return raitings.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BookmakersListCellSmall", for: indexPath) as! BookmakersListCellSmall
            if raitings.count != 0{
                let rate = raitings[indexPath.row]
                cell.configure(raiting: rate,
                               service: service,
                               indexPath: indexPath)
            }
            return cell
    }
}



