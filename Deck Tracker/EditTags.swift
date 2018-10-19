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
    // Save to iCloud
    var iCloudKeyStore: NSUbiquitousKeyValueStore = NSUbiquitousKeyValueStore()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        readData()
        // Removes the empty rows from view
        tagsTable.tableFooterView = UIView(frame: CGRect.zero)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        return allTags.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Configures the cells
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "Cell")
        cell.textLabel?.text = allTags[indexPath.row]
        let cellLabel = cell.textLabel?.text
        if cellLabel == selectedTag {
            cell.accessoryType = UITableViewCell.AccessoryType.checkmark
        
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Selects the row and saves the info so we can add a checkmark
        let cell = tableView.cellForRow(at: indexPath)
        let cellLabel = cell?.textLabel?.text
        saveSelectedTag(cellLabel!)
        navigationController?.popViewController(animated: true)
    }
    
    func saveSelectedTag(_ selectedTag:String) {
        // Saves the selected tag as an array
        let defaults: UserDefaults = UserDefaults.standard
        defaults.set(selectedTag, forKey: "Edited Selected Tag")
        defaults.synchronize()
    }
    
    func readSelectedTag() {
        // Reads the selected tag from NSUserDefaults
        let defaults = UserDefaults.standard
        if let _ = defaults.string(forKey: "Edited Selected Tag") {
            selectedTag = defaults.string(forKey: "Edited Selected Tag")!
        } else {
            selectedTag = ""
        }
        print("Selected tag Tag screen: " + String(stringInterpolationSegment: selectedTag))
    }
    
    func readData() {
        allTags = readTags()
        readSelectedTag()
    }
    
    @IBAction func plusButtonPressed(_ sender: UIBarButtonItem) {
        //1. Create the alert controller.
        let alert = UIAlertController(title: "New Tag", message: "Enter Tag", preferredStyle: .alert)
        
        //2. Add the text field. You can configure it however you need.
        alert.addTextField(configurationHandler: { (textField) -> Void in
            textField.placeholder = "Tag name"
            textField.autocapitalizationType = UITextAutocapitalizationType.sentences
        })
        
        //3. Grab the value from the text field, and adds it to the array when the user clicks OK.
        alert.addAction(UIAlertAction(title: "Finish", style: .default, handler: { (action) -> Void in
            let textField = alert.textFields![0]
            // Check the tag is not already in the list
            var tagAlreadyExists = false
            
            for tag in self.allTags {
                if tag.lowercased() == textField.text?.lowercased() {
                    tagAlreadyExists = true
                }
            }
            
            if tagAlreadyExists == true {
                let alert = UIAlertView()
                alert.title = "Tag already exists"
                alert.message = "Enter another tag name"
                alert.addButton(withTitle: "OK")
                alert.show()
            } else if textField.isEqual("") {
                let alert = UIAlertView()
                alert.title = "Tag empty"
                alert.message = "Tag cannot be empty"
                alert.addButton(withTitle: "OK")
                alert.show()
            } else {
                self.allTags.append(textField.text!)
                //let sortedtags = sorted(self.allTags, <)
                self.allTags.sort()
                //self.allTags = sortedtags
                self.saveAllTags()
                self.tagsTable.reloadData()
            }
        }))
        
        // 4. Present the alert.
        self.present(alert, animated: true, completion: nil)
    }
    
    func saveAllTags() {
        let defaults = UserDefaults(suiteName: "group.Decks")!
        defaults.set(allTags, forKey: "All Tags")
        defaults.synchronize()
        
        // Save to iCloud
        iCloudKeyStore.set(allTags, forKey: "iCloud All Tags")
        iCloudKeyStore.synchronize()
    }
    
    func readTags() -> [String] {
        let defaults = UserDefaults(suiteName: "group.Decks")!
        if let _ = iCloudKeyStore.array(forKey: "iCloud All Tags") {
            allTags = iCloudKeyStore.array(forKey: "iCloud All Tags") as! [String]
        } else if let _ = defaults.array(forKey: "All Tags") {
            allTags = defaults.array(forKey: "All Tags") as! [String]
        }
        return allTags
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        // Deletes the row
        if editingStyle == UITableViewCell.EditingStyle.delete {
            let index = indexPath.row
            allTags.remove(at: index)
            saveAllTags()
            readData()
            self.tagsTable.deleteRows(at: [indexPath], with: UITableView.RowAnimation.fade)
        }
    }
    

}
