//
//  HomeCell.swift
//  Messages
//
//  Created by ozan honamlioglu on 10.07.2021.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    
    // MARK: Outlets. "V" stands for "View"
    @IBOutlet weak var VidentityHolder: UIView!
    @IBOutlet weak var VfirstLetterName: UILabel!
    @IBOutlet weak var Vdate: UILabel!
    @IBOutlet weak var VcomingFrom: UILabel!
    @IBOutlet weak var VcontentTopStack: UIStackView!
    @IBOutlet weak var VdemoText: UITextView!
    
    func setupUI() {
        VidentityHolder.layer.cornerRadius = 25
    }
    
    func setUpData(sender: String, message: String) {
        setupUI()
        
        VcomingFrom.text = sender
        VdemoText.text = message
        VfirstLetterName.text = sender.firstLetter()
    }
    
}
