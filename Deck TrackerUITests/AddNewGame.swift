//
//  AddNewGame.swift
//  Deck Tracker
//
//  Created by Andrei Joghiu on 27/02/16.
//  Copyright © 2016 Andrei Joghiu. All rights reserved.
//

import XCTest

class AddNewGame: XCTestCase {
    
    let addGameButton = XCUIApplication().navigationBars["Games List"].buttons["Add"]

    
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
        addGameButton.tap()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let app = XCUIApplication()
        let addButton = app.navigationBars["Games List"].buttons["Add"]
        addButton.tap()
        
        let addNewGameNavigationBar = app.navigationBars["Add New Game"]
        addNewGameNavigationBar.buttons["Cancel"].tap()
        addButton.tap()
        addNewGameNavigationBar.staticTexts["Add New Game"].tap()
        addNewGameNavigationBar.buttons["Save"].tap()
        app.alerts["Missing Info"].collectionViews.buttons["OK"].tap()
        app.tables.staticTexts["Date: 2/27/16"].tap()
        app.navigationBars["Select Date"].buttons["Add New Game"].tap()
        
    }
    
    //TODO: Add test elements tests here
}
