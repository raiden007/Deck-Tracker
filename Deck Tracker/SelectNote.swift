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
    @IBOutlet var plusButton: UIBarButtonItem!

    var notesArray:[String] = ["Zoo", "Whatever", "Blabla"]
    var selectedNotesArray:[String] = []
    var notes:[String] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        readData()
        readSelectedNotes()
        // Removes the empty rows from view
        notesTable.tableFooterView = UIView(frame: CGRectZero)
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
        if let notesTest = defaults.arrayForKey("Selected Notes") {
            notes = defaults.arrayForKey("Selected Notes") as! [String]
        }
        return notes
    }
    
    func readData() {
        selectedNotesArray = readSelectedNotes()
    }
    
    @IBAction func plusButtonPressed(sender: UIBarButtonItem) {
        
        //1. Create the alert controller.
        var alert = UIAlertController(title: "New Tag", message: "Enter Tag", preferredStyle: .Alert)
        
        //2. Add the text field. You can configure it however you need.
        alert.addTextFieldWithConfigurationHandler({ (textField) -> Void in
            textField.placeholder = "Tag name"
        })
        
        //3. Grab the value from the text field, and print it when the user clicks OK.
        alert.addAction(UIAlertAction(title: "Finish", style: .Default, handler: { (action) -> Void in
            let textField = alert.textFields![0] as! UITextField
            println("Text field: \(textField.text)")
        }))
        
        // 4. Present the alert.
        self.presentViewController(alert, animated: true, completion: nil)
        
        // 5. Add it in the array
        
    }
    
    
}
