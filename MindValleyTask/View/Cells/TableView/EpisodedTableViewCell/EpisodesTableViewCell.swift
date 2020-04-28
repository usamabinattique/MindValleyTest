//
//  EpisodesTableViewCell.swift
//  MindValleyTask
//
//  Created by usama on 13/04/2020.
//  Copyright © 2020 Usama. All rights reserved.
//

import UIKit

class EpisodesTableViewCell: SharedTableViewCell {
    
    let inset: CGFloat = 4
    let spacing: CGFloat = 3

    var episodes: [Episodes] = [] {
        didSet {
            collectionView.reloadData()
            layoutIfNeeded()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
        initUI()
        collectionViewConfiguration()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func initUI() {
        
        contentView.backgroundColor = Constants.AppColors.tableCellsBackground
        headerLabel.text = "New Episodes"
        (headerLabel as? HeadingOneLabel)?.font = UIFont(defaultFontStyle: .bold, textStyle: .headline, size: 20)
        headerLabel.textColor = UIColor(red: 0.584, green: 0.596, blue: 0.616, alpha: 1)
        collectionView.backgroundColor = .clear
    }
    
    func collectionViewConfiguration() {
        
        collectionView.isScrollEnabled = true
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.registerNib(cellNib: MediaCollectionViewCell.self)
//        collectionView.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)

    }
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        
//            self.collectionView.constant = self.collectionView.collectionViewLayout.collectionViewContentSize.height

    }
    
    override func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {

        let cellWidth = Int(((collectionView.frame.width) / 2) - (inset + spacing))
        
//        let constraintVertical: CGFloat = 30.0

        collectionView.layoutIfNeeded()
        collectionView.frame = CGRect.init(origin: .zero, size: CGSize(width: targetSize.width, height: CGFloat(cellWidth * 2)))

        let absoluteHeight = collectionView.collectionViewLayout.collectionViewContentSize.height + floor(self.headerLabel.intrinsicContentSize.height)

        let absoluteWidth =  collectionView.collectionViewLayout.collectionViewContentSize.width

        collectionView.reloadData()
//        collectionView.layoutIfNeeded()

        return CGSize(width: absoluteWidth, height: absoluteHeight)
    }
}

extension EpisodesTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        episodes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MediaCollectionViewCell.id, for: indexPath) as? MediaCollectionViewCell {

            cell.episode = episodes[indexPath.row]
            return cell
        }
        return UICollectionViewCell()
    }
}


extension EpisodesTableViewCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let width = Int(((collectionView.frame.width) / 2) - (inset + spacing))

        return CGSize(width: width, height: width * 2)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 15)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {

      return 0
    }
}


extension EpisodesTableViewCell: Dequeueable {
    static func hasNib() -> Bool {
        true
    }
}
