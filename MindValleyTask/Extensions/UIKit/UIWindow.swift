//
//  UIWindow.swift
//  MindValleyTask
//
//  Created by usama on 12/04/2020.
//  Copyright © 2020 Usama. All rights reserved.
//

import UIKit


public extension UIWindow {

    /// Unload all views and add back.
    /// Useful for applying `UIAppearance` changes to existing views.
    func reload() {
        subviews.forEach { view in
            view.removeFromSuperview()
            addSubview(view)
        }
    }

}

public extension Array where Element == UIWindow {

    /// Unload all views for each `UIWindow` and add back.
    /// Useful for applying `UIAppearance` changes to existing views.
    func reload() {
        forEach { $0.reload() }
    }
}
