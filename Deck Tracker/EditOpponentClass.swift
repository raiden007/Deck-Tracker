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
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return classes.count
    }

    // Populates the table with the classes array
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "Cell")
        cell.textLabel?.text = classes[indexPath.row]
        return cell
    }
    
    // Selects the row and saves the info so we can add a checkmark
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.accessoryType = UITableViewCell.AccessoryType.checkmark
        let selectedClass = classes[indexPath.row]
        saveEditedOpponentClass(selectedClass)
        //readEditedOpponentClass()
        navigationController?.popViewController(animated: true)
    }
    
    // Deselects the row if you select another
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.accessoryType = UITableViewCell.AccessoryType.none
    }
    
    // Saves the edited opponent class in NSUserDefaults
    func saveEditedOpponentClass(_ opponentClass: String) {
        let defaults: UserDefaults = UserDefaults.standard
        defaults.set(opponentClass, forKey: "Edited Opponent Class")
        defaults.synchronize()
    }
    
    // Reads the selected deck ID from NSUserDefaults
    func readEditedOpponentClass() -> String {
        let defaults = UserDefaults.standard
        let name:String = defaults.string(forKey: "Edited Opponent Class")!
        return name
    }
}
