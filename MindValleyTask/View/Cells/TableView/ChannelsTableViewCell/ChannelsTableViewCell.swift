//
//  ChannelsTableViewCell.swift
//  MindValleyTask
//
//  Created by usama on 13/04/2020.
//  Copyright © 2020 Usama. All rights reserved.
//

import UIKit

class ChannelsTableViewCell: BaseTableViewCell {

    let interItemSpacing: CGFloat = 3
    let inset: CGFloat = 4
    
    var heightForChannelType: CGFloat!

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
            
            heightForChannelType = channel.channelType == .course ? 2 : 0.65
            
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
    
    override func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {
        
        let verticaConstantForLabels: CGFloat = 30
        
        let width: CGFloat = CGFloat(channel.channelType == .course ? Int(collectionView.frame.width / 2) : Int(collectionView.frame.width / 1.15))
                            
        collectionView.frame = CGRect.init(origin: .zero, size: CGSize(width: targetSize.width, height: width * heightForChannelType))
        let absoluteHeight = collectionView.collectionViewLayout.collectionViewContentSize.height + floor(self.headerLabel.intrinsicContentSize.height) + verticaConstantForLabels + 60
        let absoluteWidth =  collectionView.collectionViewLayout.collectionViewContentSize.width
        
        collectionView.reloadData()
        
        return CGSize(width: absoluteWidth, height: absoluteHeight)
    }
}

// MARK: Helper Methods
private extension ChannelsTableViewCell {
    
    func initUI() {
        contentView.backgroundColor = Constants.AppColors.tableCellsBackground
        collectionView.backgroundColor = .clear

    }

    func collectionViewConfiguration() {
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.registerNib(cellNib: MediaCollectionViewCell.self)
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
    
    private func convertChannelToRepresentable(channel: Channel, indexPath: IndexPath) -> ChannelRepresentable {
        if channel.channelType == .course {
            return ChannelRepresentable(title: channel.latestMedia[indexPath.row].title, imageUrl: channel.latestMedia[indexPath.row].coverAsset.url)
        } else {
           return ChannelRepresentable(title: channel.series![indexPath.row].title, imageUrl: channel.series![indexPath.row].coverAsset.url)
        }
    }
}

// MARK: UICollectionView DataSource

extension ChannelsTableViewCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        channel.channelType == .course ? channel.latestMedia.count : channel.series?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MediaCollectionViewCell.id, for: indexPath) as? MediaCollectionViewCell {
            cell.channel = convertChannelToRepresentable(channel: channel, indexPath: indexPath)
            
            return cell
         }
         return UICollectionViewCell()
    }
}

extension ChannelsTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        let width = channel.channelType == .course ? (collectionView.frame.width / 2) : (collectionView.frame.width / 1.15)
//        let width = Int(collectionView.frame.width / 2)
            
        return CGSize(width: width, height: width * heightForChannelType)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
         UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        interItemSpacing
    }
}

extension ChannelsTableViewCell: Dequeueable {
    static func hasNib() -> Bool {
        true
    }
}
