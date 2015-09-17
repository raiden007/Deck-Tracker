//
//  Deck.swift
//  Deck Tracker
//
//  Created by Andrei Joghiu on 5/5/15.
//  Copyright (c) 2015 Andrei Joghiu. All rights reserved.
//

// This class creates decks for the user to manage. 
import Foundation

class Deck : NSObject, NSCoding {
    
    var deckName:String
    var deckClass:String
    var deckID:Int
    
    // Initialize a Deck object with arguments
    init (newDeckID:Int, newDeckName:String, newDeckClass:String) {
        self.deckName = newDeckName
        self.deckClass = newDeckClass
        self.deckID = newDeckID
    }
    
    // Encode and decode so we can store this object in NSUserDefaults
    required init(coder aDecoder: NSCoder) {
        deckName = aDecoder.decodeObjectForKey("deckName") as! String
        deckClass = aDecoder.decodeObjectForKey("deckClass") as! String
        deckID = aDecoder.decodeObjectForKey("deckID") as! Int
    }
    
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(deckName, forKey: "deckName")
        aCoder.encodeObject(deckClass, forKey: "deckClass")
        aCoder.encodeObject(deckID, forKey: "deckID")
    }
    
    // Returns deck name
    func getName() -> String {
        return deckName
    }
    
    // Returns deck class
    func getClass() -> String {
        return deckClass
    }
    
    // Returns deck id
    func getID() -> Int {
        return deckID
    }
                            
    // Returns a string containing all the proprierties of the object
    func toString() -> String {
        var deckIDString = String(deckID)
        return ("Deck ID: " + deckIDString + " ,name: " + deckName + " ,class : " + deckClass)
    }
    
    // Returns a dictionary with all properties in it
    func getDict() -> NSMutableDictionary {
        var dict = NSMutableDictionary()
        dict.setValue(self.deckName, forKey: "deckName")
        dict.setValue(self.deckClass, forKey: "deckClass")
        dict.setValue(self.deckID, forKey: "deckID")
        return dict
    }
}