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
    
    func sleep(timer: Double) {
        NSThread.sleepForTimeInterval(timer)
    }
    
    func dateToday() -> String {
        // Get today's date as a String
        let now = NSDate()
        let formatter = NSDateFormatter()
        formatter.dateStyle = NSDateFormatterStyle.ShortStyle
        let dateString = formatter.stringFromDate(now)
        return dateString
    }
    

    
}
