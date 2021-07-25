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
        
        let dragItem = UIDragItem(itemProvider: itemProvider)
        dragItem.previewProvider = { [self] in previewItem(for: item)}

        return [dragItem]
    }
    
    fileprivate func previewItem(for model: MessageModel) -> UIDragPreview {
        var view: UIView {
            let vw = UIView()
            vw.frame.size = CGSize(width: 80, height: 80)
            vw.layer.cornerRadius = 40
            vw.backgroundColor = .lightGray
            
            let label = UILabel()
            label.text = model.sender.firstLetter()
            label.font = UIFont(name: "ArialRoundedMTBold", size: 35)
            label.textColor = .white
            label.translatesAutoresizingMaskIntoConstraints = false
            
            vw.addSubview(label)
            NSLayoutConstraint.activate([
                label.centerYAnchor.constraint(equalTo: vw.centerYAnchor),
                label.centerXAnchor.constraint(equalTo: vw.centerXAnchor)
            ])
            
            return vw
        }
        
        return UIDragPreview(view: view)
    }
    
}
