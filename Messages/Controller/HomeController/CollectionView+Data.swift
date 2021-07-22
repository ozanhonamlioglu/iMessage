//
//  CollectionView+Data.swift
//  Messages
//
//  Created by ozan honamlioglu on 21.07.2021.
//

import UIKit

extension HomeController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pinnedMessages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionCellId, for: indexPath) as! QuickReachCollectionViewCell
        cell.setupUI(name: pinnedMessages[indexPath.row].sender)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: QuickReachCellSize, height: QuickReachCellSize + 30)
    }
    
}
