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
    var selectedtags:[String] = []
    
    
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
        // Populates the screen
        let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "Cell")
        cell.textLabel?.text = allTags[indexPath.row]
        var cellLabel = cell.textLabel?.text as String!
        for var i = 0; i < selectedtags.count; i++ {
            if cellLabel == selectedtags[i] {
                cell.accessoryType = UITableViewCellAccessoryType.Checkmark
            }
        }
        return cell
    }
    
    func readData() {
        allTags = readTags()
    }
    
    @IBAction func plusButtonPressed(sender: UIBarButtonItem) {
    }
    
    func readTags() -> [String] {
        let defaults = NSUserDefaults(suiteName: "group.Decks")!
        if let allTagsTest = defaults.arrayForKey("All Tags") {
            allTags = defaults.arrayForKey("All Tags") as! [String]
        }
        return allTags
    }
    

}
