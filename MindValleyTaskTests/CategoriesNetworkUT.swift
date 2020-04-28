//
//  CategoriesNetworkUT.swift
//  MindValleyTaskTests
//
//  Created by usama on 29/04/2020.
//  Copyright © 2020 Usama. All rights reserved.
//

import Foundationimport
import SwiftLocalhost
import Promises
@testable import MindValleyTask

class CategoriesNetworkUT: XCTestCase {
    
    var sut: ChannelViewModel!
    var localServer: LocalServer!
    
    override func setUp() {

        sut = ChannelViewModel()
        localServer = LocalServer()
        localServer.startListening()
    }
    
    override func tearDown() {
            
        sut = nil
        localServer.stopListening()
    }
    
    func test_ApiCall_ForValidCategoryListings() {

        localServer.get(APIPath.categories, statusCode: HTTPStatusCode.ok, fileName: MockData.categories)
        let expectation = XCTestExpectation()

        sut.getCategories()()
            .then { isSuccesfull in
                expectation.fulfill()

            }.catch { (error) in

                expectation.fulfill()
                XCTFail()
        }
        wait(for: [expectation], timeout: 30.0)
    }
    
    
    func test_ApiCall_ForInValidCategoryListings() {

        localServer.get(APIPath.categories, statusCode: HTTPStatusCode.notFound, fileName: MockData.errorNotFound)

        var err: Error?
        let expectation = XCTestExpectation()
        sut.getCategories()
            .then { isSuccesfull in
                expectation.fulfill()
                XCTFail()

            }.catch { (error) in
                err = error
                expectation.fulfill()
        }
        wait(for: [expectation], timeout: 30.0)
        XCTAssertNotNil(err, "can't be nil")
    }
    
    
    private enum APIPath {
        static let categories = "A0CgArX3"
    }
}

