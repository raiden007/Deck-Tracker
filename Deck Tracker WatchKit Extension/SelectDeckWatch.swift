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
        
        // Configure interface objects here.
        
        
//        WKInterfaceController.openParentApplication(["request": "refreshData"],
//            reply: { (replyInfo, error) -> Void in
//                // TODO: process reply data
//                NSLog("Reply: \(replyInfo)")
//        })
        
        self.wormhole.listenForMessageWithIdentifier("caine", listener: { (object: AnyObject?) -> Void in
            
            println("mesaj")
        })
        
//        self.wormhole.listenForMessageWithIdentifier("receiveDeckList", listener: { (deckListForPhone) -> Void in
//            //if let message: AnyObject = deckListForPhone {
//                println("Message received")
//            //}
//        })
        
        loadData()
        reloadTable()
//        activatePhoneApp()
        
        
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
        var defaults = NSUserDefaults(suiteName: "group.Decks")!
        var dict:[NSDictionary] = defaults.objectForKey("List of decks dictionary") as! [NSDictionary]
        extractDictToArrayOfDecks(dict)
    }
    
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
    
    func reloadTable() {
        deckTable.setNumberOfRows(deckList.count, withRowType: "DeckRow")
        for var i = 0; i < deckList.count; i++ {
            if let row = deckTable.rowControllerAtIndex(i) as? DeckRow {
                row.deckLabel.setText(deckList[i].getName())
            }
        }
    }
    
//    func activatePhoneApp() {
//        WKInterfaceController.openParentApplication(["request": "refreshData"],
//            reply: { (replyInfo, error) -> Void in
//                self.wormhole.passMessageObject("object", identifier: "requestDeckList")
//               
//        })
//    }
//
//
}
