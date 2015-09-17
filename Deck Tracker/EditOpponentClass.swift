//
//  EditOpponentClass.swift
//  Deck Tracker
//
//  Created by Andrei Joghiu on 14/5/15.
//  Copyright (c) 2015 Andrei Joghiu. All rights reserved.
//

import UIKit

class EditOpponentClass: UITableViewController {

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

    // Number of rows in table view
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return classes.count
    }

    // Populates the table with the classes array
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
        saveEditedOpponentClass(selectedClass)
        //readEditedOpponentClass()
        navigationController?.popViewControllerAnimated(true)
    }
    
    // Deselects the row if you select another
    override func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        cell?.accessoryType = UITableViewCellAccessoryType.None
    }
    
    // Saves the edited opponent class in NSUserDefaults
    func saveEditedOpponentClass(opponentClass: String) {
        let defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(opponentClass, forKey: "Edited Opponent Class")
        defaults.synchronize()
    }
    
    // Reads the selected deck ID from NSUserDefaults
    func readEditedOpponentClass() -> String {
        let defaults = NSUserDefaults.standardUserDefaults()
        let name:String = defaults.stringForKey("Edited Opponent Class") as String!
        return name
    }
}
