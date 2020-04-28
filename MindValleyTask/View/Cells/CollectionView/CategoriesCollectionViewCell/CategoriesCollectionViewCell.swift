//
//  CategoriesCollectionViewCell.swift
//  MindValleyTask
//
//  Created by usama on 13/04/2020.
//  Copyright © 2020 Usama. All rights reserved.
//

import UIKit

class CategoriesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var labelView: UIView! {
        didSet {
            labelView.backgroundColor = UIColor(red: 0.584, green: 0.596, blue: 0.616, alpha: 0.2)
            labelView.layer.cornerRadius = labelView.frame.height / 2 - 10

        }
    }

    @IBOutlet weak var nameLabel: UILabel! {
        didSet {
            (nameLabel as? HeadingTwoLabel)?.backgroundColor = .clear
             nameLabel.layer.cornerRadius = nameLabel.frame.height / 2
            (nameLabel as? HeadingTwoLabel)?.font = UIFont(defaultFontStyle: .bold, textStyle: .largeTitle, size: 18.0)
             (nameLabel as? HeadingTwoLabel)?.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        }
    }
    var paragraphStyle = NSMutableParagraphStyle()

    var category: Category! {
        didSet {
            
            nameLabel.attributedText = NSMutableAttributedString(string: category.name, attributes: [.kern: 0.13, .paragraphStyle: paragraphStyle])
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        initUI()
    }
    
    func initUI() {
        contentView.backgroundColor = .clear
        paragraphStyle.lineHeightMultiple = 1.08
    }
}

extension CategoriesCollectionViewCell: Dequeueable {
    static func hasNib() -> Bool {
        true
    }
}
