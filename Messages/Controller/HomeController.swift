//
//  HomeController.swift
//  Messages
//
//  Created by ozan honamlioglu on 10.07.2021.
//

import UIKit
import Combine

class HomeController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var quickReach: UICollectionView!
    @IBOutlet weak var customTableView: UITableView!
    
    // MARK: - Properties
    let cellId = "homeCellId"
    let collectionCellId = "quickReachId"
    
    // MARK: - Views
    var searchController: UISearchController {
        let sc = UISearchController(searchResultsController: nil)
        sc.searchResultsUpdater = self
        sc.delegate = self
        sc.obscuresBackgroundDuringPresentation = false
        sc.searchBar.placeholder = "Search"
        sc.hidesNavigationBarDuringPresentation = true
        return sc
    }
    let containerView = UIView()
    let viewmanagers = UIStoryboard(name: "ViewManagers", bundle: nil)
    var customcontroller: UIViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.searchController = searchController

        setup()
        updateCollectionViewContentHeight()
    }
    
    // MARK: - Handlers
    private func setup() {
        quickReach.delegate = self
        quickReach.dataSource = self
        customTableView.delegate = self
        customTableView.dataSource = self
        
        modifyCustomContainerView()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "square.and.pencil"), style: .plain, target: nil, action: nil)
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: nil, action: nil)
    }
    
    private func modifyCustomContainerView() {
        let controller = viewmanagers.instantiateViewController(identifier: "searchControllerView") as CustomSearchController
        controller.searchBarHeight = searchController.searchBar.frame.height + 20
        customcontroller = controller
        containerView.addSubview(controller.view)
    }
    
    private func updateCollectionViewContentHeight() {
        if (pinnedMessages.count == 0) {
            quickReach.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        } else {
            let line = Int(ceil(Float(pinnedMessages.count) / Float(3)))
            let calculateHeight = line * (Int(QuickReachCellSize) + 30)
            quickReach.frame = CGRect(x: 0, y: 0, width: Int(UIScreen.main.bounds.width), height: Int(calculateHeight) + line)
        }
    }
    
    private func silentMessage() {
        print("message silented")
    }
    
    private func pinMessage() {
        print("message pinned")
    }
    
    private func deleteMessage() {
        print("message deleted")
    }
    
}

// MARK: - Tableview
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
        let pinAction = UIContextualAction(style: .normal, title: nil) { [weak self] (action, view, completionHandler) in
            self?.pinMessage()
            completionHandler(true)
        }
        pinAction.backgroundColor = .systemYellow
        pinAction.image = UIImage(systemName: "pin.fill")
        
        return UISwipeActionsConfiguration(actions: [pinAction])
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: nil) { [weak self] (action, view, completionHandler) in
            self?.deleteMessage()
            completionHandler(true)
        }
        deleteAction.backgroundColor = .systemRed
        deleteAction.image = UIImage(systemName: "trash")
        
        let silentAction = UIContextualAction(style: .normal, title: nil) { [weak self] (action, view, completionHandler) in
            self?.silentMessage()
            completionHandler(true)
        }
        silentAction.backgroundColor = .systemBlue
        silentAction.image = UIImage(systemName: "bell.slash.fill")
        
        return UISwipeActionsConfiguration(actions: [deleteAction, silentAction])
    }
    
}

// MARK: - Search Controller
extension HomeController: UISearchResultsUpdating, UISearchControllerDelegate {
    
    func containerStatus(active: Bool) {
        let duration = 0.3
        
        if (active) {
            
            guard customcontroller != nil else { return }

            containerView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(containerView)
            NSLayoutConstraint.activate([
                containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                containerView.topAnchor.constraint(equalTo: view.topAnchor),
                containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            ])
            containerView.alpha = 0
            
            customcontroller!.view.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                customcontroller!.view.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
                customcontroller!.view.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
                customcontroller!.view.topAnchor.constraint(equalTo: containerView.topAnchor),
                customcontroller!.view.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            ])
                        
            UIView.animate(withDuration: duration) {
                self.containerView.alpha = 1
            }
            
        } else {
            
            UIView.animate(withDuration: duration) {
                self.containerView.alpha = 0
            } completion: { status in
                self.containerView.removeFromSuperview()
            }
            
        }

    }
    
    func updateSearchResults(for searchController: UISearchController) {
        let _ = searchController.searchBar.text
    }
    
    func willPresentSearchController(_ searchController: UISearchController) {
        containerStatus(active: true)
    }
    
    func willDismissSearchController(_ searchController: UISearchController) {
        containerStatus(active: false)
    }
        
}

// MARK: - Collection View (Quick Reach)
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
        return CGSize(width: QuickReachCellSize, height: QuickReachCellSize + 30)
    }
    
}
