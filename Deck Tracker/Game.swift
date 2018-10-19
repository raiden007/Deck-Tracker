//
//  Game.swift
//  Deck Tracker
//
//  Created by Andrei Joghiu on 4/5/15.
//  Copyright (c) 2015 Andrei Joghiu. All rights reserved.
//

// This class creates games that the user played and won/lost.
import Foundation

class Game : NSObject, NSCoding {
    
    var id:Int
    var playerDeckName:String
    var playerDeckClass:String
    var opponentDeck:String
    var coin:Bool
    var win:Bool
    var date:Date
    var tag:String

    // Initialize an Game object with the following arguments
    init (newID:Int, newDate:Date, newPlayerDeckName:String, newPlayerDeckClass:String, newOpponentDeck:String, newCoin:Bool, newWin:Bool, newTag:String) {
        self.id = newID
        self.playerDeckName = newPlayerDeckName
        self.playerDeckClass = newPlayerDeckClass
        self.opponentDeck = newOpponentDeck
        self.coin = newCoin
        self.win = newWin
        self.date = newDate
        self.tag = newTag
    }
    
    // Encode and decode the object so it can be stored in NSUserDefaults
    required init?(coder aDecoder: NSCoder) {
        id = aDecoder.decodeObject(forKey: "id") as! Int
        playerDeckName = aDecoder.decodeObject(forKey: "playerDeckName") as! String
        playerDeckClass = aDecoder.decodeObject(forKey: "playerDeckClass") as! String
        opponentDeck = aDecoder.decodeObject(forKey: "opponentDeck") as! String
        coin = aDecoder.decodeObject(forKey: "coin") as! Bool
        win = aDecoder.decodeObject(forKey: "win") as! Bool
        date = aDecoder.decodeObject(forKey: "date") as! Date
        if let _ = aDecoder.decodeObject(forKey: "tag") as? String {
            tag = aDecoder.decodeObject(forKey: "tag") as! String
        } else {
            tag = ""
        }
    }
    
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: "id")
        aCoder.encode(playerDeckName, forKey: "playerDeckName")
        aCoder.encode(playerDeckClass, forKey: "playerDeckClass")
        aCoder.encode(opponentDeck, forKey: "opponentDeck")
        aCoder.encode(coin, forKey: "coin")
        aCoder.encode(win, forKey: "win")
        aCoder.encode(date, forKey: "date")
        aCoder.encode(tag, forKey: "tag")
    }
    
    // Returns deck name
    func getPlayerDeckName() -> String {
        return playerDeckName

    }
    
    // Returns deck class
    func getPlayerDeckClass() -> String {
        return playerDeckClass
    }
    
    // Returns opponent class
    func getOpponentDeck() -> String {
        return opponentDeck
    }
    
    // Returns Date in String format
    func getDate() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = DateFormatter.Style.short
        let dateString = formatter.string(from: date)
        return dateString
    }
    
    // Gets the NSDate
    func getNSDate() -> Date {
        return date
    }

    // Returns true/false if user played first
    func getCoin() -> Bool {
        if coin == true {
            return true
        } else {
            return false
        }
    }
    
    // Returns true/false if user won
    func getWin() -> Bool {
        if win == true {
            return true
        } else {
            return false
        }
    }
    
    // Returns won/lost String if user won
    func getWinString() -> String {
        if win == true {
            return "WON"
        } else {
            return "LOST"
        }
    }

    // Returns the ID
    func getID() -> Int {
        return id
    }
    
    // Returns the tag
    func getTag() -> String {
        return tag
    }
    
    // Sets the tag
    func setNewTag(_ newTag:String) {
        tag = newTag
    }
    
    // Returns a string containing all the proprierties of the object
    func toString() -> String {
        
        let coinString = String(stringInterpolationSegment: coin)
        let winString = String(stringInterpolationSegment: win)
        let idString = String(id)
        
        return ("Game number: " + idString + ", date: " + getDate() + ", Player Deck Name: " + playerDeckName + ", Opponent Deck: " + opponentDeck + ", Coin: " + coinString + ", Win: " + winString + ", Tag: " + tag)
    }
}
