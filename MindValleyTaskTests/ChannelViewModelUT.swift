//
//  ChannelViewModelUT.swift
//  MindValleyTaskTests
//
//  Created by usama on 29/04/2020.
//  Copyright © 2020 Usama. All rights reserved.
//

import XCTest
@testable import MindValleyTask

class ChannelViewModelUT: XCTestCase {
    
    var sut: ChannelViewModel!
    
    override func setUp() {
        
        sut = ChannelViewModel()
    }
    
    override func tearDown() {
        
        sut = nil
    }
    
}
