//
//  UICollectionView.swift
//  MindValleyTask
//
//  Created by usama on 18/04/2020.
//  Copyright © 2020 Usama. All rights reserved.
//

import UIKit


extension UICollectionView {
    
    public func registerNib(cellNib cell: Dequeueable.Type) {
        let nib = UINib(nibName: cell.id, bundle: .main)
        register(nib, forCellWithReuseIdentifier: cell.id)
        
    }
}



