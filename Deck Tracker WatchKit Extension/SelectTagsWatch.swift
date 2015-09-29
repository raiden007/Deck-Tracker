//
//  SelectTagsWatch.swift
//  Deck Tracker
//
//  Created by Andrei Joghiu on 22/08/15.
//  Copyright (c) 2015 Andrei Joghiu. All rights reserved.
//

import WatchKit
import Foundation


class SelectTagsWatch: WKInterfaceController {

    @IBOutlet weak var tagsTable: WKInterfaceTable!
    @IBOutlet weak var noTagsLabel: WKInterfaceLabel!
    var tagsList:[String] = []
    var selectedTagsArray:[String] = []
    var wasAlreadySelected = false
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        noTagsLabel.setHidden(true)
        loadData()
        reloadTable()
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    
    func loadData() {
        // Loads all saved tags and then the already selected by user
        let defaults = NSUserDefaults(suiteName: "group.Decks")!
        if let testTags: AnyObject = defaults.objectForKey("All Tags") {
            tagsList = testTags as! [String]
        }
        
        if let testSelectedTags: AnyObject = NSUserDefaults.standardUserDefaults().objectForKey("Selected Tags Watch") {
            selectedTagsArray = testSelectedTags as! [String]
        }
        //println(tagsList)
        //println("Selected tags: " + String(stringInterpolationSegment: selectedTagsArray))
    }
    
    
    func reloadTable() {
        // Populates the table
        tagsTable.setNumberOfRows(tagsList.count, withRowType: "TagRow")
        if tagsList.count == 0 {
            noTagsLabel.setHidden(false)
        } else {
            // Sets the labels text
            for var i = 0; i < tagsList.count; i++ {
                if let row = tagsTable.rowControllerAtIndex(i) as? TagsRow {
                    row.tagLabel.setText(tagsList[i])
                }
                // Set background color to the selected tags
                for var j = 0; j < selectedTagsArray.count; j++ {
                    if tagsList[i] == selectedTagsArray[j] {
                        if let row = tagsTable.rowControllerAtIndex(i) as? TagsRow {
                            row.groupTable.setBackgroundColor(UIColor.greenColor())
                            row.tagLabel.setTextColor(UIColor.blackColor())
                        }
                    }
                }
            }
        }
    }
    
    
    override func table(table: WKInterfaceTable, didSelectRowAtIndex rowIndex: Int) {
        // Saves the selected tag and colors the row
        let row = table.rowControllerAtIndex(rowIndex) as? TagsRow
        
        wasAlreadySelected = false
        
        // Check to see if the button user pressed was selected already or not
        let selectedTag = tagsList[rowIndex]
        for var i = 0; i < selectedTagsArray.count; i++ {
            if selectedTag == selectedTagsArray[i] {
                wasAlreadySelected = true
            }
        }
        
        
        if wasAlreadySelected == true {
            // If it was already selected then remove the tag from array and color the row
            for var i = 0; i < selectedTagsArray.count; i++ {
                if selectedTag == selectedTagsArray[i] {
                    selectedTagsArray.removeAtIndex(i)
                }
            }
            row!.groupTable.setBackgroundColor(UIColor.blackColor())
            row?.tagLabel.setTextColor(UIColor.whiteColor())
        } else {
            // If it was not already selected then add it to array and color the row
            selectedTagsArray.append(selectedTag)
            row!.groupTable.setBackgroundColor(UIColor.greenColor())
            row?.tagLabel.setTextColor(UIColor.blackColor())
        }
        print("Selected Tag: " + selectedTag)

        //println(wasAlreadySelected)
        
        // Save selected tags array
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(selectedTagsArray, forKey: "Selected Tags Watch")
        defaults.synchronize()
    }

}
