//
//  CollectionView+Drag.swift
//  Messages
//
//  Created by ozan honamlioglu on 21.07.2021.
//

import UIKit
import MobileCoreServices

extension HomeController: UICollectionViewDragDelegate {
    
    func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        let item = pinnedMessages[indexPath.row]

        let data = String(item.senderId).data(using: .utf8)
        let itemProvider = NSItemProvider()

        itemProvider.registerDataRepresentation(forTypeIdentifier: kUTTypePlainText as String, visibility: .all) { completion in
            completion(data, nil)
            return nil
        }

        return [
            UIDragItem(itemProvider: itemProvider)
        ]
    }
    
}
