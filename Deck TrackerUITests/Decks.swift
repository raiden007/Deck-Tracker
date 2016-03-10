//
//  Decks.swift
//  Deck Tracker
//
//  Created by Andrei Joghiu on 29/01/16.
//  Copyright © 2016 Andrei Joghiu. All rights reserved.
//

import XCTest

public class Decks: XCTestCase {
    
    let app = XCUIApplication()
    let decksTab = XCUIApplication().tabBars.buttons["Decks"]
    
    let addDeckButton = XCUIApplication().navigationBars["Decks"].buttons["Add"]
    let deckScreenTitle = XCUIApplication().navigationBars["Decks"]
    let cancelButton = XCUIApplication().navigationBars["Add Deck"].buttons["Cancel"]
    let addNewDeckScreenTitle = XCUIApplication().navigationBars["Add Deck"]
    let saveButton = XCUIApplication().navigationBars["Add Deck"].buttons["Save"]
    let textField = XCUIApplication().textFields["Enter deck name"]
    let selectClassLabel = XCUIApplication().staticTexts["Select class:"]
    
    let warriorButton = XCUIApplication().buttons["WarriorSmall"]
    let paladinButton = XCUIApplication().buttons["PaladinSmall"]
    let shamanButton = XCUIApplication().buttons["ShamanSmall"]
    let hunterButton = XCUIApplication().buttons["HunterSmall"]
    let rogueButton = XCUIApplication().buttons["RogueSmall"]
    let druidButton = XCUIApplication().buttons["DruidSmall"]
    let mageButton = XCUIApplication().buttons["MageSmall"]
    let warlockButton = XCUIApplication().buttons["WarlockSmall"]
    let priestButton = XCUIApplication().buttons["PriestSmall"]
    
    public let warriorDeck = XCUIApplication().tables.staticTexts["Warrior"]
    public let paladinDeck = XCUIApplication().tables.staticTexts["Paladin"]
    public let shamanDeck = XCUIApplication().tables.staticTexts["Shaman"]
    public let hunterDeck = XCUIApplication().tables.staticTexts["Hunter"]
    public let rogueDeck = XCUIApplication().tables.staticTexts["Rogue"]
    public let druidDeck = XCUIApplication().tables.staticTexts["Druid"]
    public let mageDeck = XCUIApplication().tables.staticTexts["Mage"]
    public let warlockDeck = XCUIApplication().tables.staticTexts["Warlock"]
    public let priestDeck = XCUIApplication().tables.staticTexts["Priest"]
        
    override public func setUp() {
        super.setUp()
        continueAfterFailure = false
        app.launch()
        decksTab.tap()
    }
    
    func testElementsOnDecksPage() {
        XCTAssert(addDeckButton.exists, "Add New Deck button does not exist")
        XCTAssert(deckScreenTitle.exists, "Deck screen title does not exist")
    }
    
    func testElementsOnNewDeckPage() {
        addDeckButton.tap()
        XCTAssert(cancelButton.exists, "Cancel button does not exist")
        XCTAssert(addNewDeckScreenTitle.exists)
        XCTAssert(saveButton.exists)
        XCTAssert(textField.exists)
        XCTAssert(selectClassLabel.exists)
        XCTAssert(warriorButton.exists)
        XCTAssert(paladinButton.exists)
        XCTAssert(shamanButton.exists)
        XCTAssert(hunterButton.exists)
        XCTAssert(druidButton.exists)
        XCTAssert(rogueButton.exists)
        XCTAssert(mageButton.exists)
        XCTAssert(warlockButton.exists)
        XCTAssert(priestButton.exists)
    }
    
    func testAddAllDecks() {
        Settings().resetAll()
        decksTab.tap()
        
        addDeck("Control Warrior", deckClass: "Warrior")
        tapDeck("Control Warrior")
        addDeck("Secrets", deckClass: "Paladin")
        addDeck("Aggro", deckClass: "Shaman")
        addDeck("Face Hunter", deckClass: "Hunter")
        addDeck("Midrange", deckClass: "Druid")
        tapDeck("Midrange")
        addDeck("Miracle", deckClass: "Rogue")
        addDeck("Tempo", deckClass: "Mage")
        addDeck("Zoo", deckClass: "Warlock")
        addDeck("Golden Monkey", deckClass: "Priest")
    }
    
    func testCancelButton() {
        addDeckButton.tap()
        textField.tap()
        textField.typeText("Pressing cancel")
        druidButton.tap()
        cancelButton.tap()
        XCTAssert(deckScreenTitle.exists)
        XCTAssertFalse(XCUIApplication().tables.staticTexts["Pressing cancel"].exists)
    }
    
    func testDeleteDeck() {
        
        let alertTitle = app.alerts["Delete games?"].staticTexts["Delete games?"]
        let alertText = app.alerts["Delete games?"].staticTexts["Do you want also to delete all the games recorded with this deck ?"]
        let alertCancelButton = app.alerts["Delete games?"].collectionViews.buttons["Cancel"]
        let alertYesButton = app.alerts["Delete games?"].collectionViews.buttons["Cancel"]
        
        Settings().resetAll()
        decksTab.tap()
        
        let deckName = app.tables.staticTexts["Delete Deck"]
        addDeckButton.tap()
        textField.tap()
        textField.typeText("Delete Deck")
        druidButton.tap()
        saveButton.tap()
        XCTAssert(deckScreenTitle.exists)
        XCTAssert(deckName.exists)
        deckName.swipeLeft()
        app.tables.buttons["Delete"].tap()
        
        // Check alert
        XCTAssert(alertTitle.exists)
        XCTAssert(alertText.exists)
        XCTAssert(alertCancelButton.exists)
        XCTAssert(alertYesButton.exists)
        
        alertCancelButton.tap()
        
        // Check deck does not exist anymore
        XCTAssertFalse(deckName.exists)
        
    }
    
    func addDeck(deckTitle: String, deckClass: String) {
        addDeckButton.tap()
        textField.tap()
        textField.typeText(deckTitle)
        let deckButton = deckClass + "Small"
        XCUIApplication().buttons[deckButton].tap()
        saveButton.tap()
    }
    
    func tapDeck(deckTitle: String) {
        XCTAssert(deckScreenTitle.exists)
        let deckCell = XCUIApplication().tables.staticTexts[deckTitle]
        XCTAssert(deckCell.exists)
        deckCell.tap()
    }
    
    func testDeckNameAlreadyExists() {
        Settings().resetAll()
        decksTab.tap()
        
        addDeck("Midrange", deckClass: "Druid")
        addDeck("Midrange", deckClass: "Hunter")
        
        XCUIApplication().alerts["Deck already exists"].staticTexts["Deck already exists"].exists
        XCUIApplication().alerts["Deck already exists"].staticTexts["Deck name already exists"].exists
        XCUIApplication().alerts["Deck already exists"].collectionViews.buttons["OK"].exists
        XCUIApplication().alerts["Deck already exists"].collectionViews.buttons["OK"].tap()
    }
}
