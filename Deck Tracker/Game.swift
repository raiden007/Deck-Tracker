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
    var playerDeck:String
    var opponentDeck:String
    var coin:Bool
    var win:Bool
    var date:String

    // Initialize an Game object with the following arguments
    init (newID:Int, newDate:String, newPlayerDeck:String, newOpponentDeck:String, newCoin:Bool, newWin:Bool) {
        self.id = newID
        self.playerDeck = newPlayerDeck
        self.opponentDeck = newOpponentDeck
        self.coin = newCoin
        self.win = newWin
        self.date = newDate
        
    }
    
    // Encode and decode the object so it can be stored in NSUserDefaults
    required init(coder aDecoder: NSCoder) {
        id = aDecoder.decodeObjectForKey("id") as! Int
        playerDeck = aDecoder.decodeObjectForKey("playerDeck") as! String
        opponentDeck = aDecoder.decodeObjectForKey("opponentDeck") as! String
        coin = aDecoder.decodeObjectForKey("coin") as! Bool
        win = aDecoder.decodeObjectForKey("win") as! Bool
        date = aDecoder.decodeObjectForKey("date") as! String
    }
    
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(id, forKey: "id")
        aCoder.encodeObject(playerDeck, forKey: "playerDeck")
        aCoder.encodeObject(opponentDeck, forKey: "opponentDeck")
        aCoder.encodeObject(coin, forKey: "coin")
        aCoder.encodeObject(win, forKey: "win")
        aCoder.encodeObject(date, forKey: "date")
    }
    
    
    func getPlayerDeck() -> String {
        return playerDeck

    }
    
    func getOpponentDeck() -> String {
        return opponentDeck
    }
    
    // Returns a string containing all the proprierties of the object
    func toString() -> String {
        
        var coinString = String(stringInterpolationSegment: coin)
        var winString = String(stringInterpolationSegment: win)
        var idString = String(id)
        
        return ("Game number: " + idString + ", date: " + date + ", Player Deck: " + playerDeck + ", Opponent Deck: " + opponentDeck + ", Coin: " + coinString + ", Win: " + winString)
        
    }
    
    
    
    
}
