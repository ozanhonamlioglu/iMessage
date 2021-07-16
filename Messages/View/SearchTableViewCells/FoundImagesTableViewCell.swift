//
//  FoundImagesTableViewCell.swift
//  Messages
//
//  Created by ozan honamlioglu on 15.07.2021.
//

import UIKit

class FoundImagesTableViewCell: UITableViewCell {
    
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
        
        collectionView.register(FoundImageCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
    }

    
}

extension FoundImagesTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! FoundImageCollectionViewCell
        
        let row = data[indexPath.row]
        cell.setup(link: row.link!)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: FoundImageCellSize, height: FoundImageCellSize)
    }
}

class FoundImageCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createImage(_ link: String) -> UIImageView {
        
        let size = FoundImageCellSize - 20
        let centerXY = (FoundImageCellSize / 2) - (size / 2)
        let imgView = UIImageView(frame: CGRect(x: centerXY, y: centerXY, width: size, height: size))
        imgView.image = UIImage(named: link)
        return imgView
    }
    
    func setup(link: String) {
        let v = createImage(link)
        contentView.addSubview(v)
    }
    
}
