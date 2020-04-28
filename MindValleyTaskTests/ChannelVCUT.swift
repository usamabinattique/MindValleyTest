//
//  ChannelVCUT.swift
//  MindValleyTaskTests
//
//  Created by usama on 29/04/2020.
//  Copyright © 2020 Usama. All rights reserved.
//

import XCTest
@testable import MindValleyTask

class ChannelVCUT: XCTestCase {
    
    var sut: ChannelVC!
    
    override func setUp() {
        initializeViewController()
    }


    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
    }

    func initializeViewController() {
         
        let storyBoard = UIStoryboard(name: "Main", bundle: .main)
         
         sut = storyBoard.instantiateViewController(withIdentifier: "ChannelVC") as? ChannelVC
     
         _ = sut.view
     }
    
    func testCheckIfChannelVCLoaded_WhenViewIsLoaded() {
          
          XCTAssertNotNil(sut, "Channel View Controller is initialized")
          
      }

}



