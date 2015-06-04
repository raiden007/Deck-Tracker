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
    
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
        
        
//        WKInterfaceController.openParentApplication(["request": "refreshData"],
//            reply: { (replyInfo, error) -> Void in
//                // TODO: process reply data
//                NSLog("Reply: \(replyInfo)")
//        })
        
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
    
    func reloadTable() {
        deckTable.setNumberOfRows(10, withRowType: "DeckRow")

        if let row = deckTable.rowControllerAtIndex(0) as? DeckRow {
            row.deckLabel.setText("A")
        }
        
        

//        var defaults = NSUserDefaults(suiteName: "group.Decks")!
//        if let unarchivedObject = defaults.objectForKey("List of decks") as? NSData {
//            println(unarchivedObject)
//            var decksList = NSKeyedUnarchiver.unarchiveObjectWithData(unarchivedObject) as? [Deck]
//            println(decksList)
//        } else {
//            println("Decklist empty")
//        }
        
        
        //deckList = self.readDeckData() as! [Deck]
        //println(deckList)
        
        var defaults = NSUserDefaults(suiteName: "group.Decks")!
        let unarchivedObject = defaults.objectForKey("List of decks") as? NSData
        //println(unarchivedObject)
        //NSKeyedUnarchiver.setClass(Deck.self, forClassName: "Deck")
        let deckList: AnyObject? = NSKeyedUnarchiver.unarchiveObjectWithData(unarchivedObject!)
        println(deckList)
        
    }


}
