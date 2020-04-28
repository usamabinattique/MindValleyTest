//
//  CategoriesTableViewCell.swift
//  MindValleyTask
//
//  Created by usama on 12/04/2020.
//  Copyright © 2020 Usama. All rights reserved.
//

import UIKit

class CategoriesTableViewCell: BaseTableViewCell {

    let inset: CGFloat = 4
    let interItemSpacing: CGFloat = 3
    
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
    
        headerLabel.attributedText = NSMutableAttributedString(string: "Browse by categories", attributes: [.kern: 0.4])
        headerLabel.textColor = UIColor(red: 0.584, green: 0.596, blue: 0.616, alpha: 1)
        collectionView.backgroundColor = .clear
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 18, bottom: 0, right: 18)
        
    }
    
    func collectionViewConfiguration() {
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.registerNib(cellNib: CategoriesCollectionViewCell.self)
    }
    
    override func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {
        
        let correctHeight = floor(headerLabel.intrinsicContentSize.height)
         + collectionView.collectionViewLayout.collectionViewContentSize.height + 50
        let correctWidth =  collectionView.collectionViewLayout.collectionViewContentSize.width
        collectionView.reloadData()
        collectionView.layoutIfNeeded()
        return CGSize(width: correctWidth, height: correctHeight)
    }
}

// MARK: UICollectionView DataSource

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

        let width = Int(((collectionView.frame.width - 40 ) / 2) - 2 * (inset + interItemSpacing))
              
          return CGSize(width: width, height: 60)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
      return interItemSpacing
    }
}

extension CategoriesTableViewCell: Dequeueable {
    static func hasNib() -> Bool {
        true
    }
}
