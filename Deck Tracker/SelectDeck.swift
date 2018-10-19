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
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return decksList.count
    }
    
    // Populates the table with data
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "Cell")
        //let cell:CustomCell = tableView.dequeueReusableCellWithIdentifier("Cell") as! CustomCell
        cell.textLabel?.text = decksList[indexPath.row].getName()
        let image = decksList[indexPath.row].getClass()
        let imageName = getImage(image)
        cell.imageView?.image = UIImage(named: imageName)
        //cell.accessoryType = UITableViewCellAccessoryType.None
        // If there is a selected deck put a checkmark on it
        if indexPath.row == indexOfSelectedDeck {
            cell.accessoryType = UITableViewCell.AccessoryType.checkmark
        } else {
            cell.accessoryType = UITableViewCell.AccessoryType.none
        }
        return cell
    }
    
    // Selects the row and saves the info so we can add a checkmark
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.accessoryType = UITableViewCell.AccessoryType.checkmark
        let selectedDeck = decksList[indexPath.row]
        saveSelectedDeckID(selectedDeck)
        saveSelectedDeckName(selectedDeck)
        saveSelectedDeckClass(selectedDeck)
        indexOfSelectedDeck = indexPath.row
        tableView.reloadData()
        navigationController?.popToRootViewController(animated: true)
    }
    
    // Saves the selected deck ID in NSUserDefaults
    func saveSelectedDeckID(_ deck : Deck) {
        let defaults = UserDefaults(suiteName: "group.Decks")!
        defaults.set(deck.getID(), forKey: "Selected Deck ID")
        defaults.synchronize()
    }
    
    // Reads the selected deck ID from NSUserDefaults
    func readSelectedDeckID() -> Int {
        let defaults = UserDefaults.standard
        let id:Int = defaults.integer(forKey: "Selected Deck ID")
        return id
    }
    
    // Saves the selected deck name in NSUserDefaults
    func saveSelectedDeckName(_ deck: Deck) {
        let defaults: UserDefaults = UserDefaults(suiteName: "group.Decks")!
        defaults.set(deck.getName(), forKey: "Selected Deck Name")
        defaults.synchronize()
        
        iCloudKeyStore.set(deck.getName(), forKey: "iCloud Selected Deck Name")
        iCloudKeyStore.synchronize()
    }
    
    // Reads the saved deck
    func readSelectedDeckName() -> String {
        let defaults = UserDefaults(suiteName: "group.Decks")!
        var name = ""
        if let _ = iCloudKeyStore.string(forKey: "iCloud Selected Deck Name") {
            name = iCloudKeyStore.string(forKey: "iCloud Selected Deck Name")!
        } else if let _ = defaults.string(forKey: "Selected Deck Name") {
            name = defaults.string(forKey: "Selected Deck Name")!
        }
        
        return name
    }
    
    // Saves the selected deck class
    func saveSelectedDeckClass( _ deck: Deck) {
        let defaults: UserDefaults = UserDefaults(suiteName: "group.Decks")!
        defaults.set(deck.getClass(), forKey: "Selected Deck Class")
        defaults.synchronize()
    }
    
    // Deselects the row if you select another
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.accessoryType = UITableViewCell.AccessoryType.none
    }
    
    // Refreshes the view after adding a deck
    override func viewDidAppear(_ animated: Bool) {
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
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            let index = indexPath.row
            Data.sharedInstance.deleteDeck(index)
            readData()
            self.decksTable.deleteRows(at: [indexPath], with: UITableView.RowAnimation.fade)
        }
    }
    
    // Returns the image depeding on the deck class
    func getImage (_ str:String) -> String {
        
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



