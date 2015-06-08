//
//  SelectDeckWatch.swift
//  Deck Tracker
//
//  Created by Andrei Joghiu on 3/6/15.
//  Copyright (c) 2015 Andrei Joghiu. All rights reserved.
//

import WatchKit
import Foundation


class SelectDeckWatch: WKInterfaceController {

    @IBOutlet var deckTable: WKInterfaceTable!
    var deckList:[Deck] = []
    var wormhole = MMWormhole(applicationGroupIdentifier: "group.Decks", optionalDirectory: nil)
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
    
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
        var dict:[NSDictionary] = defaults.objectForKey("List of decks dictionary") as! [NSDictionary]
        extractDictToArrayOfDecks(dict)
    }
    
    // Takes the saved dictionary and transforms it into a Deck array
    func extractDictToArrayOfDecks(dict:[NSDictionary]) {
        println(dict)
        
        for var i = 0; i < dict.count; i++ {
            var deckName: String = dict[i]["deckName"] as! String
            var deckClass: String = dict[i]["deckClass"] as! String
            var deckID: Int = dict[i]["deckID"] as! Int
            var newDeck = Deck(newDeckID: deckID, newDeckName: deckName, newDeckClass: deckClass)
            deckList.append(newDeck)
        }
    }
    
    // Populates the table
    func reloadTable() {
        deckTable.setNumberOfRows(deckList.count, withRowType: "DeckRow")
        for var i = 0; i < deckList.count; i++ {
            if let row = deckTable.rowControllerAtIndex(i) as? DeckRow {
                row.deckLabel.setText(deckList[i].getName())
                row.deckLabel.setTextColor(UIColor.blackColor())
                
                // Colors the cells
                if deckList[i].getClass() == "Warrior" {
                    row.groupTable.setBackgroundColor(UIColorFromRGB(0xCC0000))
                } else if deckList[i].getClass() == "Paladin" {
                    row.groupTable.setBackgroundColor(UIColorFromRGB(0xCCC333))
                } else if deckList[i].getClass() == "Shaman" {
                    row.groupTable.setBackgroundColor(UIColorFromRGB(0x3366CC))
                } else if deckList[i].getClass() == "Hunter" {
                    row.groupTable.setBackgroundColor(UIColorFromRGB(0x339933))
                } else if deckList[i].getClass() == "Druid" {
                    row.groupTable.setBackgroundColor(UIColorFromRGB(0x990000))
                } else if deckList[i].getClass() == "Rogue" {
                    row.groupTable.setBackgroundColor(UIColorFromRGB(0x666666))
                } else if deckList[i].getClass() == "Warlock" {
                    row.groupTable.setBackgroundColor(UIColorFromRGB(0x9900CC))
                } else if deckList[i].getClass() == "Mage" {
                    row.groupTable.setBackgroundColor(UIColorFromRGB(0x009999))
                } else if deckList[i].getClass() == "Priest" {
                    row.groupTable.setBackgroundColor(UIColorFromRGB(0x999999))
                }
            }
        }
    }
    
    override func table(table: WKInterfaceTable, didSelectRowAtIndex rowIndex: Int) {
        println("a")
    }
    
    func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
