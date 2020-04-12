//
//  AppearenceProxyManager.swift
//  MindValleyTask
//
//  Created by usama on 12/04/2020.
//  Copyright © 2020 Usama. All rights reserved.
//

import UIKit

class AppearanceProxyManager {

    static let shared = AppearanceProxyManager()
    private let theme: Theme = DefaultTheme()

    var currentTheme: Theme {
        return theme
    }

    ///
    func applyDefaultControllsApperance() {
        theme.apply(for: UIApplication.shared)
    }
    
    static func displayApplicationPath() -> String {
        NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last!
    }
}
