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
        continueAfterFailure = false
        XCUIApplication().launch()
    }
    
    func testElements() {
        XCTAssert(settingsButton.exists)
        XCTAssert(addGameButton.exists)
        XCTAssert(gamesListScreenTitle.exists)
    }
    
}
