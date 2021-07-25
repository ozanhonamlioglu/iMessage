//
//  HomeController+CV+Drop.swift
//  Messages
//
//  Created by ozan honamlioglu on 21.07.2021.
//

import UIKit

extension HomeController: UICollectionViewDropDelegate {
    
    func collectionView(_ collectionView: UICollectionView, canHandle session: UIDropSession) -> Bool {
        return session.canLoadObjects(ofClass: NSString.self)
    }
    
    func collectionView(_ collectionView: UICollectionView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UICollectionViewDropProposal {
        var dropProposal = UICollectionViewDropProposal(operation: .cancel)
        
        // only one item can be dropped at a time
        guard session.items.count == 1 else { return dropProposal }
        
        if quickReach.hasActiveDrag {
            dropProposal = UICollectionViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
        } else {
            dropProposal = UICollectionViewDropProposal(operation: .copy, intent: .insertAtDestinationIndexPath)
        }
        
        return dropProposal
    }
    
    func collectionView(_ collectionView: UICollectionView, performDropWith coordinator: UICollectionViewDropCoordinator) {
        let destinationIndexPath: IndexPath

        if let indexPath = coordinator.destinationIndexPath {
            destinationIndexPath = indexPath
        } else {
            let section = quickReach.numberOfSections - 1
            let item = quickReach.numberOfItems(inSection: section)
            let indexPath = IndexPath(item: item, section: section)
            destinationIndexPath = indexPath
        }
        
        coordinator.session.loadObjects(ofClass: NSString.self) {[weak self] items in
            guard let stringItems = items as? [String] else { return }
            
            if (coordinator.proposal.operation == .copy) {
                
                var indexPaths = [IndexPath]()
                for (index, item) in stringItems.enumerated() {
                    let indexPath = IndexPath(row: destinationIndexPath.row + index, section: destinationIndexPath.section)
                    self?.addItem(item, at: indexPath.row)
                    indexPaths.append(indexPath)
                }
                
                self?.quickReach.insertItems(at: indexPaths)
                self?.updateCollectionViewContentHeight()
                
                self?.removeItemFromTableViewWith(id: stringItems.first!)
                
            } else if (coordinator.proposal.operation == .move) {
                self?.reorderItems(collectionView, coordinator: coordinator, destinationIndexPath: destinationIndexPath)
                self?.updateCollectionViewContentHeight()
                self?.customTableView.reloadData()
                
            }
            
        }
            

    }
    
    fileprivate func reorderItems(_ collectionView: UICollectionView, coordinator: UICollectionViewDropCoordinator, destinationIndexPath: IndexPath) {
        
        if let senderId = coordinator.items.first,
           let sourceIndexPath = senderId.sourceIndexPath {
            
            if(destinationIndexPath.row <= pinnedMessages.count) {
             
                let item = pinnedMessages[sourceIndexPath.item]

                quickReach.performBatchUpdates {
                    pinnedMessages.remove(at: sourceIndexPath.item)
                    pinnedMessages.insert(item, at: destinationIndexPath.item)

                    quickReach.deleteItems(at: [sourceIndexPath])
                    quickReach.insertItems(at: [destinationIndexPath])
                }
                coordinator.drop(senderId.dragItem, toItemAt: destinationIndexPath)
                
            }
            
        }
        
    }
    
    private func findMessageModel(with senderId: String) -> MessageModel {
        var message: MessageModel!
        
        for item in listDB {
            if(item.senderId == Int(senderId)) {
                message = item
                break
            }
        }

        return message
    }
    
    private func addItem(_ senderId: String, at index: Int) {
        let message = findMessageModel(with: senderId)
        pinnedMessages.insert(message, at: index)
    }
    
    private func removeItemFromTableViewWith(id: String) {
        let id = Int(id)
        var row: Int = 0
        
        for (k, i) in listMessages.enumerated() {
            if (i.senderId == id) {
                row = k
                break
            }
        }
        
        listMessages.remove(at: row)
        
        self.customTableView.reloadData()
    }
    
}
