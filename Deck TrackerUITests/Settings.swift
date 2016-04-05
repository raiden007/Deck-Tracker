//
//  Settings.swift
//  Deck Tracker
//
//  Created by Andrei Joghiu on 04/02/16.
//  Copyright © 2016 Andrei Joghiu. All rights reserved.
//

import XCTest

class Settings: Utils {
    
    let settignsButton = XCUIApplication().navigationBars["Games List"].buttons["More Info"]
    let settingsTitle = XCUIApplication().navigationBars["Settings"]
    let settingsLabel = XCUIApplication().tables.childrenMatchingType(.Other).elementBoundByIndex(0).otherElements["SETTINGS"]
    let resetAllButton = XCUIApplication().buttons["Reset All"]
    let aboutLabel = XCUIApplication().tables.childrenMatchingType(.Other).elementBoundByIndex(1).otherElements["ABOUT"]
    let aboutButton = XCUIApplication().tables.staticTexts["About"]
    let backButton = XCUIApplication().navigationBars["Settings"].buttons["Games List"]
    
    let resetEverything = XCUIApplication().alerts["Full reset"].collectionViews.buttons["Reset everything"]
        
    override func setUp() {
        super.setUp()
        app.launch()
        sleep(1.0)
        settignsButton.tap()
    }
        
    func testAllElementsSettingsPage() {
        XCTAssert(backButton.exists)
        XCTAssert(settingsTitle.exists)
        XCTAssert(settingsLabel.exists)
        XCTAssert(resetAllButton.exists)
        XCTAssert(aboutLabel.exists)
        XCTAssert(aboutButton.exists)
    }
    

        
}
