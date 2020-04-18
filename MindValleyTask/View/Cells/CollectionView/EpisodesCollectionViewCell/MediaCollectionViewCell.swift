//
//  EpisodesCollectionViewCell.swift
//  MindValleyTask
//
//  Created by usama on 13/04/2020.
//  Copyright © 2020 Usama. All rights reserved.
//

import UIKit

class MediaCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var mediaTitleLabel: UILabel!
    @IBOutlet weak var channelTitleLabel: UILabel!
    @IBOutlet weak var mediaImageView: UIImageView!
    
    var episode: Episodes! {
        didSet {
//            mediaTitleLabel.text = epis
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}


extension MediaCollectionViewCell: Dequeueable {
    static func hasNib() -> Bool {
        true
    }
}
