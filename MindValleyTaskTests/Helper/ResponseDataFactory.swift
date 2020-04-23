//
//  ResponseDataFactory.swift
//  MindValleyTaskTests
//
//  Created by usama on 19/04/2020.
//  Copyright © 2020 Usama. All rights reserved.
//

import Foundation

class ResponseDataFactory {

    static func responseData(filename: String) -> Data {
        //let te = Bundle(for: ResponseDataFactory.self).path(forResource: filename, ofType: "json", inDirectory: "MockData")

        guard let path = Bundle(for: ResponseDataFactory.self).path(forResource: filename, ofType: "json"),
            let data = try? NSData.init(contentsOfFile: path, options: []) else {
                fatalError("\(filename).json not found")
        }
        return data as Data
    }
}
