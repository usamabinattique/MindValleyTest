//
//  EpisodesUT.swift
//  MindValleyTaskTests
//
//  Created by usama on 29/04/2020.
//  Copyright © 2020 Usama. All rights reserved.
//

import XCTest
import SwiftLocalhost
import Promises
@testable import MindValleyTask

class EpisodesNetworkUT: XCTestCase {

    var sut: ChannelViewModel!
    var localServer: LocalServer!
    
    override func setUp() {

        sut = ChannelViewModel()
        localServer = LocalServer()
        //LocalhostServer.initializeUsingRandomPortNumber()
        localServer.startListening()
    }
    
    override func tearDown() {
            
        sut = nil
        localServer.stopListening()
    }
    
    func test_ApiCall_ForValidEpisodeListings() {

        localServer.get(APIPath.episodes, statusCode: HTTPStatusCode.ok, fileName: MockData.episodes)
        let expectation = XCTestExpectation()

        sut.getEpisodesData()
            .then { isSuccesfull in
                expectation.fulfill()

            }.catch { (error) in

                expectation.fulfill()
                XCTFail()
        }
        wait(for: [expectation], timeout: 30.0)
    }
    
    
    func test_ApiCall_ForInValidEpisodeListings() {

           localServer.get(APIPath.episodes, statusCode: HTTPStatusCode.notFound, fileName: MockData.errorNotFound)

           var err: Error?
           let expectation = XCTestExpectation()
           sut.getEpisodesData()
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
        static let episodes = "z5AExTtw"
    }
}
