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
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
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
        
        app.navigationBars["Games List"].buttons["More Info"].tap()
        resetAllButton.tap()
        resetEverything.tap()
        backButton.tap()
        
    }
    
    
    
    //TODO: Reset test all elements
    //TODO: Reset everything flow
    //TODO: Reset all games flow
    //TODO: Reset all games and decks flow
    //TODO: Reset press cancel and check nothing was deleted
        
}
