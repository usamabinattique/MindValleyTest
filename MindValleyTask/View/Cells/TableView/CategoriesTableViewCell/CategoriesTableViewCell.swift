//
//  CategoriesTableViewCell.swift
//  MindValleyTask
//
//  Created by usama on 12/04/2020.
//  Copyright © 2020 Usama. All rights reserved.
//

import UIKit

class CategoriesTableViewCell: SharedTableViewCell {

    let inset: CGFloat = 4
    let spacing: CGFloat = 3
    
    var categories: [Category] = [] {
        didSet {
            collectionView.reloadData()
            layoutIfNeeded()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initUI()
        collectionViewConfiguration()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func initUI() {
        
        contentView.backgroundColor = Constants.AppColors.tableCellsBackground
        headerLabel.text = "Browse by Categories"
        headerLabel.textColor = UIColor(red: 0.584, green: 0.596, blue: 0.616, alpha: 1)
        collectionView.backgroundColor = .clear

    }
    
    func collectionViewConfiguration() {
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isScrollEnabled = false
        collectionView.registerNib(cellNib: CategoriesCollectionViewCell.self)
    }
}

extension CategoriesTableViewCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoriesCollectionViewCell.id, for: indexPath) as? CategoriesCollectionViewCell {
             
             cell.category = categories[indexPath.row]
             return cell
         }
         return UICollectionViewCell()
    }
}

extension CategoriesTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//
//        let width = floor(((collectionView.frame.width) / columns) - (inset + spacing))
        
        let width = collectionView.frame.width

        return CGSize(width: width * 0.45, height: 60)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: inset, bottom: 0, right: inset)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
      return spacing
    }
}

extension CategoriesTableViewCell: Dequeueable {
    static func hasNib() -> Bool {
        true
    }
}
