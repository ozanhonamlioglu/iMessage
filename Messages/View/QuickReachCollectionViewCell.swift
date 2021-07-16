//
//  QuickReachCollectionViewCell.swift
//  Messages
//
//  Created by ozan honamlioglu on 11.07.2021.
//

import UIKit

class QuickReachCollectionViewCell: UICollectionViewCell {
    
    private func createBigCircle(_ name: String) -> UIView {
        let firstLetterOfName = name.firstLetter()
        
        let measure = QuickReachCellSize - 30
        let xycenter = (QuickReachCellSize / 2) - (measure / 2)
        
        let vw = UIView(frame: CGRect(x: xycenter, y: xycenter, width: measure, height: measure))
        vw.backgroundColor = .lightGray
        vw.layer.cornerRadius = measure / 2
        
        let label = UILabel()
        label.text = firstLetterOfName
        label.textColor = .white
        label.font = UIFont(name: "ArialRoundedMTBold", size: 40)
        label.translatesAutoresizingMaskIntoConstraints = false
        vw.addSubview(label)
        
        let nameLabel = UILabel()
        nameLabel.text = name
        nameLabel.textColor = .label
        nameLabel.font = UIFont(name: "AvenirNext-Regular", size: 17)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        vw.addSubview(nameLabel)
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: vw.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: vw.centerYAnchor),
            nameLabel.bottomAnchor.constraint(equalTo: vw.bottomAnchor, constant: 25),
            nameLabel.centerXAnchor.constraint(equalTo: vw.centerXAnchor)
        ])
        
        return vw
    }
    
    func setupUI(name: String) {
        let bigCircle = createBigCircle(name)
        contentView.addSubview(bigCircle)
    }
    
}
