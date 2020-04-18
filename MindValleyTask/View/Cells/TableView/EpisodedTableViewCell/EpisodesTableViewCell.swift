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
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func collectionViewConfiguration() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.registerNib(cellNib: MediaCollectionViewCell.self)
        
    }
    
    override func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {
        
        let height = collectionView.collectionViewLayout.collectionViewContentSize.height + 32 + floor(headerLabel.intrinsicContentSize.height)
         
         let width =  collectionView.collectionViewLayout.collectionViewContentSize.width
         
         collectionView.reloadData()
         collectionView.layoutIfNeeded()
         
        return CGSize(width: width, height: height)
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
//
//        let width = floor(((collectionView.frame.width) / columns) - (inset + spacing))
        
        let width = collectionView.frame.width
        let height = collectionView.frame.height

        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: inset, bottom: 0, right: inset)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
      return spacing
    }
}


extension EpisodesTableViewCell: Dequeueable {
    static func hasNib() -> Bool {
        true
    }
}
