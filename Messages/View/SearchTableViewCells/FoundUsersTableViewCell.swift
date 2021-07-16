//
//  FoundUsersTableViewCell.swift
//  Messages
//
//  Created by ozan honamlioglu on 15.07.2021.
//

import UIKit

class FoundUsersTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    // MARK: - Properties
    var data: [SearchDataModel]!
    let cellId = "cellId"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        setup()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: - Handlers
    private func setup() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(FoundUserCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
    }

}

extension FoundUsersTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! FoundUserCollectionViewCell
        let sender = data[indexPath.row].sender
        cell.setup(name: sender!)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let size = UIScreen.main.bounds
            .width / 4
        
        return CGSize(width: size, height: size)
    }
    
}


class FoundUserCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Handlers
    private func createCircleUser(_ name: String) -> UIView {
        let vw = UIView()

        let size = FoundUserCellSize - 20
        let centerXY = (FoundUserCellSize / 2) - (size / 2)
        vw.frame = CGRect(x: centerXY, y: centerXY, width: size, height: size)
        vw.layer.cornerRadius = size / 2
        vw.backgroundColor = .systemGray4
        
        let firstLetterLabel = UILabel()
        firstLetterLabel.textColor = .white
        firstLetterLabel.text = name.firstLetter()
        firstLetterLabel.font = UIFont(name: "ArialRoundedMTBold", size: 30)
        firstLetterLabel.translatesAutoresizingMaskIntoConstraints = false
        
        vw.addSubview(firstLetterLabel)
        NSLayoutConstraint.activate([
            firstLetterLabel.centerYAnchor.constraint(equalTo: vw.centerYAnchor),
            firstLetterLabel.centerXAnchor.constraint(equalTo: vw.centerXAnchor)
        ])
        
        let firstNameLabel = UILabel()
        firstNameLabel.textColor = .label
        firstNameLabel.text = name
        firstNameLabel.font = UIFont(name: "ArialRoundedMTBold", size: 12)
        firstNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        vw.addSubview(firstNameLabel)
        NSLayoutConstraint.activate([
            firstNameLabel.topAnchor.constraint(equalTo: vw.bottomAnchor),
            firstNameLabel.centerXAnchor.constraint(equalTo: vw.centerXAnchor)
        ])
        
        return vw
    }
    
    func setup(name: String) {
        let circle = createCircleUser(name)
        contentView.addSubview(circle)
    }
    
}
