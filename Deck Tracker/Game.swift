//
//  Game.swift
//  Deck Tracker
//
//  Created by Andrei Joghiu on 4/5/15.
//  Copyright (c) 2015 Andrei Joghiu. All rights reserved.
//

import Foundation

class Game : NSCoder {
    
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
