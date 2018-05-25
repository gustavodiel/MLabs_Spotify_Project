//
//  MLabsProjectTests.swift
//  MLabsProjectTests
//
//  Created by Gustavo Diel on 22/05/18.
//  Copyright © 2018 Gustavo Diel. All rights reserved.
//

import XCTest
@testable import MLabsProject
import UIImageColors

class MLabsProjectTests: XCTestCase {
    
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
    
    func testPerformanceGetColorHigh() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
            for _ in 1...100 {
                #imageLiteral(resourceName: "spotify").getColors()
            }
        }
    }
        
    func testPerformanceGetColorLow() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
            for _ in 1...100 {
                #imageLiteral(resourceName: "spotify").getColors(quality: .low)
            }
        }
    }
    
    func testPerformanceGetColorLowest() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
            for _ in 1...100 {
                #imageLiteral(resourceName: "spotify").getColors(quality: .lowest)
            }
        }
    }
    
}
