//
//  StatsList.swift
//  Deck Tracker
//
//  Created by Andrei Joghiu on 28/4/15.
//  Copyright (c) 2015 Andrei Joghiu. All rights reserved.
//

import UIKit

class StatsList: UIViewController, UINavigationBarDelegate, UITableViewDelegate {
    
    @IBOutlet var statsTable: UITableView!
    
    var gamesList:[Game] = []
    var defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
    var selectedGameArray:[Game] = []
    static let sharedInstance = StatsList()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        readData()
        
        // Listens for "Game Added" and calls refreshData()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(StatsList.refreshData), name: "GameAdded", object: nil)
        
        // Removes the empty rows from view
        statsTable.tableFooterView = UIView(frame: CGRectZero)
    }
    
    // Cleans stuff up
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // Gets the number of rows to be displayed in the table
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gamesList.count
    }
    
    // Populates the table with data
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:GamesCell = tableView.dequeueReusableCellWithIdentifier("Cell") as! GamesCell
        cell.dateLabel.text = gamesList[indexPath.row].getDate()
        let playerImage = gamesList[indexPath.row].getPlayerDeckClass()
        let playerImageName = getImage(playerImage)
        cell.playerImage.image = UIImage(named: playerImageName)
        let opponentImage = gamesList[indexPath.row].getOpponentDeck()
        let opponentImageName = getImage(opponentImage)
        cell.opponentImage.image = UIImage(named: opponentImageName)
        cell.winLabel.text = gamesList[indexPath.row].getWinString()
        return cell
    }
    
    // Saves the selected Game so it can display it's info in the next screen
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let selectedGame = gamesList[indexPath.row]
        selectedGameArray.append(selectedGame)
        saveSelectedGame()
        readSelectedGame()
        // Remove the selected game from Array so everytime there is only one Game in array
        selectedGameArray.removeAll(keepCapacity: true)
    }
    
    // Saves in NSUserDefaults
    func saveSelectedGame() {
        let archivedObject = NSKeyedArchiver.archivedDataWithRootObject(selectedGameArray as NSArray)
        // Writing in NSUserDefaults
        NSUserDefaults.standardUserDefaults().setObject(archivedObject, forKey: "Selected Game")
        // Sync
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    // Reads the game data and returns a Game object
    func readSelectedGame() -> [Game]? {
        if let unarchivedObject = NSUserDefaults.standardUserDefaults().objectForKey("Selected Game") as? NSData {
            return NSKeyedUnarchiver.unarchiveObjectWithData(unarchivedObject) as? [Game]
        }
        return nil
    }
    
    // Returns the image depeding on the deck class
    func getImage (str:String) -> String {
        
        if str == "Warrior" {
            return "WarriorSmall"
        } else if str == "Paladin" {
            return "PaladinSmall"
        } else if str == "Shaman" {
            return "ShamanSmall"
        } else if str == "Druid" {
            return "DruidSmall"
        } else if str == "Rogue" {
            return "RogueSmall"
        } else if str == "Mage" {
            return "MageSmall"
        } else if str == "Warlock" {
            return "WarlockSmall"
        } else if str == "Priest" {
            return "PriestSmall"
        } else if str == "Hunter" {
            return "HunterSmall"
        } else {
            return ""
        }
    }
    
    // Reads the games array
    func readData() {
        if Data.sharedInstance.readGameData() == nil {
            gamesList = []
        } else {
            gamesList = Data.sharedInstance.listOfGames
        }
    }
    
    // Refreshes the view after adding a deck
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        refreshData()
    }

    func refreshData() {
        readData()
        statsTable.reloadData()
    }
    
    // Deletes the row
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            let index = indexPath.row
            Data.sharedInstance.deleteGame(index)
            readData()
            self.statsTable.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
        }
    }

}