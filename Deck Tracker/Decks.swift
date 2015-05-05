//
//  Decks.swift
//  Deck Tracker
//
//  Created by Andrei Joghiu on 5/5/15.
//  Copyright (c) 2015 Andrei Joghiu. All rights reserved.
//

import Foundation

class Deck : NSObject, NSCoding {
    
    var deckName:String
    var deckClass:String
    var deckID:Int
    

    init (newDeckID:Int, newDeckName:String, newDeckClass:String) {
        self.deckName = newDeckName
        self.deckClass = newDeckClass
        self.deckID = newDeckID
    }
    
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
    
    func getName() -> String {
        return deckName
    }
    
    func getClass() -> String {
        return deckClass
    }
    
    func getID() -> Int {
        return deckID
    }
    
    func toString() -> String {
        var deckIDString = String(deckID)
        return ("Deck ID: " + deckIDString + " ,name: " + deckName + " ,class : " + deckClass)
    }
    
}