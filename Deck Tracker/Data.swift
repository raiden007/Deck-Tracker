//
//  Data.swift
//  Deck Tracker
//
//  Created by Andrei Joghiu on 5/5/15.
//  Copyright (c) 2015 Andrei Joghiu. All rights reserved.
//

import Foundation

public class Data {
    
    static let sharedInstance = Data()
    
    
    var listOfGames:[Game] = []
    
    
    
    func addGame (newGame : Game) {
        
        println("Game added")
        listOfGames.append(newGame)
        println(listOfGames)

        
        // Writing in NSUserDefaults
//        NSUserDefaults.standardUserDefaults().setObject(listOfGames, forKey: "List of games")
        // Sync
//        NSUserDefaults.standardUserDefaults().synchronize()


    }
    
    func readData () {
        
        println("Data read")
//        listOfGames = NSUserDefaults.standardUserDefaults().integerForKey("List of games");
//        listOfGames = NSUserDefaults.standardUserDefaults().arrayForKey("List of games")

        
    }
    
    
    
    
    
    
    
    
    
    
}
