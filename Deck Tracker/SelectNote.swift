//
//  SelectNote.swift
//  Deck Tracker
//
//  Created by Andrei Joghiu on 26/6/15.
//  Copyright (c) 2015 Andrei Joghiu. All rights reserved.
//

import UIKit

class SelectNote: UITableViewController {
    
    @IBOutlet var notesTable: UITableView!

    var notesArray:[String] = ["Zoo", "Whatever", "Blabla"]
    var selectedNotesArray:[String] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()

        readData()
        readSelectedNotes()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source


    // Gets the number of rows to be displayed in the table
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return notesArray.count
    }

    // Configures the cell
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "Cell")
        cell.textLabel?.text = notesArray[indexPath.row]
        var cellLabel = cell.textLabel?.text as String!
        for var i = 0; i < selectedNotesArray.count; i++ {
            if cellLabel == selectedNotesArray[i] {
                cell.accessoryType = UITableViewCellAccessoryType.Checkmark
            }
        }
        return cell
    }
    
    
    // Selects the row and saves the info so we can add a checkmark
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        if cell?.accessoryType == UITableViewCellAccessoryType.None {
            cell?.accessoryType = UITableViewCellAccessoryType.Checkmark
            var cellLabel = cell?.textLabel?.text as String!
            selectedNotesArray.append(cellLabel)
            saveSelectedNotes(selectedNotesArray)
            println(readSelectedNotes())
        } else {
            cell?.accessoryType = UITableViewCellAccessoryType.None
            for var i = 0; i < selectedNotesArray.count; i++ {
                if selectedNotesArray[i] == cell?.textLabel?.text {
                    selectedNotesArray.removeAtIndex(i)
                }
            }
            saveSelectedNotes(selectedNotesArray)
            println(readSelectedNotes())
        }

    }
    
    // Saves the selected notes as an array
    func saveSelectedNotes(selectedNotes:[String]) {
        let defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(selectedNotes, forKey: "Selected Notes")
        defaults.synchronize()
    }
    
    // Reads the selected notes from NSUserDefaults
    func readSelectedNotes() -> [String] {
        let defaults = NSUserDefaults.standardUserDefaults()
        let notes:[String] = defaults.arrayForKey("Selected Notes") as! [String]!
        return notes
    }
    
    func readData() {
        selectedNotesArray = readSelectedNotes()
    }
    
}
