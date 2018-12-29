//
//  NewsListCollectionViewDataSourceAndDelegate.swift
//  betrating
//
//  Created by Yuriy Borisov on 29/12/2018.
//  Copyright © 2018 Yuriy borisov. All rights reserved.
//

import UIKit

extension NewsVC {
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let id = news?[indexPath.row].id else { return }
        idToSend = id
        performSegue(withIdentifier: "toCurrentNews", sender: self)
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return numberOfSections
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return news?.count ?? 0
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: ConfigurableCell
        
        if indexPath.row == 0 || indexPath.row % 5 == 0 {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "newsCellBig", for: indexPath) as! NewsCell
        } else {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "newsCellSmall", for: indexPath) as! NewsCellSmall
        }
        
        guard let currentNews = news?[indexPath.row] else {return cell as! UICollectionViewCell}
        
        cell.configure(currentNews: currentNews, indexPath: indexPath)
        getImageWithIndexAndUrl(index: indexPath.row, url: currentNews.preview) { image in
            if cell.tag == indexPath.row {
                cell.image.image = image
            }
        }
        return cell as! UICollectionViewCell
    }
}
