//
//  SharedLogger.swift
//  MindValleyTask
//
//  Created by usama on 11/04/2020.
//  Copyright © 2020 Usama. All rights reserved.
//

import Foundation

public final class SharedLogger {

    static private(set) var privateQueue = DispatchQueue(label: "com.usama.loggingQueue")

    /// Logging Error Message to console
    ///
    /// - Parameter message: String
    public static func logError(_ message: String) {
        
        privateQueue.async {
            print("*********** Error *********** : \(message)")
        }
    }
    /// Logging Info to console
    ///
    /// - Parameter message: String
    public static func logInfo(_ message: String) {

        privateQueue.async {
            print(message)
        }
    }

    /// Loging Error
    ///
    /// - Parameter error: Error
    public static func logException(_ error: Error) {
        privateQueue.async {
         print((error as NSError).localizedDescription)
        }
    }
}
