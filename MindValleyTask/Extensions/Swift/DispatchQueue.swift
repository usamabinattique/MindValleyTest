//
//  DispatchQueue.swift
//  MindValleyTask
//
//  Created by usama on 29/04/2020.
//  Copyright © 2020 Usama. All rights reserved.
//

import Foundation

extension DispatchQueue {

    static var defaultBackgroundQueue: DispatchQueue {
        return .global(qos: .background)
    }

    static func delay(_ delay: DispatchTimeInterval, closure: @escaping () -> Void) {
        let timeInterval = DispatchTime.now() + delay
        DispatchQueue.main.asyncAfter(deadline: timeInterval, execute: closure)
    }
}
