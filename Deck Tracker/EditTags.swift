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
    var selectedTag:String = ""
    
    
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
        if cellLabel == selectedTag {
            cell.accessoryType = UITableViewCellAccessoryType.Checkmark
        
        }
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // Selects the row and saves the info so we can add a checkmark
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        let cellLabel = cell?.textLabel?.text as String!
        saveSelectedTag(cellLabel)
        navigationController?.popViewControllerAnimated(true)
    }
    
    func saveSelectedTag(selectedTag:String) {
        // Saves the selected tag as an array
        let defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(selectedTag, forKey: "Edited Selected Tag")
        defaults.synchronize()
    }
    
    func readSelectedTag() {
        // Reads the selected tag from NSUserDefaults
        let defaults = NSUserDefaults.standardUserDefaults()
        if let _ = defaults.stringForKey("Edited Selected Tag") {
            selectedTag = defaults.stringForKey("Edited Selected Tag") as String!
        } else {
            selectedTag = ""
        }
        print("Selected tag Tag screen: " + String(stringInterpolationSegment: selectedTag))
    }
    
    func readData() {
        allTags = readTags()
        readSelectedTag()
    }
    
    @IBAction func plusButtonPressed(sender: UIBarButtonItem) {
        //1. Create the alert controller.
        let alert = UIAlertController(title: "New Tag", message: "Enter Tag", preferredStyle: .Alert)
        
        //2. Add the text field. You can configure it however you need.
        alert.addTextFieldWithConfigurationHandler({ (textField) -> Void in
            textField.placeholder = "Tag name"
            textField.autocapitalizationType = UITextAutocapitalizationType.Sentences
        })
        
        //3. Grab the value from the text field, and adds it to the array when the user clicks OK.
        alert.addAction(UIAlertAction(title: "Finish", style: .Default, handler: { (action) -> Void in
            let textField = alert.textFields![0]
            // Check the tag is not already in the list
            var tagAlreadyExists = false
            
            for tag in self.allTags {
                if tag.lowercaseString == textField.text?.lowercaseString {
                    tagAlreadyExists = true
                }
            }
            
            if tagAlreadyExists == true {
                let alert = UIAlertView()
                alert.title = "Tag already exists"
                alert.message = "Tag already exists"
                alert.addButtonWithTitle("OK")
                alert.show()
            } else {
                self.allTags.append(textField.text!)
                //let sortedtags = sorted(self.allTags, <)
                self.allTags.sortInPlace()
                //self.allTags = sortedtags
                self.saveAllTags()
                self.readTags()
                self.tagsTable.reloadData()
            }
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
