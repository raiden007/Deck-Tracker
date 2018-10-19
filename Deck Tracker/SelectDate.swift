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
    
    @IBAction func datePickerChanged(_ sender: UIDatePicker) {
        let newDate = datePicker.date
        saveDate(newDate)
    }
    
    // Returns the date as String
    func dateToString(_ date:Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = DateFormatter.Style.short
        let dateString = formatter.string(from: date)
        return dateString
    }
    
    // Saves the selected date in NSUserDefaults
    func saveDate(_ date:Date) {
        let defaults: UserDefaults = UserDefaults.standard
        defaults.set(date, forKey: "Saved Date")
        defaults.synchronize()
    }
    
    // Reads the saved date
    func readDate() -> Date {
        let defaults = UserDefaults.standard
        if let date:Date = defaults.object(forKey: "Saved Date") as? Date {
            //println("Date retrieved")
            return date
        }
        else {
            //println("Switched to today's date.")
            return Date()
        }
    }
}
