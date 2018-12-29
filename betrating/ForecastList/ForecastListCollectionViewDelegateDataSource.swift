//
//  ForecastListCollectionViewDelegateDataSource.swift
//  betrating
//
//  Created by Yuriy Borisov on 29/12/2018.
//  Copyright © 2018 Yuriy borisov. All rights reserved.
//

import UIKit

extension ForecastListVC: UICollectionViewDelegate, UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.filteredCategory.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "forecastCell", for: indexPath) as! ForecastCell
        let forecast: ForecastListItem = filteredCategory[indexPath.row]
        cell.configure(currentNews: forecast, indexPath: indexPath)
        service.loadImage(url: forecast.preview) { image in
            if cell.tag == indexPath.row {
                cell.image.image = image
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let currentForecast = filteredCategory[indexPath.row]
        let id = currentForecast.id
        self.idToTransfer = id
        performSegue(withIdentifier: "toForecastDetails", sender: self)
    }
}
