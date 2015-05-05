//
//  Game.swift
//  Deck Tracker
//
//  Created by Andrei Joghiu on 4/5/15.
//  Copyright (c) 2015 Andrei Joghiu. All rights reserved.
//

import Foundation

class Game : NSObject, NSCoding {
    
    var id:Int
    var plDeck:String
    var oDeck:String
    var hasCoin:Bool
    var didWin:Bool

    init (idNumber:Int, playerDeck:String, opponentDeck:String, coin:Bool, win:Bool) {
        self.id = idNumber
        self.plDeck = playerDeck
        self.oDeck = opponentDeck
        self.hasCoin = coin
        self.didWin = win
        
        
    }
    
    required init(coder aDecoder: NSCoder) {
        id = aDecoder.decodeObjectForKey("id") as! Int
        plDeck = aDecoder.decodeObjectForKey("plDeck") as! String
        oDeck = aDecoder.decodeObjectForKey("oDeck") as! String
        hasCoin = aDecoder.decodeObjectForKey("hasCoin") as! Bool
        didWin = aDecoder.decodeObjectForKey("didWin") as! Bool
    }
    
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(id, forKey: "id")
        aCoder.encodeObject(plDeck, forKey: "plDeck")
        aCoder.encodeObject(oDeck, forKey: "oDeck")
        aCoder.encodeObject(hasCoin, forKey: "hasCoin")
        aCoder.encodeObject(didWin, forKey: "didWin")
    }
    
    
    func getPlayerDeck() -> String {
        return plDeck

    }
    
    func getOpponentDeck() -> String {
        return oDeck
    }
    

    func toString() -> String {
        
        var coinString = String(stringInterpolationSegment: hasCoin)
        var winString = String(stringInterpolationSegment: didWin)
        
        return ("Player Deck: " + plDeck + ", Opponent Deck: " + oDeck + ", Coin: " + coinString + ", Win: " + winString)
        
    }
    
    
    
    
}
