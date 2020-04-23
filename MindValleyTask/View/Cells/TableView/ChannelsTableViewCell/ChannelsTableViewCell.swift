//
//  ChannelsTableViewCell.swift
//  MindValleyTask
//
//  Created by usama on 13/04/2020.
//  Copyright © 2020 Usama. All rights reserved.
//

import UIKit

class ChannelsTableViewCell: SharedTableViewCell {

    let spacing: CGFloat = 3
    let inset: CGFloat = 4
    
    @IBOutlet weak var channelTitle: UILabel!

    @IBOutlet weak var totalCountLabel: UILabel!
    @IBOutlet weak var channelIconThumbnail: UIImageView!
    
    var channel: Channel! {
         didSet {
             
             totalCountLabel.text = String(format: "%d %@", channel.mediaCount, channel.channelType.rawValue)
            headerLabel.text = channel.title
            
            channelIconThumbnail.getImage(urlString: channel.iconAsset?.thumbnailURL) { (image, error) in
                if let image = image {
                    self.channelIconThumbnail.image = image
                    self.contentView.layoutIfNeeded()
                }
            }
            
             collectionView.reloadData()
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
        
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.registerNib(cellNib: CategoriesCollectionViewCell.self)
    }
}

extension ChannelsTableViewCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoriesCollectionViewCell.id, for: indexPath) as? MediaCollectionViewCell {
             
            cell.channel = channel
            
            return cell
         }
         return UICollectionViewCell()
    }
}

extension ChannelsTableViewCell: UICollectionViewDelegateFlowLayout {
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

extension ChannelsTableViewCell: Dequeueable {
    static func hasNib() -> Bool {
        true
    }
}
