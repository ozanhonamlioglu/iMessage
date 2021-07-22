//
//  TableView+Data.swift
//  Messages
//
//  Created by ozan honamlioglu on 21.07.2021.
//

import UIKit

extension HomeController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listMessages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! HomeTableViewCell
        cell.setUpData(sender: listMessages[indexPath.row].sender, message: listMessages[indexPath.row].demoMessage)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let data = listMessages[indexPath.row]
        
        let pinAction = UIContextualAction(style: .normal, title: nil) { [weak self] (action, view, completionHandler) in
            self?.pin(at: indexPath, thisMessage: data)
            completionHandler(true)
        }
        pinAction.backgroundColor = .systemYellow
        pinAction.image = UIImage(systemName: "pin.fill")
        
        return UISwipeActionsConfiguration(actions: [pinAction])
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: nil) { [weak self] (action, view, completionHandler) in
            self?.delete()
            completionHandler(true)
        }
        deleteAction.backgroundColor = .systemRed
        deleteAction.image = UIImage(systemName: "trash")
        
        let silentAction = UIContextualAction(style: .normal, title: nil) { [weak self] (action, view, completionHandler) in
            self?.silent()
            completionHandler(true)
        }
        silentAction.backgroundColor = .systemBlue
        silentAction.image = UIImage(systemName: "bell.slash.fill")
        
        return UISwipeActionsConfiguration(actions: [deleteAction, silentAction])
    }
    
    func getIndexPathFromTableViewVia(gesture recognizer: UILongPressGestureRecognizer) -> IndexPath? {
        customTableView.indexPathForRow(at: recognizer.location(in: customTableView))
    }
    
    // SWIPE METHODS
    func silent() {
        print("message silented")
    }
    
    func pin(at indexPath: IndexPath, thisMessage data: MessageModel) {
        pinnedMessages.append(data)

        listMessages.remove(at: indexPath.row)
        
        updateCollectionViewContentHeight()
        customTableView.reloadData()
        
        self.quickReach.reloadData()
    }
    
    func delete() {
        print("message deleted")
    }
    
}

