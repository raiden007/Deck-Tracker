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
    //var deckList:[Deck] = []
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
        
        reloadTable()
        activatePhoneApp()
        
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
        


    }
    
    func activatePhoneApp() {
        WKInterfaceController.openParentApplication(["request": "refreshData"],
            reply: { (replyInfo, error) -> Void in
                self.wormhole.passMessageObject("object", identifier: "requestDeckList")
               
        })
    }


}
