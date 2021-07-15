//
//  SearchController.swift
//  Messages
//
//  Created by ozan honamlioglu on 13.07.2021.
//

import UIKit

class CustomSearchController: UITableViewController {
    
    // MARK: - Properties
    let foundUserCellId = "foundUsersCellId"
    let foundImagesCellId = "foundImagesCellId"
    let foundTextMessageCellId = "foundTextMessageCellId"
    
    // MARK: - Outlets
    @IBOutlet weak var Vspacer: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
        return customSearchData.count // extra 1 is for duplicate
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = customSearchData[indexPath.row]
        
        switch row.type {
        case .image:
            let cell = tableView.dequeueReusableCell(withIdentifier: foundImagesCellId, for: indexPath) as! FoundImagesTableViewCell
            return cell
            
        case .text:
            let cell = tableView.dequeueReusableCell(withIdentifier: foundTextMessageCellId, for: indexPath) as! TextMessageTableViewCell
            return cell
            
        case .user:
            let cell = tableView.dequeueReusableCell(withIdentifier: foundUserCellId, for: indexPath) as! FoundUsersTableViewCell
            return cell
        }

    }
    
//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 200
//    }
    
}
