//
//  AddGame.swift
//  Deck Tracker
//
//  Created by Andrei Joghiu on 7/5/15.
//  Copyright (c) 2015 Andrei Joghiu. All rights reserved.
//

import UIKit
import Fabric
import Crashlytics

class AddGame: UITableViewController, UINavigationBarDelegate  {
    
    @IBOutlet var addGameList: UITableView!
    @IBOutlet var saveButton: UIBarButtonItem!
    @IBOutlet var cancelButton: UIBarButtonItem!
    @IBOutlet var dateCell: UITableViewCell!
    @IBOutlet var dateCellLabel: UILabel!
    @IBOutlet var playerDeckCell: UITableViewCell!
    @IBOutlet var playerDeckLabel: UILabel!
    @IBOutlet var opponentDeckCell: UITableViewCell!
    @IBOutlet var opponentDeckLabel: UILabel!
    @IBOutlet var coinCell: UITableViewCell!
    @IBOutlet var coinCellLabel: UILabel!
    @IBOutlet var coinCellSwitch: UISwitch!
    @IBOutlet var winCell: UITableViewCell!
    @IBOutlet var winCellLabel: UILabel!
    @IBOutlet var winCellSwitch: UISwitch!
    @IBOutlet weak var tagsLabel: UILabel!

    var tag = ""
    var iCloudKeyStore: NSUbiquitousKeyValueStore = NSUbiquitousKeyValueStore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Puts today date on the date label
        let today = dateToday()
        dateCellLabel.text = "Date: " + today
        putSelectedDeckNameOnLabel()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // Populates the rows with data
        putSelectedDateOnLabel()
        putSelectedDeckNameOnLabel()
        putSelectedOpponentClassOnLabel()
        putTagLabel()
    }
    
    func putSelectedDateOnLabel() {
        // Puts the selected date on the date label
        let x = SelectDate()
        let newDate = x.readDate()
        let newDateString = x.dateToString(newDate)
        dateCellLabel.text = "Date: " + newDateString
    }
    
    
    func readSelectedDeckName() -> String {
        // Reads the selected deck name from iCloud or NSUserDefaults
        let defaults = UserDefaults(suiteName: "group.Decks")!
        var name = ""
        if let _ = iCloudKeyStore.string(forKey: "iCloud Selected Deck Name") {
            name = iCloudKeyStore.string(forKey: "iCloud Selected Deck Name")!
        } else if let _ = defaults.string(forKey: "Selected Deck Name") {
            name = defaults.string(forKey: "Selected Deck Name")!
        }
        
        return name
    }
    
    
    func putSelectedDeckNameOnLabel() {
        // Gets the selected deck from NSUserDefaults and puts it on the label
        let selectedDeck = readSelectedDeckName()
        if selectedDeck == "" {
            playerDeckLabel.text = "You need to select a deck first"
        } else {
            playerDeckLabel.text = "Your deck: " + selectedDeck
        }
    }
    
    
    func putSelectedOpponentClassOnLabel() {
        // Puts opponent's class in NSUserDefaults
        let selectedOpponentClass = readSelectedOpponentClass()
        if selectedOpponentClass == "" {
            opponentDeckLabel.text = "Select Opponent's Class"
        } else {
            opponentDeckLabel.text = "Opponent's class: " + selectedOpponentClass
        }
    }
    
    
    func readSelectedOpponentClass() -> String {
        // Reads the selected opponent's class from NSUserDefaults
        let defaults = UserDefaults.standard
        if let name:String = defaults.string(forKey: "Opponent Class") as String! {
            return name
        } else {
            return ""
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Have the nav bar show ok.
    // You need to crtl+drag the nav bar to the view controller in storyboard to create a delegate
    // Then add "UINavigationBarDelegate" to the class on top
    // And move the nav bar 20 points down
    func position(for bar: UIBarPositioning) -> UIBarPosition  {
        return UIBarPosition.topAttached
    }
    
    
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        // Remove the selected date and selected opponent class from NSUserDefaults and dismissed the screen
        let defaults: UserDefaults = UserDefaults.standard
        defaults.removeObject(forKey: "Saved Date")
        defaults.removeObject(forKey: "Opponent Class")
        defaults.removeObject(forKey: "Selected Tag")
        defaults.synchronize()
        self.dismiss(animated: true, completion: {})
    }
    
    
    
    func dateToday() -> String {
        // Get today's date as a String
        let now = Date()
        let formatter = DateFormatter()
        formatter.dateStyle = DateFormatter.Style.short
        let dateString = formatter.string(from: now)
        return dateString
    }
    
    
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        // Removes the selected date, opponent class and selected tag from NSUserDefaults and sends all the info to the Game List
        let defaults: UserDefaults = UserDefaults.standard

        
        // Gets all the atributes for a new Game
        let newGameID = newGameGetID()
        let newGameDate = SelectDate().readDate()
        
        // Gets the selected deck name
        var newGamePlayerDeckName = ""
        if let _ = iCloudKeyStore.string(forKey: "iCloud Selected Deck Name") {
            newGamePlayerDeckName = iCloudKeyStore.string(forKey: "iCloud Selected Deck Name")!
        } else if let _ = UserDefaults(suiteName: "group.Decks")!.string(forKey: "Selected Deck Name") {
            newGamePlayerDeckName = UserDefaults(suiteName: "group.Decks")!.string(forKey: "Selected Deck Name")!
        }
        let newGamePlayerDeckClass = UserDefaults(suiteName: "group.Decks")!.string(forKey: "Selected Deck Class") as String?
        let newGameOpponentClass = defaults.string(forKey: "Opponent Class") as String?
        let newGameCoin = coinCellSwitch.isOn
        let newGameWin = winCellSwitch.isOn
        let newGameTag = tag

        
        if newGamePlayerDeckName != "" && newGameOpponentClass != nil {
            
            // Adds a new game
            let newGame = Game(newID: newGameID, newDate: newGameDate, newPlayerDeckName: newGamePlayerDeckName, newPlayerDeckClass:newGamePlayerDeckClass! , newOpponentDeck: newGameOpponentClass!, newCoin: newGameCoin, newWin: newGameWin, newTag: newGameTag)
            // Add to Data class file
            Data.sharedInstance.addGame(newGame)
            self.dismiss(animated: true, completion: {})
            
            // Crashlytics custom events
            var winString = ""
            if newGameWin == true {
                winString = "Win"
            } else {
                winString = "Loss"
            }
            
            var tagString = ""
            if newGameTag == "" {
                tagString = "No tag"
            } else {
                tagString = newGameTag
            }
            
            let device = UIDevice.current.model
            
            Answers.logCustomEvent(withName: "New game added",
                customAttributes: [
                    "Deck Name": newGamePlayerDeckName,
                    "Deck Class": newGamePlayerDeckClass!,
                    "Opponent Class": newGameOpponentClass!,
                    "Win": winString,
                    "Tag": tagString,
                    "Added from": device
                ])
            
        } else {
            if newGamePlayerDeckName == "" && newGameOpponentClass == nil {
                let alert = UIAlertView()
                alert.title = "Missing Info"
                alert.message = "You need to enter all required info"
                alert.addButton(withTitle: "OK")
                alert.show()
            } else if newGamePlayerDeckName == "" {
                let alert = UIAlertView()
                alert.title = "Missing Info"
                alert.message = "You need to select a deck"
                alert.addButton(withTitle: "OK")
                alert.show()
            } else if newGameOpponentClass == nil {
                let alert = UIAlertView()
                alert.title = "Missing Info"
                alert.message = "You need to select your opponent's class"
                alert.addButton(withTitle: "OK")
                alert.show()
            } else {
                let alert = UIAlertView()
                alert.title = "Missing Info"
                alert.message = "You need to enter all required info"
                alert.addButton(withTitle: "OK")
                alert.show()
            }

        }
        
        // Deletes the date, opponent class and selected tag so the user needs to select again
        defaults.removeObject(forKey: "Saved Date")
        defaults.removeObject(forKey: "Opponent Class")
        defaults.removeObject(forKey: "Selected Tag")
        defaults.synchronize()
    }
    
    // Gets the ID for a new Game
    func newGameGetID () -> Int {
        var matchesCount = UserDefaults.standard.integer(forKey: "Matches Count")
        if let _ = iCloudKeyStore.object(forKey: "iCloud Matches Count") {
            matchesCount = iCloudKeyStore.object(forKey: "iCloud Matches Count") as! Int
        }
        matchesCount += 1
        UserDefaults.standard.set(matchesCount, forKey: "Matches Count");
        UserDefaults.standard.synchronize()
        iCloudKeyStore.set(matchesCount, forKey: "iCloud Matches Count")
        iCloudKeyStore.synchronize()
        
        return matchesCount
    }
    
    // Puts the tags on the Tags Label
    func putTagLabel() {
        let defaults = UserDefaults.standard
        if let _ = defaults.string(forKey: "Selected Tag") {
            tag = defaults.string(forKey: "Selected Tag") as String!
        }
        if tag.isEmpty {
            tagsLabel.text = "Add Tags"
        } else {
            tagsLabel.text = "Tags: " + tag
        }
    }
}
