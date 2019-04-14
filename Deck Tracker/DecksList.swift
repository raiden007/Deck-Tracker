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
    
    // Save to iCloud
    var iCloudKeyStore: NSUbiquitousKeyValueStore = NSUbiquitousKeyValueStore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        refreshData()
        
        // Listens for "Deck Selected" and calls refreshData()
        NotificationCenter.default.addObserver(self, selector: #selector(DecksList.refreshData), name: NSNotification.Name(rawValue: "DeckSelected"), object: nil)
        
        // Removes the empty rows from view
        decksTable.tableFooterView = UIView(frame: CGRect.zero)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Gets the number of rows to be displayed in the table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return decksList.count
    }
    
    // Populates the table with data
    private func tableView(_ tableView: UITableView, cellForRowAtIndexPath indexPath: IndexPath) -> UITableViewCell {
        let cell:CustomCell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! CustomCell
        cell.customLabel.text = decksList[indexPath.row].getName()
        let image = decksList[indexPath.row].getClass()
        let imageName = getImage(image)
        cell.customImage.image = UIImage(named: imageName)
        // If there is a selected deck put a checkmark on it
        if indexPath.row == indexOfSelectedDeck {
            cell.accessoryType = UITableViewCellAccessoryType.checkmark
        } else {
            cell.accessoryType = UITableViewCellAccessoryType.none
        }
        return cell
    }
    
    // Selects the row and saves the info so we can add a checkmark
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.accessoryType = UITableViewCellAccessoryType.checkmark
        let selectedDeck = decksList[indexPath.row]
        saveSelectedDeckID(selectedDeck)
        saveSelectedDeckName(selectedDeck)
        saveSelectedDeckClass(selectedDeck)
        indexOfSelectedDeck = indexPath.row
        tableView.reloadData()
        navigationController?.popViewController(animated: true)
    }
    
    // Saves the selected deck ID in NSUserDefaults
    func saveSelectedDeckID(_ deck : Deck) {
        let defaults = UserDefaults(suiteName: "group.Decks")!
        defaults.set(deck.getID(), forKey: "Selected Deck ID")
        defaults.synchronize()
    }
    
    // Reads the selected deck ID from NSUserDefaults
    func readSelectedDeckID() -> Int {
        let defaults = UserDefaults(suiteName: "group.Decks")!
        let id:Int = defaults.integer(forKey: "Selected Deck ID")
        return id
    }
    
    // Saves the selected deck name in NSUserDefaults and iCloud
    func saveSelectedDeckName(_ deck: Deck) {
        let defaults: UserDefaults = UserDefaults(suiteName: "group.Decks")!
        defaults.set(deck.getName(), forKey: "Selected Deck Name")
        defaults.synchronize()
        
        iCloudKeyStore.set(deck.getName(), forKey: "iCloud Selected Deck Name")
        iCloudKeyStore.synchronize()
    }
    
    // Saves the selected deck class
    func saveSelectedDeckClass( _ deck: Deck) {
        let defaults = UserDefaults(suiteName: "group.Decks")!
        defaults.set(deck.getClass(), forKey: "Selected Deck Class")
        defaults.synchronize()
    }
    
    // Returns the selected deck name
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
    
    // Deselects the row if you select another
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.accessoryType = UITableViewCellAccessoryType.none
    }
    
    // Refreshes the view after adding a deck
    override func viewDidAppear(_ animated: Bool) {
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
    func tableView(_ tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            
            let index = indexPath.row
            
            
            
            // Alert to also delete the games with the deck in them
            // Create the alert controller
            let alertController = UIAlertController(title: "Delete games?", message: "Do you want also to delete all the games recorded with this deck ?", preferredStyle: .alert)
            
            // Create the actions
            let okAction = UIAlertAction(title: "Yes", style: UIAlertActionStyle.destructive) {
                UIAlertAction in
                NSLog("Yes Pressed")
                
                // Delete the games
                let deckName = self.decksList[index].getName()
                Data.sharedInstance.deleteAllGamesAssociatedWithADeck(deckName)
                
                // Delete the deck
                Data.sharedInstance.deleteDeck(index)
                self.readData()
                self.decksTable.deleteRows(at: [indexPath], with: UITableViewRowAnimation.fade)
                
            }
            let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel) {
                UIAlertAction in
                NSLog("Cancel Pressed")
                // Delete the deck
                Data.sharedInstance.deleteDeck(index)
                self.readData()
                self.decksTable.deleteRows(at: [indexPath], with: UITableViewRowAnimation.fade)
            }
            
            // Add the actions
            alertController.addAction(okAction)
            alertController.addAction(cancelAction)
            
            // Present the controller
            self.present(alertController, animated: true, completion: nil)
            

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
    
    func refreshData() {
        readData()
        decksTable.reloadData()
        
        // If there is a deck selected get it's index
        let savedUserDefaults = readSelectedDeckID()
        for i in 0 ..< decksList.count {
            if savedUserDefaults == decksList[i].getID() {
                indexOfSelectedDeck = i
                break
            }
        }
    }
}

