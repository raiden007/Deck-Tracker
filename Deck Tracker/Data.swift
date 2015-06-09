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
    var deckListForPhone:[NSDictionary] = []
    
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
    
    // Saves the games array
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
        saveDict()
        saveDeck()
        println("Deck added")
    }
    
    // Creates a new dict to use with phone
    func saveDict() {
        deckListForPhone.removeAll(keepCapacity: true)
        // Create an dictionary array so we can read this in the shared app group
        for var i = 0; i < listOfDecks.count; i++ {
            var dict: NSMutableDictionary = listOfDecks[i].getDict()
            deckListForPhone.append(dict)
        }
    }
    
    // Adds the decks list to NSUserDefaults
    func saveDeck () {
        let archivedObject = NSKeyedArchiver.archivedDataWithRootObject(listOfDecks as [Deck])
        var defaults = NSUserDefaults(suiteName: "group.Decks")!
        defaults.setObject(archivedObject, forKey: "List of decks")
        defaults.setObject(deckListForPhone, forKey: "List of decks dictionary")
        defaults.synchronize()
        
    }
    
    // Reads the deck data and returns a Deck object
    func readDeckData() -> [Deck]? {
        var defaults = NSUserDefaults(suiteName: "group.Decks")!
        if let unarchivedObject = defaults.objectForKey("List of decks") as? NSData {
            //NSKeyedUnarchiver.setClass(Deck.self, forClassName: "Deck")
            //NSKeyedArchiver.setClassName("Deck", forClass: Deck.self)
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
        var generalWinRateArray:[Game] = []
        var dateArray = getDateArray(date)
        var selectedDeckName = NSUserDefaults(suiteName: "group.Decks")!.stringForKey("Selected Deck Name") as String!
        if selectedDeckName == nil {
            selectedDeckName = ""
        }
        
        // If current deck is selected
        if deckName == selectedDeckName {
            for var i = 0; i < dateArray.count; i++ {
                if deckName == dateArray[i].getPlayerDeckName() {
                    generalWinRateArray.append(dateArray[i])
                }
            }
        // If all decks are selected
        } else {
            generalWinRateArray = dateArray
        }
        
        for (var i=0; i<generalWinRateArray.count ; i++) {
            if (generalWinRateArray[i].win == true) {
                gamesWon++
            }
        }
        
        var totalGames = generalWinRateArray.count
        var winRate = 0.0
        if totalGames == 0 {
            return winRate
        } else {
            winRate =  Double(gamesWon) / Double(totalGames) * 100
            return winRate
        }

    }
    
    
    // Filters the gamesList array based on the date the user selected
    func getDateArray (date:Int) -> [Game] {
        
        var dateArray:[Game] = []
        // If date is last 7 days
        if date == 0 {
            for var i = 0; i < listOfGames.count; i++ {
                let today = NSDate()
                let lastWeek = today.dateByAddingTimeInterval(-24 * 60 * 60 * 7)
                if listOfGames[i].getNSDate().compare(lastWeek) == NSComparisonResult.OrderedDescending {
                    dateArray.append(listOfGames[i])
                }
            }
            println("Count for the last 7 days: " + String(dateArray.count))
            return dateArray
            // If date is last month
        } else if date == 1 {
            for var i = 0; i < listOfGames.count; i++ {
                let today = NSDate()
                let lastMonth = today.dateByAddingTimeInterval(-24 * 60 * 60 * 30)
                if listOfGames[i].getNSDate().compare(lastMonth) == NSComparisonResult.OrderedDescending {
                    dateArray.append(listOfGames[i])
                }
            }
            println("Count for the last month: " + String(dateArray.count))
            return dateArray
            // If date is all
        } else if date == 2 {
            dateArray = listOfGames
            println("Count for all dates: " + String(dateArray.count))
            return dateArray
        } else {
            println("ERROR!!! Date selection is wrong")
            return dateArray
        }
    }
    
    
    // Returns the heroes played by the user
    func heroesPlayed (date:Int) -> [Int] {
        var heroesPlayed:[Int] = [0,0,0,0,0,0,0,0,0]
        var dateArray = getDateArray(date)
        for var i = 0; i < dateArray.count; i++ {
            var playerClass = dateArray[i].getPlayerDeckClass()
            if playerClass == "Warrior" {
                heroesPlayed[0]++
            } else if playerClass == "Paladin" {
                heroesPlayed[1]++
            } else if playerClass == "Shaman" {
                heroesPlayed[2]++
            } else if playerClass == "Hunter" {
                heroesPlayed[3]++
            } else if playerClass == "Druid" {
                heroesPlayed[4]++
            } else if playerClass == "Rogue" {
                heroesPlayed[5]++
            } else if playerClass == "Mage" {
                heroesPlayed[6]++
            } else if playerClass == "Warlock" {
                heroesPlayed[7]++
            } else if playerClass == "Priest" {
                heroesPlayed[8]++
            } else {
                assert(true, "Player Class Unknown")
            }
        }
        return heroesPlayed
    }
    
    
    // Returns the opponents class encountered by the user
    func opponentsPlayed (date:Int, deckName:String) -> [Int] {
        var opponentsPlayed:[Int] = [0,0,0,0,0,0,0,0,0]
        var dateArray = getDateArray(date)
        var opponentsPlayedArray:[Game] = []
        
        var selectedDeckName = NSUserDefaults(suiteName: "group.Decks")!.stringForKey("Selected Deck Name") as String!
        if selectedDeckName == nil {
            selectedDeckName = ""
        }
        
        if deckName == selectedDeckName {
            for var i = 0; i < dateArray.count; i++ {
                if deckName == dateArray[i].getPlayerDeckName() {
                    opponentsPlayedArray.append(dateArray[i])
                }
            }
        } else {
            opponentsPlayedArray = dateArray
        }

        for var i = 0; i < opponentsPlayedArray.count; i++ {
            var opponentClass = opponentsPlayedArray[i].getOpponentDeck()
            if opponentClass == "Warrior" {
                opponentsPlayed[0]++
            } else if opponentClass == "Paladin" {
                opponentsPlayed[1]++
            } else if opponentClass == "Shaman" {
                opponentsPlayed[2]++
            } else if opponentClass == "Hunter" {
                opponentsPlayed[3]++
            } else if opponentClass == "Druid" {
                opponentsPlayed[4]++
            } else if opponentClass == "Rogue" {
                opponentsPlayed[5]++
            } else if opponentClass == "Mage" {
                opponentsPlayed[6]++
            } else if opponentClass == "Warlock" {
                opponentsPlayed[7]++
            } else if opponentClass == "Priest" {
                opponentsPlayed[8]++
            } else {
                assert(true, "Opponent Class Unknown")
            }
        }
        return opponentsPlayed
    }
    
    
    // Calculates the win rate when going first
    func withCoinWinRate(date:Int, deckName:String) -> Double {
        
        var gamesWon = 0
        var generalWinRateArray:[Game] = []
        var dateArray = getDateArray(date)
        var coinArray:[Game] = []
        var selectedDeckName = NSUserDefaults(suiteName: "group.Decks")!.stringForKey("Selected Deck Name") as String!
        if selectedDeckName == nil {
            selectedDeckName = ""
        }
        
        
        // If current deck is selected
        if deckName == selectedDeckName {
            for var i = 0; i < dateArray.count; i++ {
                if deckName == dateArray[i].getPlayerDeckName() {
                    generalWinRateArray.append(dateArray[i])
                }
            }
            //println("Count for selected Deck: " + String(generalWinRateArray.count))
            // If all decks are selected
        } else {
            generalWinRateArray = dateArray
            //println("Count for all decks: " + String(generalWinRateArray.count))
        }
        
        for (var i=0; i<generalWinRateArray.count ; i++) {
            if generalWinRateArray[i].coin == true {
                coinArray.append(generalWinRateArray[i])
            }
        }
        
        for (var i=0; i<coinArray.count ; i++) {
            if coinArray[i].win == true {
                gamesWon++
            }
        }
        
        var totalGames = coinArray.count
        var winRate = 0.0
        if totalGames == 0 {
            return winRate
        } else {
            winRate =  Double(gamesWon) / Double(totalGames) * 100
            println("Coin Total Games: " + String(totalGames))
            println("Coin Games Won: " + gamesWon.description)
            println("Coin Win Rate: " + winRate.description)
            return winRate
        }
    }
    
    
    // Calculates the win rate when going second
    func withoutCoinWinRate(date:Int, deckName:String) -> Double {
        
        var gamesWon = 0
        var generalWinRateArray:[Game] = []
        var dateArray = getDateArray(date)
        var coinArray:[Game] = []
        
        var selectedDeckName = NSUserDefaults(suiteName: "group.Decks")!.stringForKey("Selected Deck Name") as String!
        if selectedDeckName == nil {
            selectedDeckName = ""
        }
        
        // If current deck is selected
        if deckName == selectedDeckName {
            for var i = 0; i < dateArray.count; i++ {
                if deckName == dateArray[i].getPlayerDeckName() {
                    generalWinRateArray.append(dateArray[i])
                }
            }
            //println("Count for selected Deck: " + String(generalWinRateArray.count))
            // If all decks are selected
        } else {
            generalWinRateArray = dateArray
            //println("Count for all decks: " + String(generalWinRateArray.count))
        }
        
        for (var i=0; i<generalWinRateArray.count ; i++) {
            if generalWinRateArray[i].coin == false {
                coinArray.append(generalWinRateArray[i])
            }
        }
        
        for (var i=0; i<coinArray.count ; i++) {
            if coinArray[i].win == true {
                gamesWon++
            }
        }
        
        var totalGames = coinArray.count
        var winRate = 0.0
        if totalGames == 0 {
            return winRate
        } else {
            winRate =  Double(gamesWon) / Double(totalGames) * 100
            println("Coin Total Games: " + String(totalGames))
            println("Coin Games Won: " + gamesWon.description)
            println("Coin Win Rate: " + winRate.description)
            return winRate
        }
    }
}
