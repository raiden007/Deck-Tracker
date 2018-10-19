//
//  AddNewGame.swift
//  Deck Tracker
//
//  Created by Andrei Joghiu on 27/02/16.
//  Copyright © 2016 Andrei Joghiu. All rights reserved.
//

import XCTest

class AddNewGame: Utils {
    
    let addNewGameButton = Games().addGameButton
    
    let cancelButton = XCUIApplication().navigationBars["Add New Game"].buttons["Cancel"]
    let newGameTitle = XCUIApplication().navigationBars["Add New Game"]
    let saveButton = XCUIApplication().navigationBars["Add New Game"].buttons["Save"]
    
    let dateCell = XCUIApplication().cells.element(boundBy: 0)
    let deckCell = XCUIApplication().cells.element(boundBy: 1)
    let opponentCell = XCUIApplication().cells.element(boundBy: 2)
    let coinLabel = XCUIApplication().tables.staticTexts["Started with coin"]
    let coinSwitch = XCUIApplication().tables.switches["Started with coin"]
    let winLabel = XCUIApplication().tables.staticTexts["Did you win ?"]
    let winSwitch = XCUIApplication().tables.switches["Did you win ?"]
    let tagCell = XCUIApplication().cells.element(boundBy: 5)

    
    override func setUp() {
        super.setUp()
        app.launch()
        sleep(1.0)
        addNewGameButton.tap()
    }
    
    func elementsExists() {
        
        cancelButton.tap()
        resetAll()
        addNewGameButton.tap()
        
        XCTAssert(cancelButton.exists)
        XCTAssert(newGameTitle.exists)
        XCTAssert(saveButton.exists)
        
        let date = dateToday()
        XCTAssert(dateCell.staticTexts["Date: " + date].exists, "Date shown is not " + date)
        
        XCTAssert(deckCell.staticTexts["You need to select a deck first"].exists)
        XCTAssert(opponentCell.staticTexts["Select Opponent's Class"].exists)
        XCTAssert(coinLabel.exists)
        XCTAssert(coinSwitch.exists)
        XCTAssert(winLabel.exists)
        XCTAssert(winSwitch.exists)
        XCTAssert(tagCell.staticTexts["Add Tags"].exists)
    }
    
    func testCancelButton() {
        elementsExists()
        cancelButton.tap()
        XCTAssert(Games().gamesListScreenTitle.exists)
    }
    
    func addNewGame(_ date: String, deckName: String, deckClass: String, opponent: String, coin: Bool, win: Bool, tag: String) {
        addNewGameButton.tap()
        
        // Check to see if selected deck is the same as intended deck
        print(app.tables.staticTexts["Your deck: " + deckName])
        if app.tables.staticTexts["Your deck: " + deckName].exists {
            print(deckName + " is selected")
        } else {
            print(deckName + " is not selected")
            deckCell.tap()
            // Check to see if the selected deck appears in the deck list
            if app.tables.staticTexts[deckName].exists {
                app.tables.staticTexts[deckName].tap()
            // If not, create the deck and press it
            } else {
                Decks().addDeck(deckName, deckClass: deckClass)
                app.tables.staticTexts[deckName].tap()
            }
        }
        
        // Select opponent class
        opponentCell.tap()
        AddNewGameOpponent().selectOpponent(opponent)
        
        // Set coin status
        if coin == true {
            coinSwitch.tap()
        }
        
        // Set win status
        if win == false {
            winSwitch.tap()
        }
        
        // Set tag
        if tag == "" {
            // Do nothing
        } else {
            tagCell.tap()
            // Check to see if the tag is present
            if app.tables.staticTexts[tag].exists {
                app.tables.staticTexts[tag].tap()
            } else {
                AddNewGameTags().addNewTag(tag)
                app.tables.staticTexts[tag].tap()
            }
        }
        
        // Saves the game
        saveButton.tap()

    }
    
    func testAddNewGame() {
        cancelButton.tap()
        addNewGame("", deckName: "wiejsjs", deckClass: "Paladin",opponent: "Druid", coin: true, win: false, tag: "")
        sleep(3.0)
        
    }
    

    
}
