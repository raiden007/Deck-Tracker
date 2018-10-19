//
//  Utils.swift
//  Deck Tracker
//
//  Created by Andrei Joghiu on 29/02/16.
//  Copyright © 2016 Andrei Joghiu. All rights reserved.
//

import XCTest

class Utils: XCTestCase {
    
    let app = XCUIApplication()
    
    func sleep(_ timer: Double) {
        Thread.sleep(forTimeInterval: timer)
    }
    
    func dateToday() -> String {
        // Get today's date as a String
        let now = Date()
        let formatter = DateFormatter()
        formatter.dateStyle = DateFormatter.Style.short
        let dateString = formatter.string(from: now)
        return dateString
    }
    
    func resetAll() {
        
        let resetAllButton = XCUIApplication().buttons["Reset All"]
        let resetEverything = XCUIApplication().alerts["Full reset"].collectionViews.buttons["Reset everything"]
        let backButton = XCUIApplication().navigationBars["Settings"].buttons["Games List"]
        
        app.tabBars.buttons["Stats"].tap()
        app.navigationBars["Games List"].buttons["More Info"].tap()
        resetAllButton.tap()
        resetEverything.tap()
        backButton.tap()
    }
    

    
}
