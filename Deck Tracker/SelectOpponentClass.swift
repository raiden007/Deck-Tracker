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
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return classes.count
    }
    
    // Populates the table with data
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "Cell")
        cell.textLabel?.text = classes[indexPath.row]
        return cell
    }


    // Selects the row and saves the info so we can add a checkmark
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.accessoryType = UITableViewCellAccessoryType.checkmark
        let selectedClass = classes[indexPath.row]
        saveSelectedOpponentClass(selectedClass)
        navigationController?.popViewController(animated: true)
        //navigationController?.popToRootViewControllerAnimated(true)
    }
    
    // Deselects the row if you select another
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.accessoryType = UITableViewCellAccessoryType.none
    }
    
    // Saves the selected opponent class in NSUserDefaults
    func saveSelectedOpponentClass(_ opponentClass: String) {
        let defaults: UserDefaults = UserDefaults.standard
        defaults.set(opponentClass, forKey: "Opponent Class")
        defaults.synchronize()
    }
    
    // Reads the selected deck ID from NSUserDefaults
    func readSelectedOpponentClass() -> String {
        let defaults = UserDefaults.standard
        let name:String = defaults.string(forKey: "Opponent Class") as String!
        return name
    }
}
