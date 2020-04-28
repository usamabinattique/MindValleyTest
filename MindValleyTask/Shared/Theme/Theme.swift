//
//  Theme.swift
//  MindValleyTask
//
//  Created by usama on 12/04/2020.
//  Copyright © 2020 Usama. All rights reserved.
//

import UIKit

protocol Theme {
    func apply(for application: UIApplication)
    func extend()
}

extension Theme {
    
    func apply(for application: UIApplication) {
        
        UITableViewCell.appearance().with {
            $0.backgroundColor = .clear
        }
        
        
        extend()
        
        application.windows.reload()
    }
}

extension Theme {
    func extend() {
        HeadingOneLabel.appearance().with {
            $0.font = UIFont(defaultFontStyle: .regular, size: 20.0)
            $0.textColor = .white
            $0.adjustsFontForContentSizeCategory = true
        }
        
        HeadingTwoLabel.appearance().with {
            $0.font = UIFont(defaultFontStyle: .regular, size: 18.0)
            $0.textColor = .white
        }
    }
}
