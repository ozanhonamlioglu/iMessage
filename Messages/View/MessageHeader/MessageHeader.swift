//
//  MessageHeader.swift
//  Messages
//
//  Created by ozan honamlioglu on 1.08.2021.
//

import UIKit

class MessageHeader: UIView {
    
    var contentView: UIView?
    
    @IBInspectable var color: UIColor? {
        didSet {
            self.backgroundColor = color
            contentView?.backgroundColor = color
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        let view = Bundle.main.loadNibNamed("MessageHeader", owner: self, options: nil)?.first as! UIView
        addSubview(view)
        contentView = view
    }
    
}
