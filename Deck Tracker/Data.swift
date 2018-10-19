//
//  Data.swift
//  Deck Tracker
//
//  Created by Andrei Joghiu on 5/5/15.
//  Copyright (c) 2015 Andrei Joghiu. All rights reserved.
//


// This class manipulates the data base structure of games/decks
import Foundation

open class Data: NSObject {
    
    // This is to user Data functions easier in other classes
    static let sharedInstance = Data()
    
    // We create two arrays that will hold our objects
    var listOfGames:[Game] = []
    var listOfDecks:[Deck] = []
    var deckListForPhone:[NSDictionary] = []
    
    // Objects needed to be updated in different functions
    var filteredGames:[Game] = []
    var coinArray:[Game] = []
    
    // Save to iCloud
    var iCloudKeyStore: NSUbiquitousKeyValueStore = NSUbiquitousKeyValueStore()
    
    // We initialize the data structure
    override init() {
        super.init()
        
        NotificationCenter.default.addObserver(self, selector: #selector(Data.keyValueStoreDidChange(_:)), name: NSUbiquitousKeyValueStore.didChangeExternallyNotification, object: iCloudKeyStore)
        iCloudKeyStore.synchronize()
            
        // Check at first install if the game/deck database is empty
        if self.readGameData() == nil {
            print("Game database empty")
            if (self.readDeckData() == nil) {
                print("Decks database empty")
            } else {
                listOfDecks = self.readDeckData()!
            }
        
        } else if self.readDeckData() == nil {
            print("Decks database empty")
            if (self.readGameData() == nil) {
                print("Game database empty")
            } else {
                listOfGames = self.readGameData()!
            }
        } else {
            listOfGames = self.readGameData()!
            listOfDecks = self.readDeckData()!
        }
    }
    
    @objc func keyValueStoreDidChange(_ notification: Notification) {
        if let iCloudUnarchivedObject = iCloudKeyStore.object(forKey: "iCloud list of decks") as? Foundation.Data {
            print("iCloud decks loaded")
            listOfDecks = NSKeyedUnarchiver.unarchiveObject(with: iCloudUnarchivedObject) as! [Deck]
        }
    }
    
    // Adds a game object to the array and save the array in NSUserDefaults
    func addGame (_ newGame : Game) {
        listOfGames.append(newGame)
        listOfGames.sort(by: { $0.date.compare($1.date as Date) == ComparisonResult.orderedDescending })
        saveGame()
    }
    
    // Saves the games array
    func saveGame() {
        let archivedObject = NSKeyedArchiver.archivedData(withRootObject: listOfGames as NSArray)
        // Writing in NSUserDefaults
        UserDefaults.standard.set(archivedObject, forKey: "List of games")
        // Sync
        UserDefaults.standard.synchronize()
        
        iCloudKeyStore.set(archivedObject, forKey: "iCloud list of games")
        iCloudKeyStore.synchronize()
    }
    
    // Reads the game data and returns a Game object
    func readGameData() -> [Game]? {
        if let iCloudUnarchivedObject = iCloudKeyStore.object(forKey: "iCloud list of games") as? Foundation.Data {
            return NSKeyedUnarchiver.unarchiveObject(with: iCloudUnarchivedObject) as? [Game]
        } else if let unarchivedObject = UserDefaults.standard.object(forKey: "List of games") as? Foundation.Data {
            return NSKeyedUnarchiver.unarchiveObject(with: unarchivedObject) as? [Game]
        } else {
          return nil
        }
    }
    
    // Prints all the games in the array
    func printGameData() {
        for i in 0 ..< listOfGames.count {
            print(listOfGames[i].toString())
        }
    }
    
    // Adds a deck object to the array
    func addDeck (_ newDeck: Deck) {
        listOfDecks.append(newDeck)
        listOfDecks.sort(by: { $0.deckID > $1.deckID })
        saveDict()
        saveDeck()
        print("Deck added")
    }
    
    // Creates a new dict to use with phone
    func saveDict() {
        deckListForPhone.removeAll(keepingCapacity: true)
        // Create an dictionary array so we can read this in the shared app group
        for i in 0 ..< listOfDecks.count {
            let dict: NSMutableDictionary = listOfDecks[i].getDict()
            deckListForPhone.append(dict)
        }
    }
    
    // Adds the decks list to NSUserDefaults
    func saveDeck () {
        let archivedObject = NSKeyedArchiver.archivedData(withRootObject: listOfDecks as [Deck])
        let defaults = UserDefaults(suiteName: "group.Decks")!
        defaults.set(archivedObject, forKey: "List of decks")
        defaults.set(deckListForPhone, forKey: "List of decks dictionary")
        defaults.synchronize()
        
        iCloudKeyStore.set(archivedObject, forKey: "iCloud list of decks")
        iCloudKeyStore.set(deckListForPhone, forKey: "iCloud List of decks dictionary")
        iCloudKeyStore.synchronize()
    }
    
    // Reads the deck data and returns a Deck object
    func readDeckData() -> [Deck]? {
        let defaults = UserDefaults(suiteName: "group.Decks")!
        if let iCloudUnarchivedObject = iCloudKeyStore.object(forKey: "iCloud list of decks") as? Foundation.Data {
            print("iCloud decks loaded")
            return NSKeyedUnarchiver.unarchiveObject(with: iCloudUnarchivedObject) as? [Deck]
        } else if let unarchivedObject = defaults.object(forKey: "List of decks") as? Foundation.Data {
            return NSKeyedUnarchiver.unarchiveObject(with: unarchivedObject) as? [Deck]
        } else {
            return nil
        }
        
    }
    
    // Prints all the decks in the array
    func printDeckData () {
        for i in 0 ..< listOfDecks.count {
            print(listOfDecks[i].toString())
        }
    }
    
    // Deletes a deck from the array and updates the array
    func deleteDeck(_ id:Int) {
        listOfDecks.remove(at: id)
        saveDeck()
    }
    
    // Deletes a game from the array and updates the array
    func deleteGame(_ id:Int) {
        listOfGames.remove(at: id)
        saveGame()
    }
    
    // Replaces a game from the array
    func editGame (_ id:Int, oldGame:Game, newGame:Game) {
        for i in 0 ..< listOfGames.count {
            if listOfGames[i].getID() == id {
                listOfGames.remove(at: i)
                listOfGames.insert(newGame, at: i)
                listOfGames.sort(by: { $0.date.compare($1.date as Date) == ComparisonResult.orderedDescending })
                saveGame()
            }
        }
        print("Game Edited")
    }
    
    // Deletes all games associated with a certain deck
    func deleteAllGamesAssociatedWithADeck( _ deckName: String) {
        
        for i in 0..<listOfGames.count - 1 {
            print(listOfGames[i].getPlayerDeckName())
            if listOfGames[i].getPlayerDeckName() == deckName {
                listOfGames.remove(at: i)
            }
        }
        saveGame()
    }
    
    // Calculates the general win rate of the user (all games)
    func generalWinRate(_ date:Int, deckName:String) -> Double {
        
        var gamesWon = 0
        var dateArray = getDateArray(date)
        var selectedDeckName = ""
        if let _ = iCloudKeyStore.string(forKey: "iCloud Selected Deck Name") {
            selectedDeckName = iCloudKeyStore.string(forKey: "iCloud Selected Deck Name")!
        } else if let _ = UserDefaults(suiteName: "group.Decks")!.string(forKey: "Selected Deck Name") {
            selectedDeckName = UserDefaults(suiteName: "group.Decks")!.string(forKey: "Selected Deck Name")!
        }

        // If current deck is selected
        if deckName == selectedDeckName {
            filteredGames = []
            for i in 0 ..< dateArray.count {
                if deckName == dateArray[i].getPlayerDeckName() {
                    filteredGames.append(dateArray[i])
                }
            }
        // If all decks are selected
        } else {
            filteredGames = dateArray
        }
        
        for i in 0 ..< filteredGames.count {
            if (filteredGames[i].win == true) {
                gamesWon += 1
            }
        }
        
        let totalGames = filteredGames.count
        var winRate = 0.0
        if totalGames == 0 {
            return winRate
        } else {
            winRate =  Double(gamesWon) / Double(totalGames) * 100
            return winRate
        }

    }
    
    func generalWinRateCount() -> Int {
        return filteredGames.count
    }
    
    
    // Filters the gamesList array based on the date the user selected
    func getDateArray (_ date:Int) -> [Game] {
        
        var dateArray:[Game] = []
        // If date is last 7 days
        if date == 0 {
            for i in 0 ..< listOfGames.count {
                let today = Date()
                let lastWeek = today.addingTimeInterval(-24 * 60 * 60 * 7)
                if listOfGames[i].getNSDate().compare(lastWeek) == ComparisonResult.orderedDescending {
                    dateArray.append(listOfGames[i])
                }
            }
            return dateArray
            // If date is last month
        } else if date == 1 {
            for i in 0 ..< listOfGames.count {
                let today = Date()
                let lastMonth = today.addingTimeInterval(-24 * 60 * 60 * 30)
                if listOfGames[i].getNSDate().compare(lastMonth) == ComparisonResult.orderedDescending {
                    dateArray.append(listOfGames[i])
                }
            }
            return dateArray
            // If date is all
        } else if date == 2 {
            dateArray = listOfGames
            return dateArray
        } else {
            print("ERROR!!! Date selection is wrong")
            return dateArray
        }
    }
    
    
    func getStatisticsGamesTotal(_ date:Int, deck:String, opponent:String) -> [Game] {
        var filteredGamesByDate = getDateArray(date)
        var selectedDeckName = ""
        var filteredGamesBySelectedDeck:[Game] = []
        var filteredGamesByOpponent:[Game] = []
        
        if let _ = iCloudKeyStore.string(forKey: "iCloud Selected Deck Name") {
            selectedDeckName = iCloudKeyStore.string(forKey: "iCloud Selected Deck Name")!
        } else if let _ = UserDefaults(suiteName: "group.Decks")!.string(forKey: "Selected Deck Name") {
            selectedDeckName = UserDefaults(suiteName: "group.Decks")!.string(forKey: "Selected Deck Name")!
        }
        
        // If current deck is selected
        if deck == selectedDeckName {
            for i in 0 ..< filteredGamesByDate.count {
                if deck == filteredGamesByDate[i].getPlayerDeckName() {
                    filteredGamesBySelectedDeck.append(filteredGamesByDate[i])
                }
            }
            // If all decks are selected
        } else {
            filteredGamesBySelectedDeck = filteredGamesByDate
        }

        for game in filteredGamesBySelectedDeck {
            if opponent == "All" {
                filteredGamesByOpponent = filteredGamesBySelectedDeck
            } else if opponent == game.getOpponentDeck() {
                filteredGamesByOpponent.append(game)
            }
        }
        return filteredGamesByOpponent
    }
}
