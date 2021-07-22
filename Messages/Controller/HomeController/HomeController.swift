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
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.searchController = searchController
        navigationItem.title = "Messages"

        setup()
        updateCollectionViewContentHeight()
    }
    
    // MARK: - Handlers
    private func setup() {
        quickReach.delegate = self
        quickReach.dataSource = self
        quickReach.dragDelegate = self
        quickReach.dropDelegate = self
        quickReach.dragInteractionEnabled = true
        customTableView.delegate = self
        customTableView.dataSource = self
        
        modifyCustomContainerView()
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "square.and.pencil"), style: .plain, target: nil, action: nil)
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: nil, action: nil)
    }
    
    func modifyCustomContainerView() {
        let controller = viewmanagers.instantiateViewController(identifier: "searchControllerView") as CustomSearchController
        controller.searchBarHeight = searchController.searchBar.frame.height + 20
        customcontroller = controller
        containerView.addSubview(controller.view)
    }
    
    func updateCollectionViewContentHeight() {
        if (pinnedMessages.count == 0) {
            quickReach.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        } else {
            let line = Int(ceil(Float(pinnedMessages.count) / Float(3)))
            let calculateHeight = line * (Int(QuickReachCellSize) + 30)
            quickReach.frame = CGRect(x: 0, y: 0, width: Int(UIScreen.main.bounds.width), height: Int(calculateHeight) + line)
        }
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
