//
//  Settings.swift
//  Deck Tracker
//
//  Created by Andrei Joghiu on 04/02/16.
//  Copyright © 2016 Andrei Joghiu. All rights reserved.
//

import XCTest

class Settings: XCTestCase {
    
    let app = XCUIApplication()
    let settingsTitle = XCUIApplication().navigationBars["Settings"]
    let settingsLabel = XCUIApplication().tables.childrenMatchingType(.Other).elementBoundByIndex(0).otherElements["SETTINGS"]
    let resetAllButton = XCUIApplication().buttons["Reset All"]
    let aboutLabel = XCUIApplication().tables.childrenMatchingType(.Other).elementBoundByIndex(1).otherElements["ABOUT"]
    let aboutButton = XCUIApplication().tables.staticTexts["About"]
    let backButton = XCUIApplication().navigationBars["Settings"].buttons["Games List"]
    
    let resetEverything = XCUIApplication().alerts["Full reset"].collectionViews.buttons["Reset everything"]
        
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        XCUIApplication().launch()
        app.navigationBars["Games List"].buttons["More Info"].tap()
    }
        
    func testAllElementsSettingsPage() {
        XCTAssert(backButton.exists)
        XCTAssert(settingsTitle.exists)
        XCTAssert(settingsLabel.exists)
        XCTAssert(resetAllButton.exists)
        XCTAssert(aboutLabel.exists)
        XCTAssert(aboutButton.exists)
    }
    
    func resetAll() {
        XCUIApplication().tabBars.buttons["Stats"].tap()
        app.navigationBars["Games List"].buttons["More Info"].tap()
        resetAllButton.tap()
        resetEverything.tap()
        backButton.tap()
        
    }
        
}
