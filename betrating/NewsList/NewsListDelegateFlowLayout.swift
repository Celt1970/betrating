//
//  NewsListDelegateFlowLayout.swift
//  betrating
//
//  Created by Yuriy Borisov on 29/12/2018.
//  Copyright © 2018 Yuriy borisov. All rights reserved.
//

import UIKit

extension NewsVC {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let big = CGSize(width: collectionView.bounds.size.width - 20 , height:  collectionView.bounds.size.width  / 1.77 )
        let small =  CGSize(width: collectionView.bounds.size.width - 20, height:  screenWidth  / 3.26 )
        if indexPath.row == 0 || indexPath.row % 5 == 0 {
            return big
        }else{
            return small
        }
    }
    
    func setupLayout() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: insets, left: insets, bottom: insets, right: insets)
        layout.minimumInteritemSpacing = insets
        layout.minimumLineSpacing = insets
        collectionView?.collectionViewLayout = layout
    }
}
