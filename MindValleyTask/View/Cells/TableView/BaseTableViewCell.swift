//
//  SharedTableViewCell.swift
//  MindValleyTask
//
//  Created by usama on 13/04/2020.
//  Copyright © 2020 Usama. All rights reserved.
//

import UIKit

class BaseTableViewCell: UITableViewCell {

    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var separatorView: UIView! {
         didSet {
            separatorView.backgroundColor = UIColor(red: 0.235, green: 0.263, blue: 0.306, alpha: 1)
         }
     }
}
