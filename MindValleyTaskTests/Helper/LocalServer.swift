//
//  LocalServer.swift
//  MindValleyTaskTests
//
//  Created by usama on 19/04/2020.
//  Copyright © 2020 Usama. All rights reserved.
//

import Foundation
import MindValleyTask
import SwiftLocalhost

class LocalServer {

    let localhostServer: LocalhostServer!

    init() {

        localhostServer = LocalhostServer(portNumber: UInt.random(in: 50000..<65000))
        AppTestShared.shared.addLocalHostPort(port: localhostServer.portNumber)

    }

    func startListening() {
        localhostServer.startListening()
    }

    func stopListening() {
        localhostServer.recordedRequests.removeAll()
        localhostServer.stopListening()
    }

    func post(_ path: String, statusCode: HTTPStatusCode, fileName: String) {

        localhostServer.route(method: .POST, path: path, responseData: ResponseDataFactory.responseData(filename: fileName), statusCode: statusCode.rawValue)
    }
    
    func get(_ path: String, statusCode: HTTPStatusCode, fileName: String) {
        
        localhostServer.route(method: .GET, path: path, responseData: ResponseDataFactory.responseData(filename: fileName), statusCode: statusCode.rawValue)
    }
}
