//
//  EpisodesCollectionViewCell.swift
//  MindValleyTask
//
//  Created by usama on 13/04/2020.
//  Copyright © 2020 Usama. All rights reserved.
//

import UIKit

class MediaCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var episodeBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var channelBottomConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var mediaTitleLabel: UILabel! {
        didSet {
            mediaTitleLabel.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        }
    }
    @IBOutlet weak var channelTitleLabel: UILabel! {
        didSet {
            channelTitleLabel.textColor = UIColor(red:0.584, green:0.596, blue:0.616, alpha: 1.000)
            
        }
    }
    
    @IBOutlet weak var mediaImageView: UIImageView!

    var paragraphStyle = NSMutableParagraphStyle()
    
    var episode: Episodes! {
        didSet {
            
            episodeBottomConstraint.priority = UILayoutPriority(rawValue: 999)
            channelBottomConstraint.priority = .defaultLow

            paragraphStyle.lineHeightMultiple = 1.05
            mediaTitleLabel.attributedText = NSMutableAttributedString(string: episode.title, attributes: [.kern: 0.4, .paragraphStyle: paragraphStyle])
            
            paragraphStyle.lineHeightMultiple = 0.99
            channelTitleLabel.attributedText = NSMutableAttributedString(string: episode.channel.title, attributes: [.kern: 1, .paragraphStyle: paragraphStyle])
            mediaImageView.getImage(urlString: episode.coverAsset.url) { (image, error) in
                if let image = image {
                    self.mediaImageView.image = image
                }
            }
            contentView.setNeedsLayout()
        }
    }
    
    var channel: ChannelRepresentable! {
        didSet {
            
            channelBottomConstraint.priority = UILayoutPriority(rawValue: 999)
            episodeBottomConstraint.priority = .defaultLow
            mediaTitleLabel.text = channel.title
            channelTitleLabel.text?.removeAll()
            mediaImageView.getImage(urlString: channel.imageUrl) { (image, error) in
                if let image = image {
                    self.mediaImageView.image = image
                }
            }
            contentView.setNeedsLayout()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        addShadow()
    }
    
    func addShadow() {
        // add shadow for image view
        mediaImageView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3).cgColor
        mediaImageView.layer.shadowOpacity = 1
        mediaImageView.layer.shadowOffset = CGSize(width: 0, height: 10)
        mediaImageView.layer.shadowRadius = 20
    }
}

extension MediaCollectionViewCell: Dequeueable {
    static func hasNib() -> Bool {
        true
    }
}
