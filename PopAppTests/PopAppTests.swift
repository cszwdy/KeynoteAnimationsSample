//
//  PopAppTests.swift
//  PopAppTests
//
//  Created by Emiaostein on 1/19/16.
//  Copyright © 2016 Emiaostein. All rights reserved.
//

import XCTest
@testable import PopApp

class PopAppTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        
        let expection = expectationWithDescription("async test")
        var result: String?

        requestName { (aName) in
            result = aName
            expection.fulfill()
        }
        
        waitForExpectationsWithTimeout(3) { (error) in
            XCTAssertTrue(result == "Emiaostein")
        }
    }
}

extension PopAppTests {
    
    func requestName(handler:(String) -> ()) {
        let time: NSTimeInterval = 2
        let delay = dispatch_time(DISPATCH_TIME_NOW,
                                  Int64(time * Double(NSEC_PER_SEC)))
        dispatch_after(delay, dispatch_get_main_queue()) {
            handler("Emiaostein")
        }
    }
}
