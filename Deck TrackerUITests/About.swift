//
//  About.swift
//  Deck Tracker
//
//  Created by Andrei Joghiu on 04/02/16.
//  Copyright © 2016 Andrei Joghiu. All rights reserved.
//

import XCTest

class About: XCTestCase {
    
    let backButton = XCUIApplication().navigationBars["About"].buttons["Settings"]
    let aboutTitleScreen = XCUIApplication().navigationBars["About"].staticTexts["About"]
    let hearthstoneImage = XCUIApplication().images["Hearthstone About"]
    let versionNumberLabel = XCUIApplication().staticTexts["Version: 2.1"]
    let createdByLabel = XCUIApplication().staticTexts["Created by: Andrei Joghiu"]
    let emailButton = XCUIApplication().buttons["raiden007@gmail.com"]
    let nounIconsLabel = XCUIApplication().staticTexts["Icons created by: SuperAtic LABS, Muneer A.Safiah, Harrison MacRae, Vicons Design from the Noun Project"]
    
    let settingsTitle = XCUIApplication().navigationBars["Settings"]
        
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        XCUIApplication().launch()
        let app = XCUIApplication()
        Utils().sleep(1.0)
        app.navigationBars["Games List"].buttons["More Info"].tap()
        app.tables.staticTexts["About"].tap()
    }
    
    func elementsOnScreen() {
        XCTAssert(backButton.exists)
        XCTAssert(aboutTitleScreen.exists)
        XCTAssert(hearthstoneImage.exists)
        XCTAssert(versionNumberLabel.exists)
        XCTAssert(createdByLabel.exists)
        XCTAssert(emailButton.exists)
        XCTAssert(nounIconsLabel.exists)
    }
    
    func testPressBackButton() {
        elementsOnScreen()
        backButton.tap()
        XCTAssert(settingsTitle.exists, "After pressing back from About the screen should be the Settings Screen")
    }
    
}
