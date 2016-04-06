//
//  Settings.swift
//  Deck Tracker
//
//  Created by Andrei Joghiu on 04/02/16.
//  Copyright © 2016 Andrei Joghiu. All rights reserved.
//

import XCTest

class Settings: Utils {
    
    let settingsButton = XCUIApplication().navigationBars["Games List"].buttons["More Info"]
    let settingsTitle = XCUIApplication().navigationBars["Settings"]
    let settingsLabel = XCUIApplication().tables.childrenMatchingType(.Other).elementBoundByIndex(0).otherElements["SETTINGS"]
    let resetAllButton = XCUIApplication().buttons["Reset All"]
    let aboutLabel = XCUIApplication().tables.childrenMatchingType(.Other).elementBoundByIndex(1).otherElements["ABOUT"]
    let aboutButton = XCUIApplication().tables.staticTexts["About"]
    let backButton = XCUIApplication().navigationBars["Settings"].buttons["Games List"]
    
    let alertTilte = XCUIApplication().alerts["Full reset"].staticTexts["Full reset"]
    let alertBody = XCUIApplication().alerts["Full reset"].staticTexts["What do you want to delete ?"]
    let resetEverythingButton = XCUIApplication().alerts["Full reset"].collectionViews.buttons["Reset everything"]
    let resetAllGamesButton = XCUIApplication().alerts["Full reset"].collectionViews.buttons["Reset all games"]
    let resetAllGamesAndDecksButton = XCUIApplication().alerts["Full reset"].collectionViews.buttons["Reset all games AND all decks"]
    
        
    override func setUp() {
        super.setUp()
        app.launch()
        sleep(1.0)
        settingsButton.tap()
    }
        
    func testAllElementsSettingsPage() {
        XCTAssert(backButton.exists)
        XCTAssert(settingsTitle.exists)
        XCTAssert(settingsLabel.exists)
        XCTAssert(resetAllButton.exists)
        XCTAssert(aboutLabel.exists)
        XCTAssert(aboutButton.exists)
    }
    
    func testResetElements() {
        resetAllButton.tap()
        XCTAssert(alertTilte.exists)
        XCTAssert(alertBody.exists)
        XCTAssert(resetEverythingButton.exists)
        XCTAssert(resetAllGamesButton.exists)
        XCTAssert(resetAllGamesAndDecksButton.exists)
    }
    
    func resetAllGames() {
        resetAllButton.tap()
        resetAllGamesButton.tap()
        backButton.tap()
    }
    
    func resetAllGamesAndDecks() {
        resetAllButton.tap()
        resetAllGamesAndDecksButton.tap()
        backButton.tap()
    }
    
    //TODO: Add 3 decks, 3 games & 3 tags and check they exist. Then reset all. Check they don't exist anymore
    //TODO: Add 3 decks, 3 games & 3 tags and check they exist. Then reset all games. Check the games does not exist anymore
    //TODO: Add 3 decks, 3 games & 3 tags and check they exist. Then reset all games and decks. Check the games and decks do not exist anymore
        
}
