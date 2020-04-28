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

    @IBOutlet weak var totalCountLabel: UILabel! {
        didSet {
            totalCountLabel.textColor = UIColor(red: 0.584, green: 0.596, blue: 0.616, alpha: 1)
        }
    }
    
    @IBOutlet weak var channelIconThumbnail: UIImageView! {
        didSet {
            channelIconThumbnail.roundOnly()
        }
    }
    
    var channel: Channel! {
         didSet {
             
             totalCountLabel.attributedText =  NSMutableAttributedString(string: String(format: "%d %@", channel.mediaCount,channel.channelType.rawValue), attributes: [.kern: 0.11])
            
            headerLabel.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
            headerLabel.attributedText = NSMutableAttributedString(string: channel.title ?? "...", attributes: [.kern: 0.14])

            channelIconThumbnail.getImage(urlString: channel.iconAsset?.thumbnailURL) { (image, error) in
                if let image = image {
                    self.channelIconThumbnail.image = image
                    self.contentView.setNeedsLayout()
                }
            }
            
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
        collectionView.backgroundColor = .clear

    }

    func collectionViewConfiguration() {
        
        collectionView.isScrollEnabled = true
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.registerNib(cellNib: MediaCollectionViewCell.self)
    }
//
    
    override func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {
          let verticalConstraint: CGFloat = 35.0
              let channelImageHeightConstraint: CGFloat = 50.0
              let width = Int(((collectionView.frame.width) / 2) - (inset + spacing))
              
              collectionView.frame = CGRect.init(origin: .zero, size: CGSize.init(width: targetSize.width, height: CGFloat(2 * width)))
              let correctHeight = collectionView.collectionViewLayout.collectionViewContentSize.height + verticalConstraint + channelImageHeightConstraint
              let correctWidth =  collectionView.collectionViewLayout.collectionViewContentSize.width
              
               collectionView.reloadData()
              
              return CGSize(width: correctWidth, height: correctHeight)
    }
}

extension ChannelsTableViewCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if channel.channelType == .course {
            return channel.latestMedia.count
        } else {
            return channel.channelType == .course ? channel.latestMedia.count : channel.series!.count

        }
        
//        channel.channelType == .course ? channel.latestMedia.count : channel.series?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MediaCollectionViewCell.id, for: indexPath) as? MediaCollectionViewCell {
            cell.channel = convertChannelToRepresentable(channel: channel, indexPath: indexPath)
            
            
            return cell
         }
         return UICollectionViewCell()
    }
    
    private func convertChannelToRepresentable(channel: Channel, indexPath: IndexPath) -> ChannelRepresentable {
        if channel.channelType == .course {
            return ChannelRepresentable(title: channel.latestMedia[indexPath.row].title, imageUrl: channel.latestMedia[indexPath.row].coverAsset.url)
        } else {
           return ChannelRepresentable(title: channel.series![indexPath.row].title, imageUrl: channel.series![indexPath.row].coverAsset.url)
        }
    }
}

extension ChannelsTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = Int(collectionView.frame.width / 2)
            
        return CGSize(width: width, height: 2 * width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
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
