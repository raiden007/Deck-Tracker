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
    
    @IBAction func dateChanged(sender: UIDatePicker) {
        var newDate = datePicker.date
        dateToString(newDate)
        saveEditedDate(newDate)
        readDate()
    }
    
    func saveEditedDate(date:NSDate) {
        let defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(date, forKey: "Saved Edited Date")
        defaults.synchronize()
    }
    
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
    
    func dateToString(date:NSDate) -> String {
        let formatter = NSDateFormatter()
        formatter.dateStyle = NSDateFormatterStyle.ShortStyle
        let dateString = formatter.stringFromDate(date)
        return dateString
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
