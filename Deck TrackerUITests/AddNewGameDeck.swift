//
//  AddNewGameDeck.swift
//  Deck Tracker
//
//  Created by Andrei Joghiu on 04/04/16.
//  Copyright © 2016 Andrei Joghiu. All rights reserved.
//

import XCTest

class AddNewGameDeck: Utils {
    
    let addNewGameButton = Games().addGameButton
    let pickDeckCell = XCUIApplication().cells.elementBoundByIndex(1)
    
    let backButton = XCUIApplication().navigationBars["Decks"].buttons["Add New Game"]
    let selectDeckTitleScreen = XCUIApplication().navigationBars["Decks"].staticTexts["Decks"]
    let addDeckButton = XCUIApplication().navigationBars["Decks"].buttons["Add"]

    
    override func setUp() {
        super.setUp()
        XCUIApplication().launch()
        sleep(1.0)
        addNewGameButton.tap()
        pickDeckCell.tap()
    }
    
    func testElements() {
        XCTAssert(backButton.exists)
        XCTAssert(selectDeckTitleScreen.exists)
        XCTAssert(addDeckButton.exists)
        
        addDeckButton.tap()
        Decks().elementsNewDeckScreen()
        
        Decks().cancelButton.tap()
        backButton.tap()
        XCTAssert(AddNewGame().newGameTitle.exists)
    }
    
    func testAddDeck() {
        Decks().addDeck("From Add Game", deckClass: "Druid")
        Decks().tapDeck("From Add Game")
        
        let deckName = app.cells.elementBoundByIndex(1).staticTexts["Your deck: From Add Game"]
        XCTAssert(deckName.exists)
    }
    
}
