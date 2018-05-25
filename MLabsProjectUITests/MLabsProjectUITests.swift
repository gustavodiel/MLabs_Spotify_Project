//
//  MLabsProjectUITests.swift
//  MLabsProjectUITests
//
//  Created by Gustavo Diel on 22/05/18.
//  Copyright © 2018 Gustavo Diel. All rights reserved.
//

import XCTest

class MLabsProjectUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testOpenLinks(){
        
        let app = XCUIApplication()
        let tablesQuery = app.tables
        let cell = tablesQuery.children(matching: .cell).element(boundBy: 3)
        cell.children(matching: .textView).element(boundBy: 1).tap()
        cell.children(matching: .textView).element(boundBy: 0).tap()
        
        let textView = tablesQuery.children(matching: .cell).element(boundBy: 2).children(matching: .textView).element(boundBy: 0)
        textView.tap()
        tablesQuery.children(matching: .cell).element(boundBy: 0).children(matching: .textView).element(boundBy: 2).tap()
        textView.tap()
        
        let cell2 = tablesQuery.children(matching: .cell).element(boundBy: 1)
        cell2.children(matching: .textView).element(boundBy: 1).tap()
        cell2.children(matching: .textView).element(boundBy: 3).tap()
        
        let textView2 = cell2.children(matching: .textView).element(boundBy: 2)
        textView2.tap()
        textView2.tap()
        
        let tabBarsQuery = app.tabBars
        let aboutButton = tabBarsQuery.buttons["About"]
        aboutButton.tap()
        tabBarsQuery.buttons["Spotify"].tap()
        aboutButton.tap()
        

        
    }
    
}
