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
        cell.winPercentLabel.text = "80%"
        cell.gamesListLabel.text = "21-10"
        

        return cell
    }
    
    func loadList(notification: NSNotification){
        //Gets info on rows and reloads the table view
        loadData()
        
    }
    
    func loadData() {
        //TODO: Load all data needed to display the table view
        getDateIndex()
        getDeckName()
        getPlayerDeckLabel()
        getPlayerDeckIcon()
        self.graphsTable.reloadData()
    }
    
    func getDateIndex() {
        dateIndex = NSUserDefaults.standardUserDefaults().integerForKey("Date Index")
        print("Date Index is: " + String(dateIndex))
    }
    
    func getDeckName() {
        if let _ =  NSUserDefaults.standardUserDefaults().stringForKey("Deck Name") as String! {
            deckName = NSUserDefaults.standardUserDefaults().stringForKey("Deck Name") as String!
        } else {
            deckName = ""
        }
        print("Deck Name is: " + deckName)
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

}
