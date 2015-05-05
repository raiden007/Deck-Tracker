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
    
    init() {
        
        // Check at first install if the database is empty
        if (self.readData() == nil) {
            println("Database Empty")
        } else {
            listOfGames += self.readData()!
        }

    }
    
    func addGame (newGame : Game) {
        
//        println("Game added")
        listOfGames.append(newGame)
        
        let archivedObject = NSKeyedArchiver.archivedDataWithRootObject(listOfGames as NSArray)
        
        
        // Writing in NSUserDefaults
       NSUserDefaults.standardUserDefaults().setObject(archivedObject, forKey: "List of games")
        // Sync
        NSUserDefaults.standardUserDefaults().synchronize()

    }
    
    
    func readData() -> [Game]? {
 //       println("Data read")
        if let unarchivedObject = NSUserDefaults.standardUserDefaults().objectForKey("List of games") as? NSData {
            return NSKeyedUnarchiver.unarchiveObjectWithData(unarchivedObject) as? [Game]
        }
        return nil
    }
    
    func printData() {
        for (var i=0; i<listOfGames.count; i++) {
            println(listOfGames[i].toString())
        }
    }
    
    func generalWinRate() -> Double {
        var totalGames = listOfGames.count
        var gamesWon = 0.0
        for (var i=0; i<listOfGames.count; i++) {
            if (listOfGames[i].didWin == true) {
                gamesWon++
            }
        }
        
        var winRate =  gamesWon / Double(totalGames) * 100.0
        println("Total Games: " + String(totalGames))
        println("Games Won: " + gamesWon.description)
        println("Win Rate: " + winRate.description)
        return winRate
    }
    
    
}
