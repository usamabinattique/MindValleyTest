//
//  API.swift
//  MindValleyTask
//
//  Created by usama on 12/04/2020.
//  Copyright © 2020 Usama. All rights reserved.
//

import Foundation

/// Main `NetworkEndPoint`s for the app
enum API: NetworkEndPoint {
    case channels
    case episodes
    case categories
}

/// Implementation of `NetworkEndPoint`
extension API {
    
    var isTesting: Bool {
        return false
    }
    /// path for the endpoint
    var path: String {
        switch self {
        case .channels:
            return "Xt12uVhM"
        case .episodes:
            return "z5AExTtw"
        case .categories:
            return "A0CgArX3"
        }
    }
    /// http method for endpoint
    var method: HTTPMethod {
        return .get
    }
    /// Query items for endpoint
    var queryItems: KeyValuePairs<String, String>? {
        return nil
    }
    
    /// Body disctionary for endpotins
    var body: Data? {
        return nil
    }
    var contentType: HTTPContentType {
        return .json
    }
    /// Default headers
    var headers: [String: String]? {
        return nil
    }
    
    var url: URL {
        if NSClassFromString("XCTest") != nil {
            return URL(string: "http://localhost:\(AppTestShared.shared.getLocalHostPort())")!.appendingPathComponent(path)
            
        }
        return URL(string: Constants.baseUrl)!.appendingPathComponent(path)
    }
}