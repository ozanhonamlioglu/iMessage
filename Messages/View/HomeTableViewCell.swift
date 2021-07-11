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
        VfirstLetterName.text = String(sender.prefix(1))
        
        
        
//        let messageWidth = message.widthOfString(usingFont: UIFont(name: "Avenir Next", size: 18)!)
//        let lineCount = round((messageWidth / VcomingFrom.frame.width)) > 3 ? 2 : 2
//
//        VdemoText.translatesAutoresizingMaskIntoConstraints = false
//
//        NSLayoutConstraint.activate([
//            VdemoText.topAnchor.constraint(equalTo: VcontentTopStack.bottomAnchor),
//            VdemoText.heightAnchor.constraint(equalToConstant: CGFloat(lineCount * 18))
//        ])
        
        // VcomingFrom.backgroundColor = .red
        // VdemoText.backgroundColor = .blue
    }
    
}
