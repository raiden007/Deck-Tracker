//
//  AddNewGameOpponent.swift
//  Deck Tracker
//
//  Created by Andrei Joghiu on 04/04/16.
//  Copyright © 2016 Andrei Joghiu. All rights reserved.
//

import XCTest

class AddNewGameOpponent: Utils {
    
    let addNewGameButton = Games().addGameButton
    let pickOpponentCell = XCUIApplication().cells.elementBoundByIndex(2)
    
    let backButton = XCUIApplication().navigationBars["Select Opponent Class"].buttons["Add New Game"]
    let selectDeckTitleScreen = XCUIApplication().navigationBars["Select Opponent Class"].staticTexts["Select Opponent Class"]
    
    let warriorCell = XCUIApplication().tables.staticTexts["Warrior"]
    let paladinCell = XCUIApplication().tables.staticTexts["Paladin"]
    let shamanCell = XCUIApplication().tables.staticTexts["Shaman"]
    let hunterCell = XCUIApplication().tables.staticTexts["Hunter"]
    let druidCell = XCUIApplication().tables.staticTexts["Druid"]
    let rogueCell = XCUIApplication().tables.staticTexts["Rogue"]
    let mageCell = XCUIApplication().tables.staticTexts["Mage"]
    let warlockCell = XCUIApplication().tables.staticTexts["Warlock"]
    let priestCell = XCUIApplication().tables.staticTexts["Priest"]
    
    override func setUp() {
        super.setUp()
        app.launch()
        sleep(1.0)
        addNewGameButton.tap()
        pickOpponentCell.tap()
    }
    
    func testElements() {
        XCTAssert(backButton.exists)
        XCTAssert(selectDeckTitleScreen.exists)
        XCTAssert(warriorCell.exists)
        XCTAssert(paladinCell.exists)
        XCTAssert(shamanCell.exists)
        XCTAssert(hunterCell.exists)
        XCTAssert(druidCell.exists)
        XCTAssert(rogueCell.exists)
        XCTAssert(mageCell.exists)
        XCTAssert(warlockCell.exists)
        XCTAssert(priestCell.exists)
        backButton.tap()
        XCTAssert(AddNewGame().newGameTitle.exists)
    }
    
    func selectOpponent(opponent: String) {
        if opponent == "Warrior" {
            warriorCell.tap()
        } else if opponent == "Paladin" {
            paladinCell.tap()
        } else if opponent == "Shaman" {
            shamanCell.tap()
        } else if opponent == "Hunter" {
            hunterCell.tap()
        } else if opponent == "Druid" {
            druidCell.tap()
        } else if opponent == "Rogue" {
            rogueCell.tap()
        } else if opponent == "Mage" {
            mageCell.tap()
        } else if opponent == "Warlock" {
            warlockCell.tap()
        } else if opponent == "Priest" {
            priestCell.tap()
        } else {
            XCTAssert(false, "Opponent Class is wrong")
        }
    }
}
