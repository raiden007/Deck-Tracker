//
//  EditGame.swift
//  Deck Tracker
//
//  Created by Andrei Joghiu on 06/05/16.
//  Copyright © 2016 Andrei Joghiu. All rights reserved.
//

import XCTest

class EditGame: Utils {
    
    let editedGame = XCUIApplication().cells.elementBoundByIndex(0)
    
    let cancelButton = XCUIApplication().navigationBars["Edit Game"].buttons["Cancel"]
    let editGameTitle = XCUIApplication().navigationBars["Edit Game"]
    let saveButton = XCUIApplication().navigationBars["Edit Game"].buttons["Save"]
    
    let dateCell = XCUIApplication().cells.elementBoundByIndex(0)
    let deckCell = XCUIApplication().cells.elementBoundByIndex(1)
    let opponentCell = XCUIApplication().cells.elementBoundByIndex(2)
    let coinLabel = XCUIApplication().tables.staticTexts["Started with coin"]
    let coinSwitch = XCUIApplication().tables.switches["Started with coin"]
    let winLabel = XCUIApplication().tables.staticTexts["Did you win ?"]
    let winSwitch = XCUIApplication().tables.switches["Did you win ?"]
    let tagCell = XCUIApplication().cells.elementBoundByIndex(5)
    
    let deckName = "Edit Game"
    let opponentClass = "Hunter"
    let tagName = "Edit Tag"
    
    override func setUp() {
        super.setUp()
        app.launch()
        sleep(1.0)
        resetAll()
        AddNewGame().addNewGame("", deckName: deckName, deckClass: "Warrior", opponent: opponentClass, coin: false, win: true, tag: tagName)
        editedGame.tap()
        sleep(1.0)
    }
    
    func testCancelButton() {
        elementsExists()
        cancelButton.tap()
        XCTAssert(Games().gamesListScreenTitle.exists)
    }
    
    func elementsExists() {
        
        XCTAssert(cancelButton.exists)
        XCTAssert(editGameTitle.exists)
        XCTAssert(saveButton.exists)
        
        let date = dateToday()
        XCTAssert(dateCell.staticTexts["Date: " + date].exists, "Date shown is not " + date)
        
        XCTAssert(deckCell.staticTexts["Your deck: " + deckName].exists)
        XCTAssert(opponentCell.staticTexts["Opponent's Class: " + opponentClass].exists)
        XCTAssert(coinLabel.exists)
        XCTAssert(coinSwitch.exists)
        XCTAssert(winLabel.exists)
        XCTAssert(winSwitch.exists)
        XCTAssert(tagCell.staticTexts["Tag: " + tagName].exists)
    }
    
    
    
}
