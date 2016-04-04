//
//  Graphs.swift
//  Deck Tracker
//
//  Created by Andrei Joghiu on 29/02/16.
//  Copyright © 2016 Andrei Joghiu. All rights reserved.
//

import XCTest

class GraphsTests: Utils {
    
    let graphsTab = XCUIApplication().tabBars.buttons["Graphs"]
    let graphsTitle = XCUIApplication().navigationBars["Graphs"].staticTexts["Graphs"]
    let sevenDaysButton = XCUIApplication().buttons["Last 7 Days"]
    let lastMonthButton = XCUIApplication().buttons["Last Month"]
    let allGamesButton = XCUIApplication().buttons["All Games"]
    let currentDeckButton = XCUIApplication().buttons["Current Deck"]
    let allDecksButton = XCUIApplication().buttons["All Decks"]
    let tipLabel = XCUIApplication().staticTexts["Tip: Tap a graph for more info"]
    
    let allCellTitle = XCUIApplication().collectionViews.staticTexts["vs. All"]
    let allCellImage = XCUIApplication().collectionViews.images["GenericSmall"]
    let allCellWinLabel = XCUIApplication().collectionViews
    
    let warriorTitle = XCUIApplication().collectionViews.staticTexts["vs. Warrior"]
    let warriorCellImage = XCUIApplication().collectionViews.images["WarriorSmall"]
    let warriorCellWinLabel = XCUIApplication().collectionViews
    
    let paladinCellTitle = XCUIApplication().collectionViews.staticTexts["vs. Paladin"]
    let paladinCellImage = XCUIApplication().collectionViews.images["PaladinSmall"]
    let paladinCellWinLabel = XCUIApplication().collectionViews
    
    let shamanCellTitle = XCUIApplication().collectionViews.staticTexts["vs. Shaman"]
    let shamanCellImage = XCUIApplication().collectionViews.images["ShamanSmall"]
    let shamanCellWinLabel = XCUIApplication().collectionViews
    
    let hunterCellTitle = XCUIApplication().collectionViews.staticTexts["vs. Hunter"]
    let hunterCellImage = XCUIApplication().collectionViews.images["HunterSmall"]
    let hunterCellWinLabel = XCUIApplication().collectionViews
    
    let druidCellTitle = XCUIApplication().collectionViews.staticTexts["vs. Druid"]
    let druidCellImage = XCUIApplication().collectionViews.images["DruidSmall"]
    let druidCellWinLabel = XCUIApplication().collectionViews
    
    let rogueCellTitle = XCUIApplication().collectionViews.staticTexts["vs. Rogue"]
    let rogueCellImage = XCUIApplication().collectionViews.images["RogueSmall"]
    let rogueCellWinLabel = XCUIApplication().collectionViews
    
    let mageCellTitle = XCUIApplication().collectionViews.staticTexts["vs. Mage"]
    let mageCellImage = XCUIApplication().collectionViews.images["MageSmall"]
    let mageCellWinLabel = XCUIApplication().collectionViews
    
    let warlockCellTitle = XCUIApplication().collectionViews.staticTexts["vs. Warlock"]
    let warlockCellImage = XCUIApplication().collectionViews.images["WarlockSmall"]
    let warlockCellWinLabel = XCUIApplication().collectionViews
    
    let priestCellTitle = XCUIApplication().collectionViews.staticTexts["vs. Priest"]
    let priestCellImage = XCUIApplication().collectionViews.images["PriestSmall"]
    let priestCellWinLabel = XCUIApplication().collectionViews
    
    let exists = NSPredicate(format: "exists == true")
    
    
        
    override func setUp() {
        super.setUp()
        app.launch()
        Settings().resetAll()
        sleep(1.0)
        graphsTab.tap()
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
        XCTAssert(allCellWinLabel.staticTexts["No Data"].exists)
        
        XCTAssert(warriorTitle.exists)
        XCTAssert(warriorCellImage.exists)
        XCTAssert(warriorCellWinLabel.staticTexts["No Data"].exists)
        
        XCTAssert(paladinCellTitle.exists)
        XCTAssert(paladinCellImage.exists)
        XCTAssert(paladinCellWinLabel.staticTexts["No Data"].exists)
        
        XCTAssert(shamanCellTitle.exists)
        XCTAssert(shamanCellImage.exists)
        XCTAssert(shamanCellWinLabel.staticTexts["No Data"].exists)
        
        // To pass on iPhone 4S
        if !hunterCellTitle.exists {
            warriorCellImage.swipeUp()
        }
        
        XCTAssert(hunterCellTitle.exists)
        XCTAssert(hunterCellImage.exists)
        XCTAssert(hunterCellWinLabel.staticTexts["No Data"].exists)
        
        XCTAssert(druidCellTitle.exists)
        XCTAssert(druidCellImage.exists)
        XCTAssert(druidCellWinLabel.staticTexts["No Data"].exists)
        
        // To pass on iPhone 6 / 6S
        if !rogueCellTitle.exists {
            warriorCellImage.swipeUp()
        }
        
        XCTAssert(rogueCellTitle.exists)
        XCTAssert(rogueCellImage.exists)
        XCTAssert(rogueCellWinLabel.staticTexts["No Data"].exists)
        
        XCTAssert(mageCellTitle.exists)
        XCTAssert(mageCellImage.exists)
        XCTAssert(mageCellWinLabel.staticTexts["No Data"].exists)
        
        XCTAssert(warlockCellTitle.exists)
        XCTAssert(warlockCellImage.exists)
        XCTAssert(warlockCellWinLabel.staticTexts["No Data"].exists)
        
        XCTAssert(priestCellTitle.exists)
        XCTAssert(priestCellImage.exists)
        XCTAssert(priestCellWinLabel.staticTexts["No Data"].exists)
    }
    
    func testTipLabel() {
        XCTAssert(tipLabel.exists)
        warriorCellImage.tap()
        app.navigationBars["Tags Graphs"].buttons["Graphs"].tap()
        XCTAssertFalse(tipLabel.exists)
    }
    
}
