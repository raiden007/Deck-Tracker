//
//  EditDate.swift
//  Deck Tracker
//
//  Created by Andrei Joghiu on 14/5/15.
//  Copyright (c) 2015 Andrei Joghiu. All rights reserved.
//

import UIKit

class EditDate: UIViewController {
    
    @IBOutlet var datePicker: UIDatePicker!
    static let sharedInstance = EditDate()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Saves edited date
    @IBAction func dateChanged(sender: UIDatePicker) {
        let newDate = datePicker.date
        print(newDate)
        dateToString(newDate)
        saveEditedDate(newDate)
        readDate()
    }
    
    // Saves to NSUserDefaults
    func saveEditedDate(date:NSDate) {
        let defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(date, forKey: "Saved Edited Date")
        defaults.synchronize()
    }
    
    // Reads the edited date
    func readDate() -> NSDate? {
        let defaults = NSUserDefaults.standardUserDefaults()
        let date:NSDate! = defaults.objectForKey("Saved Edited Date") as? NSDate
        //println("Date retrieved")
        if date != nil {
          return date
        } else {
            return nil
        }
    }
    
    // Returns the edited date to String
    func dateToString(date:NSDate) -> String {
        let formatter = NSDateFormatter()
        formatter.dateStyle = NSDateFormatterStyle.ShortStyle
        let dateString = formatter.stringFromDate(date)
        return dateString
    }
}
