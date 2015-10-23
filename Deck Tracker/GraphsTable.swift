//
//  GraphsTable.swift
//  Deck Tracker
//
//  Created by Andrei Joghiu on 27/09/15.
//  Copyright © 2015 Andrei Joghiu. All rights reserved.
//

import UIKit

class GraphsTable: UITableViewController {

    @IBOutlet var graphsTable: UITableView!
    
    
    var dateIndex = -1
    var deckName = ""
    var playerDeckLabelArray:[String] = []
    var playerDeckIcon = ""
    var opponentClasses = ["GenericSmall", "WarriorSmall", "PaladinSmall", "ShamanSmall", "HunterSmall", "DruidSmall", "RogueSmall", "MageSmall", "WarlockSmall", "PriestSmall"]
    var winRateArray:[Int] = []
    var gamesWonArray:[Int] = []
    var gamesLostArray:[Int] = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "loadList:",name:"load", object: nil)

    }
    
    override func viewDidAppear(animated: Bool) {
        loadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 10
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        let cell:GraphsCell = tableView.dequeueReusableCellWithIdentifier("Cell") as! GraphsCell

        // Configure the cell...
        cell.playerDeckIcon.image = UIImage(named: playerDeckIcon)
        cell.playerDeckLabel.text = playerDeckLabelArray[indexPath.row]
        cell.opponentClassIcon.image = UIImage(named: opponentClasses[indexPath.row])
        cell.winPercentLabel.text = String(winRateArray[indexPath.row]) + "%"
        cell.gamesListLabel.text = String(gamesWonArray[indexPath.row]) + "-" + String(gamesLostArray[indexPath.row])

//        if winRateArray[indexPath.row] > 50 {
//            cell.winPercentLabel.textColor = UIColor.greenColor()
//        }
        
        return cell
    }
    
    func loadList(notification: NSNotification){
        //Gets info on rows and reloads the table view
        loadData()
    }
    
    func loadData() {
        getDateIndex()
        getDeckName()
        getPlayerDeckLabel()
        getPlayerDeckIcon()
        getStatistics()
        self.graphsTable.reloadData()
    }
    
    func getDateIndex() {
        dateIndex = NSUserDefaults.standardUserDefaults().integerForKey("Date Index")
        //print("Date Index is: " + String(dateIndex))
    }
    
    func getDeckName() {
        if let _ =  NSUserDefaults.standardUserDefaults().stringForKey("Deck Name") as String! {
            deckName = NSUserDefaults.standardUserDefaults().stringForKey("Deck Name") as String!
        } else {
            deckName = ""
        }
        //print("Deck Name is: " + deckName)
    }
    
    func getPlayerDeckLabel() {
        playerDeckLabelArray = []
        if deckName == "All" {
            for var i = 0; i < 10; i++ {
                playerDeckLabelArray.append("All Decks")
            }
        } else {
            for var i = 0; i < 10; i++ {
                playerDeckLabelArray.append(deckName)
            }
        }
    }
    
    func getPlayerDeckIcon() {
        if deckName == "All" {
            playerDeckIcon = "GenericSmall"
        } else {
            var selectedDeckClass = ""
            if let _ = NSUserDefaults(suiteName: "group.Decks")!.stringForKey("Selected Deck Class") as String! {
                selectedDeckClass = NSUserDefaults(suiteName: "group.Decks")!.stringForKey("Selected Deck Class") as String!
            }
            
            if selectedDeckClass == "" {
               playerDeckIcon = "GenericSmall"
            } else {
                playerDeckIcon = DecksList().getImage(selectedDeckClass)
            }
        }
    }
    
    func getStatistics() {
        
        winRateArray = []
        gamesWonArray = []
        gamesLostArray = []
        
        let data = ["All", "Warrior", "Paladin", "Shaman", "Hunter", "Druid", "Rogue", "Mage", "Warlock", "Priest"]
        for opponent in data {
            getStatisticsVs(opponent)
        }
    }
    
    func getStatisticsVs(opponent:String) {
        var filteredGames:[Game] = []
        var totalGames = 0
        var wonGames = 0
        var lostGames = 0
        
        filteredGames = Data.sharedInstance.getStatisticsGamesTotal(dateIndex, deck: deckName, opponent: opponent)
        totalGames = filteredGames.count
        
        for game in filteredGames {
            if game.getWin() == true {
                wonGames++
            } else {
                lostGames++
            }
        }
        
        var winRateDouble:Double = 0
        if totalGames != 0 {
           winRateDouble =  Double(wonGames) / Double(totalGames) * 100
        }
        
        let winRateInt = Int(winRateDouble)
        
        
        //print("Total Games: " + String(totalGames))
        //print("Games Won: " + String(wonGames))
        //print("Games Lost: " + String(lostGames))
        //print("Win Rate: " + String(winRateInt))
        
        winRateArray.append(winRateInt)
        gamesWonArray.append(wonGames)
        gamesLostArray.append(lostGames)

    }
    
    // Saves the selected Game so it can display it's info in the next screen
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var selectedOpponent = ""
        let rowNumber = indexPath.row
        
        if rowNumber == 0 {
            selectedOpponent = "All"
        } else if rowNumber == 1 {
            selectedOpponent = "Warrior"
        } else if rowNumber == 2 {
            selectedOpponent = "Paladin"
        } else if rowNumber == 3 {
            selectedOpponent = "Shaman"
        } else if rowNumber == 4 {
            selectedOpponent = "Hunter"
        } else if rowNumber == 5 {
            selectedOpponent = "Druid"
        } else if rowNumber == 6 {
            selectedOpponent = "Rogue"
        } else if rowNumber == 7 {
            selectedOpponent = "Mage"
        } else if rowNumber == 8 {
            selectedOpponent = "Warlock"
        } else if rowNumber == 9 {
            selectedOpponent = "Priest"
        }
        //print(selectedOpponent)
        NSUserDefaults.standardUserDefaults().setObject(selectedOpponent, forKey: "Graphs selected opponent")
        NSUserDefaults.standardUserDefaults().synchronize()
    }

}
