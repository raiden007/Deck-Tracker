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
    
    let dateCell = XCUIApplication().cells.elementBoundByIndex(0)
    let deckCell = XCUIApplication().cells.elementBoundByIndex(1)
    let opponentCell = XCUIApplication().cells.elementBoundByIndex(2)
    let coinLabel = XCUIApplication().tables.staticTexts["Started with coin"]
    let coinSwitch = XCUIApplication().tables.switches["Started with coin"]
    let winLabel = XCUIApplication().tables.staticTexts["Did you win ?"]
    let winSwitch = XCUIApplication().tables.switches["Did you win ?"]
    let tagCell = XCUIApplication().cells.elementBoundByIndex(5)

    
    override func setUp() {
        super.setUp()
        app.launch()
        sleep(1.0)
        //resetAll()
        addNewGameButton.tap()
    }
    
    func elementsExists() {
        
        resetAll()
        
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
    
    func addNewGame(date: String, deck: String, opponent: String, coin: Bool, Win: Bool, tag: String) {
        // Check to see if selected deck is the same as intended deck
        print(app.tables.staticTexts["Your deck: " + deck])
        if app.tables.staticTexts["Your deck: " + deck].exists {
            print(deck + " is selected")
        } else {
            print(deck + " is not selected")
        }
    }
    
    func testAddNewGame() {
        addNewGame("", deck: "Testing", opponent: "", coin: true, Win: false, tag: "")
        sleep(30.0)
        
    }
    

    
}
