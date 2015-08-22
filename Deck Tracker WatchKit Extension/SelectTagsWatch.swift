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
    
    // Loads data from NSUserDefaults
    func loadData() {
        var defaults = NSUserDefaults(suiteName: "group.Decks")!
        if let testTags: AnyObject = defaults.objectForKey("All Notes") {
            tagsList = testTags as! [String]
        }
        println(tagsList)
    }
    
    // Populates the table
    func reloadTable() {
        
        tagsTable.setNumberOfRows(tagsList.count, withRowType: "TagRow")
        //tagsTable.setNumberOfRows(2, withRowType: "TagsRow")
        
        if tagsList.count == 0 {
            noTagsLabel.setHidden(false)
        } else {
            for var i = 0; i < tagsList.count; i++ {
                if let row = tagsTable.rowControllerAtIndex(i) as? TagsRow {
                    row.tagLabel.setText(tagsList[i])
                    //row.tagLabel.setText("a")
                    //row.tagLabel.setTextColor(UIColor.blackColor())
                }
            }
        }
    }
    
    // Saves the selected tag and colors the row
    override func table(table: WKInterfaceTable, didSelectRowAtIndex rowIndex: Int) {
        let row = table.rowControllerAtIndex(rowIndex) as? TagsRow
        
        wasAlreadySelected = false
        
        var selectedTag = tagsList[rowIndex]
        for var i = 0; i < selectedTagsArray.count; i++ {
            if selectedTag == selectedTagsArray[i] {
                wasAlreadySelected = true
            } else {
                //wasAlreadySelected = false
            }
        }
        
        if wasAlreadySelected == true {
            for var i = 0; i < selectedTagsArray.count; i++ {
                if selectedTag == selectedTagsArray[i] {
                    selectedTagsArray.removeAtIndex(i)
                }
            }
            row!.groupTable.setBackgroundColor(UIColor.blackColor())
            row?.tagLabel.setTextColor(UIColor.whiteColor())
        } else {
            selectedTagsArray.append(selectedTag)
            row!.groupTable.setBackgroundColor(UIColor.greenColor())
            row?.tagLabel.setTextColor(UIColor.blackColor())
        }
        println(selectedTag)
        println(selectedTagsArray)
        println(wasAlreadySelected)
        

        var defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(selectedTagsArray, forKey: "Selected Tags Watch")
        defaults.synchronize()
    }

}
