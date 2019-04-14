//
//  SelectDeck.swift
//  Deck Tracker
//
//  Created by Andrei Joghiu on 8/5/15.
//  Copyright (c) 2015 Andrei Joghiu. All rights reserved.
//

import UIKit

class SelectDeck: UITableViewController {
    
    @IBOutlet var decksTable: UITableView!
    
    var decksList:[Deck] = []
    var indexOfSelectedDeck:Int = -1
    var iCloudKeyStore: NSUbiquitousKeyValueStore = NSUbiquitousKeyValueStore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        readData()
        
        // If there is a deck selected get it's index
        let savedUserDefaults = readSelectedDeckID()
        for i in 0 ..< decksList.count {
            if savedUserDefaults == decksList[i].getID() {
                indexOfSelectedDeck = i
                break
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Gets the number of rows to be displayed in the table
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return decksList.count
    }
    
    // Populates the table with data
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "Cell")
        //let cell:CustomCell = tableView.dequeueReusableCellWithIdentifier("Cell") as! CustomCell
        cell.textLabel?.text = decksList[indexPath.row].getName()
        let image = decksList[indexPath.row].getClass()
        let imageName = getImage(image)
        cell.imageView?.image = UIImage(named: imageName)
        //cell.accessoryType = UITableViewCellAccessoryType.None
        // If there is a selected deck put a checkmark on it
        if indexPath.row == indexOfSelectedDeck {
            cell.accessoryType = UITableViewCellAccessoryType.Checkmark
        } else {
            cell.accessoryType = UITableViewCellAccessoryType.None
        }
        return cell
    }
    
    // Selects the row and saves the info so we can add a checkmark
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        cell?.accessoryType = UITableViewCellAccessoryType.Checkmark
        let selectedDeck = decksList[indexPath.row]
        saveSelectedDeckID(selectedDeck)
        readSelectedDeckID()
        saveSelectedDeckName(selectedDeck)
        readSelectedDeckName()
        saveSelectedDeckClass(selectedDeck)
        indexOfSelectedDeck = indexPath.row
        tableView.reloadData()
        navigationController?.popToRootViewControllerAnimated(true)
    }
    
    // Saves the selected deck ID in NSUserDefaults
    func saveSelectedDeckID(deck : Deck) {
        let defaults = NSUserDefaults(suiteName: "group.Decks")!
        defaults.setInteger(deck.getID(), forKey: "Selected Deck ID")
        defaults.synchronize()
    }
    
    // Reads the selected deck ID from NSUserDefaults
    func readSelectedDeckID() -> Int {
        let defaults = NSUserDefaults.standardUserDefaults()
        let id:Int = defaults.integerForKey("Selected Deck ID")
        return id
    }
    
    // Saves the selected deck name in NSUserDefaults
    func saveSelectedDeckName(deck: Deck) {
        let defaults: NSUserDefaults = NSUserDefaults(suiteName: "group.Decks")!
        defaults.setObject(deck.getName(), forKey: "Selected Deck Name")
        defaults.synchronize()
        
        iCloudKeyStore.setObject(deck.getName(), forKey: "iCloud Selected Deck Name")
        iCloudKeyStore.synchronize()
    }
    
    // Reads the saved deck
    func readSelectedDeckName() -> String {
        let defaults = NSUserDefaults(suiteName: "group.Decks")!
        var name = ""
        if let _ = iCloudKeyStore.stringForKey("iCloud Selected Deck Name") {
            name = iCloudKeyStore.stringForKey("iCloud Selected Deck Name")!
        } else if let _ = defaults.stringForKey("Selected Deck Name") {
            name = defaults.stringForKey("Selected Deck Name")!
        }
        
        return name
    }
    
    // Saves the selected deck class
    func saveSelectedDeckClass( deck: Deck) {
        let defaults: NSUserDefaults = NSUserDefaults(suiteName: "group.Decks")!
        defaults.setObject(deck.getClass(), forKey: "Selected Deck Class")
        defaults.synchronize()
    }
    
    // Deselects the row if you select another
    override func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        cell?.accessoryType = UITableViewCellAccessoryType.None
    }
    
    // Refreshes the view after adding a deck
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        readData()
        decksTable.reloadData()
    }
    
    // Reads the data from Data file
    func readData() {
        if Data.sharedInstance.readDeckData() == nil {
            
        } else {
            decksList = Data.sharedInstance.listOfDecks
        }
    }
    
    // Deletes the row
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            let index = indexPath.row
            Data.sharedInstance.deleteDeck(index)
            readData()
            self.decksTable.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
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
}



