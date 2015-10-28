//
//  Deck_TrackerUITests.swift
//  Deck TrackerUITests
//
//  Created by Andrei Joghiu on 28/10/15.
//  Copyright © 2015 Andrei Joghiu. All rights reserved.
//

import XCTest

class Deck_TrackerUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testResetAll() {
        resetAll()
    }
    
    func resetAll() {
        
        let app = XCUIApplication()
        app.navigationBars["Games List"].buttons["More Info"].tap()
        app.tables.staticTexts["Reset all !"].tap()
        app.alerts["Full reset"].collectionViews.buttons["Reset everything"].tap()
        app.navigationBars["Settings"].buttons["Games List"].tap()
        
    }
    
    func testDecks() {
        let decks = ["Warrior", "Paladin", "Shaman", "Hunter", "Druid", "Rogue", "Mage", "Warlock", "Priest"]
        
        for deck in decks {
            addNewDeck(deck)
            selectDeck(deck)
        }
        
        
        
        
    }
    
    func addNewDeck(deckClass:String) {
        
        let app = XCUIApplication()
        app.tabBars.buttons["Decks"].tap()
        app.navigationBars["Decks"].buttons["Add"].tap()
        app.buttons[deckClass + "Small"].tap()
        
        let enterDeckNameTextField = app.textFields["Enter deck name"]
        enterDeckNameTextField.tap()
        enterDeckNameTextField.typeText(deckClass)
        app.navigationBars["Add Deck"].buttons["Save"].tap()
        XCTAssert(app.tables.staticTexts[deckClass].exists)
        
    }
    
    func selectDeck(deck:String) {
        
        var index:UInt = 0
        
        if deck == "Warrior" {
            index = 0
        } else if deck == "Paladin" {
            index = 1
        } else if deck == "Shaman" {
            index = 2
        } else if deck == "Hunter" {
            index = 3
        } else if deck == "Druid" {
            index = 4
        } else if deck == "Rogue" {
            index = 5
        } else if deck == "Mage" {
            index = 6
        } else if deck == "Warlock" {
            index = 7
        } else if deck == "Priest" {
            index = 8
        }
        
        let app = XCUIApplication()
        app.tabBars.buttons["Decks"].tap()
        app.tables.cells.elementBoundByIndex(index).tap()
        app.tables.cells.elementBoundByIndex(index)
        
        
    }
    
    func testTestssss() {
        
        let app = XCUIApplication()
        app.tabBars.buttons["Decks"].tap()
        
        let tablesQuery = app.tables

        
        let paladinStaticText = tablesQuery.cells.elementBoundByIndex(1)
        paladinStaticText.tap()
        paladinStaticText.tap()
        paladinStaticText.tap()
        paladinStaticText.tap()
        paladinStaticText.tap()
        paladinStaticText.tap()
        paladinStaticText.tap()
        
    }
    
}
