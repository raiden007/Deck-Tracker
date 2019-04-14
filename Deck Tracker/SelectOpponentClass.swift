//
//  SelectOpponentClass.swift
//  Deck Tracker
//
//  Created by Andrei Joghiu on 8/5/15.
//  Copyright (c) 2015 Andrei Joghiu. All rights reserved.
//

import UIKit

class SelectOpponentClass: UITableViewController {
    
    @IBOutlet var opponentClasses: UITableView!
    

    var classes = ["Warrior", "Paladin", "Shaman", "Hunter", "Druid", "Rogue", "Mage", "Warlock", "Priest"]
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Gets the number of rows to be displayed in the table
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return classes.count
    }
    
    // Populates the table with data
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "Cell")
        cell.textLabel?.text = classes[indexPath.row]
        return cell
    }


    // Selects the row and saves the info so we can add a checkmark
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        cell?.accessoryType = UITableViewCellAccessoryType.Checkmark
        let selectedClass = classes[indexPath.row]
        saveSelectedOpponentClass(selectedClass)
        readSelectedOpponentClass()
        navigationController?.popViewControllerAnimated(true)
        //navigationController?.popToRootViewControllerAnimated(true)
    }
    
    // Deselects the row if you select another
    override func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        cell?.accessoryType = UITableViewCellAccessoryType.None
    }
    
    // Saves the selected opponent class in NSUserDefaults
    func saveSelectedOpponentClass(opponentClass: String) {
        let defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(opponentClass, forKey: "Opponent Class")
        defaults.synchronize()
    }
    
    // Reads the selected deck ID from NSUserDefaults
    func readSelectedOpponentClass() -> String {
        let defaults = NSUserDefaults.standardUserDefaults()
        let name:String = defaults.stringForKey("Opponent Class") as String!
        return name
    }
}
