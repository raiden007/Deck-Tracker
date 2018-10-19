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
    @IBAction func dateChanged(_ sender: UIDatePicker) {
        let newDate = datePicker.date
        print(newDate)
        saveEditedDate(newDate)
    }
    
    // Saves to NSUserDefaults
    func saveEditedDate(_ date:Date) {
        let defaults: UserDefaults = UserDefaults.standard
        defaults.set(date, forKey: "Saved Edited Date")
        defaults.synchronize()
    }
    
    // Reads the edited date
    func readDate() -> Date? {
        let defaults = UserDefaults.standard
        let date:Date! = defaults.object(forKey: "Saved Edited Date") as? Date
        //println("Date retrieved")
        if date != nil {
          return date
        } else {
            return nil
        }
    }
    
    // Returns the edited date to String
    func dateToString(_ date:Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = DateFormatter.Style.short
        let dateString = formatter.string(from: date)
        return dateString
    }
}
