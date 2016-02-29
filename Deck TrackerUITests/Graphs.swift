//
//  Graphs.swift
//  Deck Tracker
//
//  Created by Andrei Joghiu on 29/02/16.
//  Copyright © 2016 Andrei Joghiu. All rights reserved.
//

import XCTest

class Graphs: XCTestCase {
    
    let graphsTab = XCUIApplication().tabBars.buttons["Graphs"]
    let graphsTitle = XCUIApplication().navigationBars["Graphs"].staticTexts["Graphs"]
    let sevenDaysButton = XCUIApplication().buttons["Last 7 Days"]
    let lastMonthButton = XCUIApplication().buttons["Last Month"]
    let allGamesButton = XCUIApplication().buttons["All Games"]
    let currentDeckButton = XCUIApplication().buttons["Current Deck"]
    let allDecksButton = XCUIApplication().buttons["All Decks"]
    
    let allCellTitle = XCUIApplication().collectionViews.staticTexts["vs. All"]
    let allCellImage = XCUIApplication().collectionViews.images["GenericSmall"]
    let allCellWin = XCUIApplication().collectionViews
    
    
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
        graphsTab.tap()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // Use recording to get started writing UI tests.
        
//        let app = app2
//
        
        let app = XCUIApplication()
        app.tabBars.buttons["Graphs"].tap()
        app.collectionViews.images["GenericSmall"].tap()
        
    }
    
    func testElements() {
        XCTAssert(graphsTitle.exists)
        XCTAssert(sevenDaysButton.exists)
        XCTAssert(lastMonthButton.exists)
        XCTAssert(allGamesButton.exists)
        XCTAssert(currentDeckButton.exists)
        XCTAssert(allDecksButton.exists)
        
        XCTAssert(allCellTitle.exists)
        XCTAssert(allCellImage.exists)
    }
    
}
