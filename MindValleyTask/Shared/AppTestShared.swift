//
//  AppTestShared.swift
//  MindValleyTask
//
//  Created by usama on 12/04/2020.
//  Copyright © 2020 Usama. All rights reserved.
//

import Foundation

public class AppTestShared {

    public static let shared = AppTestShared()
    private var port: UInt!

    public func addLocalHostPort(port: UInt) {
        self.port = port
    }

    func getLocalHostPort() -> UInt {
        return port
    }
}
