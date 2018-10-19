//
//  EditSelectedDeck.swift
//  Deck Tracker
//
//  Created by Andrei Joghiu on 14/5/15.
//  Copyright (c) 2015 Andrei Joghiu. All rights reserved.
//

import Foundation
import UIKit


class EditSelectedDeck: UIViewController, UITableViewDelegate, UINavigationBarDelegate {
    
    @IBOutlet var decksTable: UITableView!
    
    var decksList:[Deck] = []
    var indexOfSelectedDeck:Int = -1
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        readData()
        
        // If there is a deck selected get it's index
        let savedUserDefaults = readEditedDeckID()
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
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return decksList.count
    }
    
    // Populates the table with data
    private func tableView(_ tableView: UITableView, cellForRowAtIndexPath indexPath: IndexPath) -> UITableViewCell {
        //let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "Cell")
        let cell:CustomCell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! CustomCell
        cell.customLabel.text = decksList[indexPath.row].getName()
        let image = decksList[indexPath.row].getClass()
        let imageName = getImage(image)
        cell.customImage.image = UIImage(named: imageName)
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.accessoryType = UITableViewCell.AccessoryType.checkmark
        let selectedDeck = decksList[indexPath.row]
        saveEditedDeckID(selectedDeck)
        saveEditedDeckName(selectedDeck)
        saveEditedDeckClass(selectedDeck)
        indexOfSelectedDeck = indexPath.row
        tableView.reloadData()
        navigationController?.popViewController(animated: true)
    }
    
    // Saves the selected deck ID in NSUserDefaults
    func saveEditedDeckID(_ deck : Deck) {
        let defaults: UserDefaults = UserDefaults.standard
        defaults.set(deck.getID(), forKey: "Edited Deck ID")
        defaults.synchronize()
    }
    
    // Reads the selected deck ID from NSUserDefaults
    func readEditedDeckID() -> Int {
        let defaults = UserDefaults.standard
        let id:Int = defaults.integer(forKey: "Edited Deck ID")
        return id
    }
    
    // Saves the selected deck name in NSUserDefaults
    func saveEditedDeckName(_ deck: Deck) {
        let defaults: UserDefaults = UserDefaults(suiteName: "group.Decks")!
        defaults.set(deck.getName(), forKey: "Edited Deck Name")
        defaults.synchronize()
    }
    
    // Saves the selected deck class
    func saveEditedDeckClass(_ deck: Deck) {
        let defaults: UserDefaults = UserDefaults(suiteName: "group.Decks")!
        defaults.set(deck.getClass(), forKey: "Edited Deck Class")
        defaults.synchronize()
    }
    
    // Reads the edited deck name
    func readEditedDeckName() -> String {
        let defaults = UserDefaults(suiteName: "group.Decks")!
        let name = defaults.string(forKey: "Edited Deck Name")
        if name == nil {
            return ""
        } else {
            return name!
        }
        
    }
    
    // Deselects the row if you select another
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.accessoryType = UITableViewCell.AccessoryType.none
    }
    
    // Refreshes the view after adding a deck
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        readData()
        decksTable.reloadData()
        
        // If there is a deck selected get it's index
        let savedUserDefaults = readEditedDeckID()
        for i in 0 ..< decksList.count {
            if savedUserDefaults == decksList[i].getID() {
                indexOfSelectedDeck = i
                break
            }
        }
    }
    
    // Reads the data from Data file
    func readData() {
        if Data.sharedInstance.readDeckData() == nil {
            
        } else {
            decksList = Data.sharedInstance.listOfDecks
        }
    }
    
    // Deletes the row
    func tableView(_ tableView: UITableView, commitEditingStyle editingStyle: UITableViewCell.EditingStyle, forRowAtIndexPath indexPath: IndexPath) {
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

