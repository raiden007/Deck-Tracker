//
//  DecksList.swift
//  Deck Tracker
//
//  Created by Andrei Joghiu on 28/4/15.
//  Copyright (c) 2015 Andrei Joghiu. All rights reserved.
//

import UIKit

class DecksList: UIViewController, UITableViewDelegate, UINavigationBarDelegate {
    
    @IBOutlet var decksTable: UITableView!
    
    var decksList:[Deck] = []
    var indexOfSelectedDeck:Int = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        refreshData()
        
        // Listens for "Deck Selected" and calls refreshData()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "refreshData", name: "DeckSelected", object: nil)
        
        // Removes the empty rows from view
        decksTable.tableFooterView = UIView(frame: CGRectZero)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Gets the number of rows to be displayed in the table
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return decksList.count
    }
    
    // Populates the table with data
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:CustomCell = tableView.dequeueReusableCellWithIdentifier("Cell") as! CustomCell
        cell.customLabel.text = decksList[indexPath.row].getName()
        let image = decksList[indexPath.row].getClass()
        let imageName = getImage(image)
        cell.customImage.image = UIImage(named: imageName)
        // If there is a selected deck put a checkmark on it
        if indexPath.row == indexOfSelectedDeck {
            cell.accessoryType = UITableViewCellAccessoryType.Checkmark
        } else {
            cell.accessoryType = UITableViewCellAccessoryType.None
        }
        return cell
    }
    
    // Selects the row and saves the info so we can add a checkmark
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        cell?.accessoryType = UITableViewCellAccessoryType.Checkmark
        let selectedDeck = decksList[indexPath.row]
        saveSelectedDeckID(selectedDeck)
        saveSelectedDeckName(selectedDeck)
        saveSelectedDeckClass(selectedDeck)
        indexOfSelectedDeck = indexPath.row
        tableView.reloadData()
        navigationController?.popViewControllerAnimated(true)
    }
    
    // Saves the selected deck ID in NSUserDefaults
    func saveSelectedDeckID(deck : Deck) {
        let defaults = NSUserDefaults(suiteName: "group.Decks")!
        defaults.setInteger(deck.getID(), forKey: "Selected Deck ID")
        defaults.synchronize()
    }
    
    // Reads the selected deck ID from NSUserDefaults
    func readSelectedDeckID() -> Int {
        let defaults = NSUserDefaults(suiteName: "group.Decks")!
        let id:Int = defaults.integerForKey("Selected Deck ID")
        return id
    }
    
    // Saves the selected deck name in NSUserDefaults
    func saveSelectedDeckName(deck: Deck) {
        let defaults: NSUserDefaults = NSUserDefaults(suiteName: "group.Decks")!
        defaults.setObject(deck.getName(), forKey: "Selected Deck Name")
        defaults.synchronize()
    }
    
    // Saves the selected deck class
    func saveSelectedDeckClass( deck: Deck) {
        let defaults = NSUserDefaults(suiteName: "group.Decks")!
        defaults.setObject(deck.getClass(), forKey: "Selected Deck Class")
        defaults.synchronize()
    }
    
    // Returns the selected deck name
    func readSelectedDeckName() -> String {
        let defaults = NSUserDefaults(suiteName: "group.Decks")!
        let name = defaults.stringForKey("Selected Deck Name") as String!
        if name == nil {
            return ""
        } else {
            return name
        }
        
    }
    
    // Deselects the row if you select another
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        cell?.accessoryType = UITableViewCellAccessoryType.None
    }
    
    // Refreshes the view after adding a deck
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        refreshData()
    }
    
    // Reads the data from Data file
    func readData() {
        if Data.sharedInstance.readDeckData() == nil {
            decksList = []
        } else {
            decksList = Data.sharedInstance.listOfDecks
        }
    }
    
    // Deletes the row
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            
            let index = indexPath.row
            
            
            
            // Alert to also delete the games with the deck in them
            // Create the alert controller
            let alertController = UIAlertController(title: "Delete games?", message: "Do you want also to delete all the games recorded with this deck ?", preferredStyle: .Alert)
            
            // Create the actions
            let okAction = UIAlertAction(title: "Yes", style: UIAlertActionStyle.Destructive) {
                UIAlertAction in
                NSLog("Yes Pressed")
                
                // Delete the games
                let deckName = self.decksList[index].getName()
                Data.sharedInstance.deleteAllGamesAssociatedWithADeck(deckName)
                
                // Delete the deck
                Data.sharedInstance.deleteDeck(index)
                self.readData()
                self.decksTable.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
                
            }
            let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel) {
                UIAlertAction in
                NSLog("Cancel Pressed")
                // Delete the deck
                Data.sharedInstance.deleteDeck(index)
                self.readData()
                self.decksTable.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
            }
            
            // Add the actions
            alertController.addAction(okAction)
            alertController.addAction(cancelAction)
            
            // Present the controller
            self.presentViewController(alertController, animated: true, completion: nil)
            

        }
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
    
    func refreshData() {
        readData()
        decksTable.reloadData()
        
        // If there is a deck selected get it's index
        let savedUserDefaults = readSelectedDeckID()
        for var i = 0; i < decksList.count; i++ {
            if savedUserDefaults == decksList[i].getID() {
                indexOfSelectedDeck = i
                break
            }
        }
    }
}

