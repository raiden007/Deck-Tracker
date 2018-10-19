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
    let settingsLabel = XCUIApplication().tables.children(matching: .other).element(boundBy: 0).otherElements["SETTINGS"]
    let resetAllButton = XCUIApplication().buttons["Reset All"]
    let aboutLabel = XCUIApplication().tables.children(matching: .other).element(boundBy: 1).otherElements["ABOUT"]
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
    
    func testResetEverything() {
        backButton.tap()
        resetAll()
        
        // Add a new deck and check it appears
        Decks().decksTab.tap()
        XCTAssert(app.tables.cells.count == 0)
        Decks().addDeck("Reset", deckClass: "Druid")
        XCTAssert(app.tables.cells.count == 1)
        
        // Add a new game and check it appears
        Games().gamesTab.tap()
        XCTAssert(app.tables.cells.count == 0)
        AddNewGame().addNewGame("", deckName: "Reset", deckClass: "Druid", opponent: "Druid", coin: false, win: true, tag: "")
        print(app.tables.cells.count)
        XCTAssert(app.tables.cells.count == 1)

        // Add a new tag and check it appears
        AddNewGame().addNewGameButton.tap()
        AddNewGame().tagCell.tap()
        XCTAssert(app.tables.cells.count == 0)
        AddNewGameTags().addNewTag("reset stuff")
        XCTAssert(app.tables.cells.count == 1)
        AddNewGameTags().backButton.tap()
        AddNewGame().cancelButton.tap()
        
        // Reset all and check data is deleted
        resetAll()
        Decks().decksTab.tap()
        XCTAssert(app.tables.cells.count == 0)
        Games().gamesTab.tap()
        XCTAssert(app.tables.cells.count == 0)
        AddNewGame().addNewGameButton.tap()
        AddNewGame().tagCell.tap()
        XCTAssert(app.tables.cells.count == 0)
    }
    
    func testResetAllGames() {
        backButton.tap()
        resetAll()
        
        // Add a new deck and check it appears
        Decks().decksTab.tap()
        XCTAssert(app.tables.cells.count == 0)
        Decks().addDeck("Reset", deckClass: "Druid")
        XCTAssert(app.tables.cells.count == 1)
        
        // Add a new game and check it appears
        Games().gamesTab.tap()
        XCTAssert(app.tables.cells.count == 0)
        AddNewGame().addNewGame("", deckName: "Reset", deckClass: "Druid", opponent: "Druid", coin: false, win: true, tag: "")
        print(app.tables.cells.count)
        XCTAssert(app.tables.cells.count == 1)
        
        // Add a new tag and check it appears
        AddNewGame().addNewGameButton.tap()
        AddNewGame().tagCell.tap()
        XCTAssert(app.tables.cells.count == 0)
        AddNewGameTags().addNewTag("reset stuff")
        XCTAssert(app.tables.cells.count == 1)
        AddNewGameTags().backButton.tap()
        AddNewGame().cancelButton.tap()
        
        // Reset all games and check data is deleted
        settingsButton.tap()
        resetAllGames()
        Decks().decksTab.tap()
        XCTAssert(app.tables.cells.count == 1)
        Games().gamesTab.tap()
        XCTAssert(app.tables.cells.count == 0)
        AddNewGame().addNewGameButton.tap()
        AddNewGame().tagCell.tap()
        XCTAssert(app.tables.cells.count == 1)
    }
    
    func testResetAllGamesAndDecks() {
        backButton.tap()
        resetAll()
        
        // Add a new deck and check it appears
        Decks().decksTab.tap()
        XCTAssert(app.tables.cells.count == 0)
        Decks().addDeck("Reset", deckClass: "Druid")
        XCTAssert(app.tables.cells.count == 1)
        
        // Add a new game and check it appears
        Games().gamesTab.tap()
        XCTAssert(app.tables.cells.count == 0)
        AddNewGame().addNewGame("", deckName: "Reset", deckClass: "Druid", opponent: "Druid", coin: false, win: true, tag: "")
        print(app.tables.cells.count)
        XCTAssert(app.tables.cells.count == 1)
        
        // Add a new tag and check it appears
        AddNewGame().addNewGameButton.tap()
        AddNewGame().tagCell.tap()
        XCTAssert(app.tables.cells.count == 0)
        AddNewGameTags().addNewTag("reset stuff")
        XCTAssert(app.tables.cells.count == 1)
        AddNewGameTags().backButton.tap()
        AddNewGame().cancelButton.tap()
        
        // Reset all games & decks and check data is deleted
        settingsButton.tap()
        resetAllGamesAndDecks()
        Decks().decksTab.tap()
        XCTAssert(app.tables.cells.count == 0)
        Games().gamesTab.tap()
        XCTAssert(app.tables.cells.count == 0)
        AddNewGame().addNewGameButton.tap()
        AddNewGame().tagCell.tap()
        XCTAssert(app.tables.cells.count == 1)
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
}
