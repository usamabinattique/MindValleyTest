//
//  ChannelsTableViewCell.swift
//  MindValleyTask
//
//  Created by usama on 13/04/2020.
//  Copyright © 2020 Usama. All rights reserved.
//

import UIKit

class ChannelsTableViewCell: SharedTableViewCell {

    @IBOutlet weak var totalCountLabel: UILabel!
    @IBOutlet weak var mediaImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}




extension ChannelsTableViewCell: Dequeueable {
    static func hasNib() -> Bool {
        true
    }
}
