//
//  HomeController.swift
//  Messages
//
//  Created by ozan honamlioglu on 10.07.2021.
//

import UIKit
import Combine

class HomeController: UITableViewController {
    private enum Mode {
        case active, deactive
    }
    
    // MARK: - Outlets
    @IBOutlet weak var quickReach: UICollectionView!
    
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
    let customcontroller = CustomSearchController()
    
    // MARK: - State
    var bag = Set<AnyCancellable>()
    @Published private var searchControllerState: Mode = .deactive
    
    override func viewDidLoad() {
        super.viewDidLoad()
        observe()
        setup()
        updateCollectionViewContentHeight()        
    }
    
    // MARK: - Custom Handlers
    private func setup() {
        quickReach.delegate = self
        quickReach.dataSource = self
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "square.and.pencil"), style: .plain, target: nil, action: nil)
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: nil, action: nil)
    }
    
    private func observe() {
        $searchControllerState.sink { mode in
            print(mode)
        }.store(in: &bag)
    }
    
    private func updateCollectionViewContentHeight() {
        if (pinnedMessages.count == 0) {
            quickReach.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        } else {
            let calculateHeight = ceil(Float(pinnedMessages.count) / Float(3)) * 120
            quickReach.frame = CGRect(x: 0, y: 0, width: Int(UIScreen.main.bounds.width), height: Int(calculateHeight) + 30)
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
    
    // MARK: - Handlers
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fakeMessages.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! HomeTableViewCell
        cell.setUpData(sender: fakeMessages[indexPath.row].sender, message: fakeMessages[indexPath.row].demoMessage)
        
        return cell
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if navigationItem.searchController == nil {
            navigationItem.searchController = searchController
        }
    }
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let pinAction = UIContextualAction(style: .normal, title: nil) { [weak self] (action, view, completionHandler) in
            self?.pinMessage()
            completionHandler(true)
        }
        pinAction.backgroundColor = .systemYellow
        pinAction.image = UIImage(systemName: "pin.fill")
        
        return UISwipeActionsConfiguration(actions: [pinAction])
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
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
    
    func updateSearchResults(for searchController: UISearchController) {
        let _ = searchController.searchBar.text
    }
    
    func willPresentSearchController(_ searchController: UISearchController) {
        searchControllerState = .active
    }
    
    func willDismissSearchController(_ searchController: UISearchController) {
        searchControllerState = .deactive
    }
        
}

// MARK: - Collection View (Quick Reach)
extension HomeController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pinnedMessages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionCellId, for: indexPath) as! QuickReachCollectionViewCell
        cell.setupUI()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.width
        return CGSize(width: width/3, height: (width/3) + 10)
    }
    
}
