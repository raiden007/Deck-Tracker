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
        listOfGames += self.readData()!
//        println(listOfGames)
    }
    
    func addGame (newGame : Game) {
        
        println("Game added")
        listOfGames.append(newGame)
 //       println(listOfGames)

        let archivedObject = NSKeyedArchiver.archivedDataWithRootObject(listOfGames as NSArray)
        
        
        // Writing in NSUserDefaults
       NSUserDefaults.standardUserDefaults().setObject(archivedObject, forKey: "List of games")
        // Sync
        NSUserDefaults.standardUserDefaults().synchronize()

        

    }
    
    
    func readData() -> [Game]? {
        println("Data read")
        if let unarchivedObject = NSUserDefaults.standardUserDefaults().objectForKey("List of games") as? NSData {
            return NSKeyedUnarchiver.unarchiveObjectWithData(unarchivedObject) as? [Game]
        }
        return nil
    }
    
    
}
