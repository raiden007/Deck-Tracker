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
    var selectedTag:String = ""
    // Save to iCloud
    var iCloudKeyStore: NSUbiquitousKeyValueStore = NSUbiquitousKeyValueStore()

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
        defaults.setObject(selectedTag, forKey: "Selected Tag")
        defaults.synchronize()
        
        // Saves to iCloud
        iCloudKeyStore.setObject(selectedTag, forKey: "iCloud selected tag")
        iCloudKeyStore.synchronize()
    }
    
    
    func readSelectedTag() -> String {
        
        let defaults = NSUserDefaults.standardUserDefaults()
        
        // Reads from iCloud or local storage
        if let _ = iCloudKeyStore.arrayForKey("iCloud selected tag") {
            selectedTag = iCloudKeyStore.stringForKey("iCloud selected tag") as String!
        } else if let _ = defaults.arrayForKey("Selected Tag") {
            selectedTag = defaults.stringForKey("Selected Tag") as String!
        }
        return selectedTag
    }
    
    func readData() {
        allTags = readTags()
        selectedTag = readSelectedTag()
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
            let textField = alert.textFields![0].text
            // Check the tag is not already in the list
            var tagAlreadyExists = false
            
            for tag in self.allTags {
                if tag.lowercaseString == textField?.lowercaseString {
                    tagAlreadyExists = true
                }
            }
            
            if tagAlreadyExists == true {
                let alert = UIAlertView()
                alert.title = "Tag already exists"
                alert.message = "Enter another tag name"
                alert.addButtonWithTitle("OK")
                alert.show()
            } else if textField == "" {
                let alert = UIAlertView()
                alert.title = "Tag empty"
                alert.message = "Tag cannot be empty"
                alert.addButtonWithTitle("OK")
                alert.show()
            } else {
                self.allTags.append(textField!)
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
        
        // Save to iCloud
        iCloudKeyStore.setObject(allTags, forKey: "iCloud All Tags")
        iCloudKeyStore.synchronize()
    }
    
    func readTags() -> [String]{
        let defaults = NSUserDefaults(suiteName: "group.Decks")!
        if let _ = iCloudKeyStore.arrayForKey("iCloud All Tags") {
            allTags = iCloudKeyStore.arrayForKey("iCloud All Tags") as! [String]
        } else if let _ = defaults.arrayForKey("All Tags") {
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
