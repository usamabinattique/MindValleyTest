//
//  UIView.swift
//  MindValleyTask
//
//  Created by usama on 24/04/2020.
//  Copyright © 2020 Usama. All rights reserved.
//

import UIKit

extension UIView {
    
    func roundOnly(radius: CGFloat? = nil) {
        if let radius = radius {
            self.layer.cornerRadius = radius
        } else {
            self.layer.cornerRadius = self.frame.size.height / 2
        }
    }
}
