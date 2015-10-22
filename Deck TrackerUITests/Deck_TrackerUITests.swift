//
//  Deck_TrackerUITests.swift
//  Deck TrackerUITests
//
//  Created by Andrei Joghiu on 22/10/15.
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
        ResetEverything()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
        
    func ResetEverything() {
        
        let app = XCUIApplication()
        app.navigationBars["Games List"].buttons["More Info"].tap()
        app.tables.staticTexts["Reset all !"].tap()
        app.alerts["Full reset"].collectionViews.buttons["Reset everything"].tap()
        XCUIApplication().navigationBars["Settings"].buttons["Games List"].tap()
        
    }
    
    func testAddAllDecks() {
        let app = XCUIApplication()
        app.tabBars.buttons["Decks"].tap()
        AddWarriorDeck()
        SelectWarriorDeck()
        AddPaladinDeck()
        SelectPaladinDeck()
    }
    
    func AddWarriorDeck() {
        XCUIDevice.sharedDevice().orientation = .Portrait
        
        let app = XCUIApplication()
        app.tabBars.buttons["Decks"].tap()
        app.navigationBars["Decks"].buttons["Add"].tap()
        app.buttons["WarriorSmall"].tap()
        
        let enterDeckNameTextField = app.textFields["Enter deck name"]
        enterDeckNameTextField.tap()
        enterDeckNameTextField.typeText("Warrior")
        app.navigationBars["Add Deck"].buttons["Save"].tap()
        XCTAssert(app.tables.childrenMatchingType(.Cell).staticTexts["Warrior"].exists)
    }
    
    func SelectWarriorDeck() {
        XCUIDevice.sharedDevice().orientation = .Portrait
        let app = XCUIApplication()
        if app.tables.childrenMatchingType(.Cell).staticTexts["Warrior"].exists {
            let app = XCUIApplication()
            app.tabBars.buttons["Decks"].tap()
            app.tables.staticTexts["Warrior"].tap()
        }

    }
    
    func AddPaladinDeck() {
        let app = XCUIApplication()
        app.tabBars.buttons["Decks"].tap()
        app.navigationBars["Decks"].buttons["Add"].tap()
        app.buttons["PaladinSmall"].tap()
        
        let enterDeckNameTextField = app.textFields["Enter deck name"]
        enterDeckNameTextField.tap()
        enterDeckNameTextField.typeText("Paladin")
        app.navigationBars["Add Deck"].buttons["Save"].tap()
        XCTAssert(app.tables.childrenMatchingType(.Cell).staticTexts["Paladin"].exists)
    }
    
    func SelectPaladinDeck() {
        let app = XCUIApplication()
        if app.tables.childrenMatchingType(.Cell).staticTexts["Paladin"].exists {
            app.tabBars.buttons["Decks"].tap()
            app.tables.staticTexts["Paladin"].tap()
        }

    }
    
    func AddShamanDeck() {
        
    }
}
