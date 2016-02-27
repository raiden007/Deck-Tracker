//
//  Games.swift
//  Deck Tracker
//
//  Created by Andrei Joghiu on 27/02/16.
//  Copyright © 2016 Andrei Joghiu. All rights reserved.
//

import XCTest

class Games: XCTestCase {
    
    let settingsButton = XCUIApplication().navigationBars["Games List"].buttons["More Info"]
    let addGameButton = XCUIApplication().navigationBars["Games List"].buttons["Add"]
    let gamesListScreenTitle = XCUIApplication().navigationBars["Games List"].staticTexts["Games List"]
        
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
    
    func testElements() {
        XCTAssert(settingsButton.exists)
        XCTAssert(addGameButton.exists)
        XCTAssert(gamesListScreenTitle.exists)
    }
    
}
