//
//  SearchController.swift
//  Messages
//
//  Created by ozan honamlioglu on 13.07.2021.
//

import UIKit

class CustomSearchController: UITableViewController {
    
    // MARK: - Dynamic Properties
    var searchBarHeight: CGFloat!
    
    // MARK: - Properties
    let foundUserCellId = "foundUsersCellId"
    let foundImagesCellId = "foundImagesCellId"
    let foundTextMessageCellId = "foundTextMessageCellId"
    
    // MARK: - Outlets
    @IBOutlet weak var Vspacer: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Vspacer.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: searchBarHeight - 20)
        tableView.keyboardDismissMode = .onDrag
        setup()
    }
    
    // MARK: - Handlers
    private func setup() {
        // register nibs
        tableView.register(UINib(nibName: "FoundUsersTableViewCell", bundle: nil), forCellReuseIdentifier: foundUserCellId)
        tableView.register(UINib(nibName: "FoundImagesTableViewCell", bundle: nil), forCellReuseIdentifier: foundImagesCellId)
        tableView.register(UINib(nibName: "TextMessageTableViewCell", bundle: nil), forCellReuseIdentifier: foundTextMessageCellId)
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return customSearchData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = customSearchData[indexPath.row]
        
        switch row.type {
        case .image:
            let cell = tableView.dequeueReusableCell(withIdentifier: foundImagesCellId, for: indexPath) as! FoundImagesTableViewCell
            cell.data = row.data
            return cell
            
        case .text:
            let cell = tableView.dequeueReusableCell(withIdentifier: foundTextMessageCellId, for: indexPath) as! TextMessageTableViewCell
            cell.setup(name: row.singleData!.sender!, content: row.singleData!.text!)
            return cell
            
        case .user:
            let cell = tableView.dequeueReusableCell(withIdentifier: foundUserCellId, for: indexPath) as! FoundUsersTableViewCell
            cell.data = row.data
            return cell
        }

    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let row = customSearchData[indexPath.row]
        
        switch row.type {
        case .image:
            let cellCount = row.data?.count ?? 0
            let line = Int(ceil(Float(cellCount) / Float(2)))
            return FoundImageCellSize * CGFloat(line)
            
        case .text:
            return 80
            
        case .user:
            return (UIScreen.main.bounds.width / 4) + 20
        }

    }
    
}
