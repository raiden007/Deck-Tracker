//
//  AddNewGameTags.swift
//  Deck Tracker
//
//  Created by Andrei Joghiu on 05/04/16.
//  Copyright © 2016 Andrei Joghiu. All rights reserved.
//

import XCTest

class AddNewGameTags: Utils {
    
    let addNewGameButton = Games().addGameButton
    let tagCell = XCUIApplication().cells.element(boundBy: 5)
    
    let backButton = XCUIApplication().navigationBars["Add Tags"].buttons["Add New Game"]
    let selectTagTitleScreen = XCUIApplication().navigationBars["Add Tags"].staticTexts["Add Tags"]
    let addTagButton = XCUIApplication().navigationBars["Add Tags"].buttons["Add"]
    
    let alertTitle = XCUIApplication().alerts["New Tag"].staticTexts["New Tag"]
    let alertBody = XCUIApplication().alerts["New Tag"].staticTexts["Enter Tag"]
    let alertTextField = XCUIApplication().textFields["Tag name"]
    let alertFinishButton = XCUIApplication().buttons["Finish"]

    
    override func setUp() {
        super.setUp()
        XCUIApplication().launch()
        sleep(1.0)
        addNewGameButton.tap()
        tagCell.tap()
    }
    
    func testExample() {
    }
    
    func testElements() {
        XCTAssert(backButton.exists)
        XCTAssert(selectTagTitleScreen.exists)
        XCTAssert(addTagButton.exists)
        
        backButton.tap()
        XCTAssert(AddNewGame().newGameTitle.exists)
    }
    
    func testAddNewTagElements() {
        addTagButton.tap()
        XCTAssert(alertTitle.exists)
        XCTAssert(alertBody.exists)
        XCTAssert(alertTextField.exists)
        XCTAssert(alertFinishButton.exists)
    }
    
    func addNewTag(_ tagName: String) {
        addTagButton.tap()
        sleep(1.0)
        alertTextField.tap()
        sleep(1.0)
        alertTextField.typeText(tagName)
        alertFinishButton.tap()
    }
    
    func testEmptyTag() {
        
        let emptyAlertTitle = app.alerts["Tag empty"].staticTexts["Tag empty"]
        let emptyAlertBody = app.alerts["Tag empty"].staticTexts["Tag cannot be empty"]
        let emptyAlertOkButton = app.buttons["OK"]
        
        addNewTag("")
        sleep(1.0)
        XCTAssert(emptyAlertTitle.exists)
        XCTAssert(emptyAlertBody.exists)
        XCTAssert(emptyAlertOkButton.exists)
        emptyAlertOkButton.tap()
        testElements()
    }
    
    func testTagAlreadyExists() {
        
        let alreadyExistsAlertTitle = app.alerts["Tag already exists"].staticTexts["Tag already exists"]
        let alreadyExistsAlertBody = app.alerts["Tag already exists"].staticTexts["Enter another tag name"]
        let alreadyExistsAlertButton = app.buttons["OK"]
        
        backButton.tap()
        AddNewGame().cancelButton.tap()
        Settings().resetAll()
        addNewGameButton.tap()
        tagCell.tap()
        
        addNewTag("Tag already exists")
        sleep(1.0)
        addNewTag("Tag already exists")
        
        XCTAssert(alreadyExistsAlertTitle.exists)
        XCTAssert(alreadyExistsAlertBody.exists)
        XCTAssert(alreadyExistsAlertButton.exists)
        alreadyExistsAlertButton.tap()
        testElements()
    }
    
}
