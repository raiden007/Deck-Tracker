//
//  SelectTags.swift
//  Deck Tracker
//
//  Created by Andrei Joghiu on 26/6/15.
//  Copyright (c) 2015 Andrei Joghiu. All rights reserved.
//

import UIKit

class SelectTags: UITableViewController {
    
    @IBOutlet var tagsTable: UITableView!
    @IBOutlet var plusButton: UIBarButtonItem!

    var allTags:[String] = []
    var selectedTags:[String] = []
    var tags:[String] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        readData()
        
        
        // Removes the empty rows from view
        tagsTable.tableFooterView = UIView(frame: CGRectZero)
        
        
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
        return allTags.count
    }

    // Configures the cell
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "Cell")
        cell.textLabel?.text = allTags[indexPath.row]
        var cellLabel = cell.textLabel?.text as String!
        for var i = 0; i < selectedTags.count; i++ {
            if cellLabel == selectedTags[i] {
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
            selectedTags.append(cellLabel)
            saveSelectedTags(selectedTags)
        } else {
            cell?.accessoryType = UITableViewCellAccessoryType.None
            for var i = 0; i < selectedTags.count; i++ {
                if selectedTags[i] == cell?.textLabel?.text {
                    selectedTags.removeAtIndex(i)
                }
            }
            saveSelectedTags(selectedTags)
        }

    }
    
    // Saves the selected tags as an array
    func saveSelectedTags(selectedTags:[String]) {
        let defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(selectedTags, forKey: "Selected Tags")
        defaults.synchronize()
    }
    
    // Reads the selected tags from NSUserDefaults
    func readSelectedTags() -> [String] {
        let defaults = NSUserDefaults.standardUserDefaults()
        if let tagsTest = defaults.arrayForKey("Selected Tags") {
            tags = defaults.arrayForKey("Selected Tags") as! [String]
        }
        return tags
    }
    
    func readData() {
        allTags = readTags()
        selectedTags = readSelectedTags()
    }
    
    @IBAction func plusButtonPressed(sender: UIBarButtonItem) {
        
        //1. Create the alert controller.
        var alert = UIAlertController(title: "New Tag", message: "Enter Tag", preferredStyle: .Alert)
        
        //2. Add the text field. You can configure it however you need.
        alert.addTextFieldWithConfigurationHandler({ (textField) -> Void in
            textField.placeholder = "Tag name"
        })
        
        //3. Grab the value from the text field, and adds it to the array when the user clicks OK.
        alert.addAction(UIAlertAction(title: "Finish", style: .Default, handler: { (action) -> Void in
            let textField = alert.textFields![0] as! UITextField
            self.allTags.append(textField.text)
            self.saveAllTags()
            self.readTags()
            self.tagsTable.reloadData()
        }))
        
        // 4. Present the alert.
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    
    func saveAllTags() {
        let defaults = NSUserDefaults(suiteName: "group.Decks")!
        defaults.setObject(allTags, forKey: "All Tags")
        defaults.synchronize()
    }
    
    func readTags() -> [String]{
        let defaults = NSUserDefaults(suiteName: "group.Decks")!
        if let testAllTags = defaults.arrayForKey("All Tags") {
            allTags = defaults.arrayForKey("All Tags") as! [String]
        }
        return allTags
    }
    
    // Deletes the row
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            var index = indexPath.row
            allTags.removeAtIndex(index)
            saveAllTags()
            readData()
            self.tagsTable.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
        }
    }
    
    
}
