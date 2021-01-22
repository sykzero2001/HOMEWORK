//
//  WHOSCALL_WORKTests.swift
//  WHOSCALL_WORKTests
//
//  Created by Dante on 2021/1/12.
//  Copyright © 2021 Dante. All rights reserved.
//

import XCTest
@testable import WHOSCALL_WORK

class WHOSCALL_WORKTests: XCTestCase {
    var urlSession: URLSession!
  var viewController: TopItemDisplayController!
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
         viewController = storyboard.instantiateInitialViewController() as? TopItemDisplayController
        _ = viewController.view
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
      
    }

    func testExample() {
        
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
