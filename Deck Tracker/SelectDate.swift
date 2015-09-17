//
//  SelectDate.swift
//  Deck Tracker
//
//  Created by Andrei Joghiu on 8/5/15.
//  Copyright (c) 2015 Andrei Joghiu. All rights reserved.
//

import UIKit

class SelectDate: UIViewController {
    
    @IBOutlet var datePicker: UIDatePicker!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func datePickerChanged(sender: UIDatePicker) {
        
        let newDate = datePicker.date
        dateToString(newDate)
        saveDate(newDate)
        readDate()
    }
    
    // Returns the date as String
    func dateToString(date:NSDate) -> String {
        let formatter = NSDateFormatter()
        formatter.dateStyle = NSDateFormatterStyle.ShortStyle
        let dateString = formatter.stringFromDate(date)
        return dateString
    }
    
    // Saves the selected date in NSUserDefaults
    func saveDate(date:NSDate) {
        let defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(date, forKey: "Saved Date")
        defaults.synchronize()
    }
    
    // Reads the saved date
    func readDate() -> NSDate {
        let defaults = NSUserDefaults.standardUserDefaults()
        if let date:NSDate = defaults.objectForKey("Saved Date") as? NSDate {
            //println("Date retrieved")
            return date
        }
        else {
            //println("Switched to today's date.")
            return NSDate()
        }
    }
}
