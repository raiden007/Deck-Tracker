//
//  EditTags.swift
//  Deck Tracker
//
//  Created by Andrei Joghiu on 29/6/15.
//  Copyright (c) 2015 Andrei Joghiu. All rights reserved.
//

import UIKit

class EditTags: UITableViewController {
    
    @IBOutlet var tagsTable: UITableView!
    @IBOutlet var plusButton: UIBarButtonItem!
    

    var allTags:[String] = []
    var selectedTags:[String] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        readData()
        // Removes the empty rows from view
        tagsTable.tableFooterView = UIView(frame: CGRectZero)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        return allTags.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // Configures the cells
        let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "Cell")
        cell.textLabel?.text = allTags[indexPath.row]
        let cellLabel = cell.textLabel?.text as String!
        for var i = 0; i < selectedTags.count; i++ {
            if cellLabel == selectedTags[i] {
                cell.accessoryType = UITableViewCellAccessoryType.Checkmark
            }
        }
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // Selects the row and saves the info so we can add a checkmark
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        if cell?.accessoryType == UITableViewCellAccessoryType.None {
            cell?.accessoryType = UITableViewCellAccessoryType.Checkmark
            let cellLabel = cell?.textLabel?.text as String!
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
    
    func saveSelectedTags(selectedTags:[String]) {
        // Saves the selected tags as an array
        let defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(selectedTags, forKey: "Edited Selected Tags")
        defaults.synchronize()
    }
    
    func readSelectedTags() {
        // Reads the selected tags from NSUserDefaults
        let defaults = NSUserDefaults.standardUserDefaults()
        if let _ = defaults.arrayForKey("Edited Selected Tags") {
            selectedTags = defaults.arrayForKey("Edited Selected Tags") as! [String]
        } else {
            selectedTags = []
        }
        print("Selected tags Tags screen: " + String(stringInterpolationSegment: selectedTags))
    }
    
    func readData() {
        allTags = readTags()
        readSelectedTags()
    }
    
    @IBAction func plusButtonPressed(sender: UIBarButtonItem) {
        //1. Create the alert controller.
        let alert = UIAlertController(title: "New Tag", message: "Enter Tag", preferredStyle: .Alert)
        
        //2. Add the text field. You can configure it however you need.
        alert.addTextFieldWithConfigurationHandler({ (textField) -> Void in
            textField.placeholder = "Tag name"
        })
        
        //3. Grab the value from the text field, and adds it to the array when the user clicks OK.
        alert.addAction(UIAlertAction(title: "Finish", style: .Default, handler: { (action) -> Void in
            let textField = alert.textFields![0] 
            self.allTags.append(textField.text!)
            self.allTags.sortInPlace()
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
    
    func readTags() -> [String] {
        let defaults = NSUserDefaults(suiteName: "group.Decks")!
        if let _ = defaults.arrayForKey("All Tags") {
            allTags = defaults.arrayForKey("All Tags") as! [String]
        }
        return allTags
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        // Deletes the row
        if editingStyle == UITableViewCellEditingStyle.Delete {
            let index = indexPath.row
            allTags.removeAtIndex(index)
            saveAllTags()
            readData()
            self.tagsTable.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
        }
    }
    

}
