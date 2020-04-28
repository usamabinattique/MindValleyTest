//
//  EpisodesTableViewCell.swift
//  MindValleyTask
//
//  Created by usama on 13/04/2020.
//  Copyright © 2020 Usama. All rights reserved.
//

import UIKit

class EpisodesTableViewCell: BaseTableViewCell {
    
    let inset: CGFloat = 4
    let interItemSpacing: CGFloat = 3

    var episodes: [Episodes] = [] {
        didSet {
            collectionView.reloadData()
            setNeedsLayout()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
        initUI()
        collectionViewConfiguration()
    }
    
    override func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {

        let cellWidth = Int(((collectionView.frame.width) / 2) - (inset + interItemSpacing))
        
        collectionView.frame = CGRect.init(origin: .zero, size: CGSize(width: targetSize.width, height: CGFloat(cellWidth * 2)))

        let absoluteHeight = collectionView.collectionViewLayout.collectionViewContentSize.height + floor(self.headerLabel.intrinsicContentSize.height) + 30

        let absoluteWidth =  collectionView.collectionViewLayout.collectionViewContentSize.width

        collectionView.reloadData()
        layoutIfNeeded()

        return CGSize(width: absoluteWidth, height: absoluteHeight)
    }
}

// MARK: Helper Methods

private extension EpisodesTableViewCell {
    func initUI() {
        
        contentView.backgroundColor = Constants.AppColors.tableCellsBackground
        headerLabel.text = "New Episodes"
        (headerLabel as? HeadingOneLabel)?.font = UIFont(defaultFontStyle: .bold, textStyle: .headline, size: 20)
        headerLabel.textColor = UIColor(red: 0.584, green: 0.596, blue: 0.616, alpha: 1)
        collectionView.backgroundColor = .clear
    }
    
    func collectionViewConfiguration() {
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.registerNib(cellNib: MediaCollectionViewCell.self)
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)

    }
}

// MARK: UICollectionView DataSource

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
        
        let width = Int(((collectionView.frame.width) / 2) - (inset + interItemSpacing))
        
        return CGSize(width: width, height: width * 2)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: inset, bottom: 0, right: inset)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        interItemSpacing
    }
}

extension EpisodesTableViewCell: Dequeueable {
    static func hasNib() -> Bool {
        true
    }
}
