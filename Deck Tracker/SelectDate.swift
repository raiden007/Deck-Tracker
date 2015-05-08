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
        
        var newDate = datePicker.date
        println(newDate)
        dateToString(newDate)
        saveDate(newDate)
        readDate()
    }
    
    func dateToString(date:NSDate) -> String {
        let formatter = NSDateFormatter()
        formatter.dateStyle = NSDateFormatterStyle.ShortStyle
        let dateString = formatter.stringFromDate(date)
        println(dateString)
        return dateString
    }
    
    func saveDate(date:NSDate) {
        let defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(date, forKey: "Saved Date")
        defaults.synchronize()
    }
    
    func readDate() -> NSDate {
        let defaults = NSUserDefaults.standardUserDefaults()
        if let date:NSDate = defaults.objectForKey("Saved Date") as? NSDate {
            println("Date retrieved")
            return date
        }
        else {
            println("Switched to today's date.")
            return NSDate()
        }
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
