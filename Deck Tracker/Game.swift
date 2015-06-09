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
    var date:NSDate

    // Initialize an Game object with the following arguments
    init (newID:Int, newDate:NSDate, newPlayerDeckName:String, newPlayerDeckClass:String, newOpponentDeck:String, newCoin:Bool, newWin:Bool) {
        self.id = newID
        self.playerDeckName = newPlayerDeckName
        self.playerDeckClass = newPlayerDeckClass
        self.opponentDeck = newOpponentDeck
        self.coin = newCoin
        self.win = newWin
        self.date = newDate
    }
    
    // Encode and decode the object so it can be stored in NSUserDefaults
    required init(coder aDecoder: NSCoder) {
        id = aDecoder.decodeObjectForKey("id") as! Int
        playerDeckName = aDecoder.decodeObjectForKey("playerDeckName") as! String
        playerDeckClass = aDecoder.decodeObjectForKey("playerDeckClass") as! String
        opponentDeck = aDecoder.decodeObjectForKey("opponentDeck") as! String
        coin = aDecoder.decodeObjectForKey("coin") as! Bool
        win = aDecoder.decodeObjectForKey("win") as! Bool
        date = aDecoder.decodeObjectForKey("date") as! NSDate
    }
    
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(id, forKey: "id")
        aCoder.encodeObject(playerDeckName, forKey: "playerDeckName")
        aCoder.encodeObject(playerDeckClass, forKey: "playerDeckClass")
        aCoder.encodeObject(opponentDeck, forKey: "opponentDeck")
        aCoder.encodeObject(coin, forKey: "coin")
        aCoder.encodeObject(win, forKey: "win")
        aCoder.encodeObject(date, forKey: "date")
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
        let formatter = NSDateFormatter()
        formatter.dateStyle = NSDateFormatterStyle.ShortStyle
        let dateString = formatter.stringFromDate(date)
        return dateString
    }
    
    // Gets the NSDate
    func getNSDate() -> NSDate {
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
    
    // Returns a string containing all the proprierties of the object
    func toString() -> String {
        
        var coinString = String(stringInterpolationSegment: coin)
        var winString = String(stringInterpolationSegment: win)
        var idString = String(id)
        
        return ("Game number: " + idString + ", date: " + getDate() + ", Player Deck Name: " + playerDeckName + ", Opponent Deck: " + opponentDeck + ", Coin: " + coinString + ", Win: " + winString)
        
    }
}
