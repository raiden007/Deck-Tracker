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
        addWarriorDeck()
        addPaladinDeck()
        addShamanDeck()
        addHunterDeck()
        addDruidDeck()
        addRogueDeck()
        addMageDeck()
        addWarlockDeck()
        addPriestDeck()
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
        let deckName = XCUIApplication().tables.staticTexts["Delete Deck"]
        addDeckButton.tap()
        textField.tap()
        textField.typeText("Delete Deck")
        druidButton.tap()
        saveButton.tap()
        XCTAssert(deckScreenTitle.exists)
        XCTAssert(deckName.exists)
        deckName.swipeLeft()
        XCUIApplication().tables.buttons["Delete"].tap()
        XCTAssertFalse(deckName.exists)
    }
    
    func addWarriorDeck() {
        addDeckButton.tap()
        textField.tap()
        textField.typeText("Warrior")
        warriorButton.tap()
        saveButton.tap()
        XCTAssert(deckScreenTitle.exists)
        XCTAssert(warriorDeck.exists)
        warriorDeck.tap()
    }
    
    func addPaladinDeck() {
        addDeckButton.tap()
        textField.tap()
        textField.typeText("Paladin")
        paladinButton.tap()
        saveButton.tap()
        XCTAssert(deckScreenTitle.exists)
        XCTAssert(paladinDeck.exists)
        paladinDeck.tap()
    }
    
    func addShamanDeck() {
        addDeckButton.tap()
        textField.tap()
        textField.typeText("Shaman")
        shamanButton.tap()
        saveButton.tap()
        XCTAssert(deckScreenTitle.exists)
        XCTAssert(shamanDeck.exists)
        shamanDeck.tap()
    }
    
    func addHunterDeck() {
        addDeckButton.tap()
        textField.tap()
        textField.typeText("Hunter")
        hunterButton.tap()
        saveButton.tap()
        XCTAssert(deckScreenTitle.exists)
        XCTAssert(hunterDeck.exists)
        hunterDeck.tap()
    }
    
    func addDruidDeck() {
        addDeckButton.tap()
        textField.tap()
        textField.typeText("Druid")
        druidButton.tap()
        saveButton.tap()
        XCTAssert(deckScreenTitle.exists)
        XCTAssert(druidDeck.exists)
        druidDeck.tap()
    }
    
    func addRogueDeck() {
        addDeckButton.tap()
        textField.tap()
        textField.typeText("Rogue")
        rogueButton.tap()
        saveButton.tap()
        XCTAssert(deckScreenTitle.exists)
        XCTAssert(rogueDeck.exists)
        rogueDeck.tap()
    }
    
    func addMageDeck() {
        addDeckButton.tap()
        textField.tap()
        textField.typeText("Mage")
        mageButton.tap()
        saveButton.tap()
        XCTAssert(deckScreenTitle.exists)
        XCTAssert(mageDeck.exists)
        mageDeck.tap()
    }
    
    func addWarlockDeck() {
        addDeckButton.tap()
        textField.tap()
        textField.typeText("Warlock")
        warlockButton.tap()
        saveButton.tap()
        XCTAssert(deckScreenTitle.exists)
        XCTAssert(warlockDeck.exists)
        warlockDeck.tap()
    }
    
    func addPriestDeck() {
        addDeckButton.tap()
        textField.tap()
        textField.typeText("Priest")
        priestButton.tap()
        saveButton.tap()
        XCTAssert(deckScreenTitle.exists)
        XCTAssert(priestDeck.exists)
        priestDeck.tap()
    }
    
    func sleep() {
        NSThread.sleepForTimeInterval(10)
    }
    
    
}
