//
//  TextMessageTableViewCell.swift
//  Messages
//
//  Created by ozan honamlioglu on 15.07.2021.
//

import UIKit

class TextMessageTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var VcircleImage: UIView!
    @IBOutlet weak var VfirstLetter: UILabel!
    @IBOutlet weak var Vsender: UILabel!
    @IBOutlet weak var Vcontent: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: - Handlers
    func setup(name: String, content: String) {
        VcircleImage.layer.cornerRadius = 25
        VfirstLetter.text = name.firstLetter()
        Vsender.text = name
        Vcontent.text = content
    }
    
}
