//
//  Data.swift
//  Deck Tracker
//
//  Created by Andrei Joghiu on 5/5/15.
//  Copyright (c) 2015 Andrei Joghiu. All rights reserved.
//


// This class manipulates the data base structure of games/decks
import Foundation

public class Data {
    
    // This is to user Data functions easier in other classes
    static let sharedInstance = Data()
    
    // We create two arrays that will hold our objects
    var listOfGames:[Game] = []
    var listOfDecks:[Deck] = []
    
    // We initialize the data structure
    init() {
        
        // Check at first install if the game/deck database is empty
        if self.readGameData() == nil {
            println("Game database empty")
            if (self.readDeckData() == nil) {
                println("Decks database empty")
            } else {
                listOfDecks = self.readDeckData()!
            }
        
        } else if self.readDeckData() == nil {
            println("Decks database empty")
            if (self.readGameData() == nil) {
                println("Game database empty")
            } else {
                listOfGames = self.readGameData()!
            }
            
        } else {
            listOfGames = self.readGameData()!
            listOfDecks = self.readDeckData()!
        }
    }
    
    // Adds a game object to the array and save the array in NSUserDefaults
    func addGame (newGame : Game) {
        listOfGames.append(newGame)
        listOfGames.sort({ $0.date.compare($1.date) == NSComparisonResult.OrderedDescending })
        saveGame()
        println("Game added")
    }
    
    func saveGame() {
        let archivedObject = NSKeyedArchiver.archivedDataWithRootObject(listOfGames as NSArray)
        // Writing in NSUserDefaults
        NSUserDefaults.standardUserDefaults().setObject(archivedObject, forKey: "List of games")
        // Sync
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    // Reads the game data and returns a Game object
    func readGameData() -> [Game]? {
        //println("Data read")
        if let unarchivedObject = NSUserDefaults.standardUserDefaults().objectForKey("List of games") as? NSData {
            return NSKeyedUnarchiver.unarchiveObjectWithData(unarchivedObject) as? [Game]
        }
        return nil
    }
    
    // Prints all the games in the array
    func printGameData() {
        for (var i=0; i<listOfGames.count; i++) {
            println(listOfGames[i].toString())
        }
    }
    
    // Adds a deck object to the array
    func addDeck (newDeck: Deck) {
        listOfDecks.append(newDeck)
        saveDeck()
        println("Deck added")
    }
    
    // Adds the decks list to NS User Defaults
    func saveDeck () {
        let archivedObject = NSKeyedArchiver.archivedDataWithRootObject(listOfDecks as NSArray)
        NSUserDefaults.standardUserDefaults().setObject(archivedObject, forKey: "List of decks")
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    // Reads the deck data and returns a Deck object
    func readDeckData() -> [Deck]? {
        if let unarchivedObject = NSUserDefaults.standardUserDefaults().objectForKey("List of decks") as? NSData {
            return NSKeyedUnarchiver.unarchiveObjectWithData(unarchivedObject) as? [Deck]
        }
        return nil
    }
    
    // Prints all the decks in the array
    func printDeckData () {
        for (var i=0; i<listOfDecks.count; i++) {
            println(listOfDecks[i].toString())
        }
    }
    
    // Deletes a deck from the array and updates the array
    func deleteDeck(id:Int) {
        listOfDecks.removeAtIndex(id)
        saveDeck()
        println("Deck deleted")
        
    }
    
    // Deletes a game from the array and updates the array
    func deleteGame(id:Int) {
        listOfGames.removeAtIndex(id)
        saveGame()
        println("Game deleted")
    }
    
    // Replaces a game from the array
    func editGame (id:Int, oldGame:Game, newGame:Game) {
        for var i = 0; i < listOfGames.count; i++ {
            if listOfGames[i].getID() == id {
                //printGameData()
                listOfGames.removeAtIndex(i)
                //printGameData()
                listOfGames.insert(newGame, atIndex: i)
                //printGameData()
                listOfGames.sort({ $0.date.compare($1.date) == NSComparisonResult.OrderedDescending })
                saveGame()
            }
        }
        println("Game Edited")
    }
    




    // Calculates the general win rate of the user (all games)
    func generalWinRate(date:Int, deckName:String) -> Double {
        
        var gamesWon = 0
        var dateWinRateArray:[Game] = []
        var generalWinRateArray:[Game] = []
        
        // If date is last 7 days
        if date == 1 {
            for var i = 0; i < listOfGames.count; i++ {
                let today = NSDate()
                let lastWeek = today.dateByAddingTimeInterval(-24 * 60 * 60 * 7)
                if listOfGames[i].getNSDate().compare(lastWeek) == NSComparisonResult.OrderedDescending {
                    dateWinRateArray.append(listOfGames[i])
                    
                }
                
            }
        println("Elements for the last 7 days: ")
        println(dateWinRateArray.count)
        // If date is last month
        } else if date == 2 {
            
        // If date is all
        } else if date == 3 {
            
        } else {
            println("ERROR!!! Date selection is wrong")
        }
        
        let selectedDeckName = NSUserDefaults.standardUserDefaults().stringForKey("Selected Deck Name") as String!
        
        // If current deck is selected
        if deckName == selectedDeckName {
            for var i = 0; i < dateWinRateArray.count; i++ {
                if deckName == dateWinRateArray[i].getPlayerDeckName() {
                    generalWinRateArray.append(dateWinRateArray[i])
                }
            }
        println("Elements after filtering the selected Deck: ")
        println(generalWinRateArray.count)
        // If all decks are selected
        } else {
            println("")
        }
        
        
        for (var i=0; i<generalWinRateArray.count ; i++) {
            if (generalWinRateArray[i].win == true) {
                gamesWon++
            }
        }
        
        var totalGames = generalWinRateArray.count
        var winRate =  Double(gamesWon) / Double(totalGames) * 100.0
        println("Total Games: " + String(totalGames))
        println("Games Won: " + gamesWon.description)
        println("Win Rate: " + winRate.description)
        return winRate
    }
    
    
}
