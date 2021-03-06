//
//  EditGame.swift
//  Deck Tracker
//
//  Created by Andrei Joghiu on 12/5/15.
//  Copyright (c) 2015 Andrei Joghiu. All rights reserved.
//

import UIKit

class EditGame: UITableViewController, UINavigationBarDelegate {
    
    @IBOutlet var cancelButton: UIBarButtonItem!
    @IBOutlet var saveButton: UIBarButtonItem!
    @IBOutlet var dateCell: UITableViewCell!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var playerDeckCell: UITableViewCell!
    @IBOutlet var playerDeckLabel: UILabel!
    @IBOutlet var opponentDeckCell: UITableViewCell!
    @IBOutlet var opponentDeckLabel: UILabel!
    @IBOutlet var coinCell: UITableViewCell!
    @IBOutlet var coinSwitch: UISwitch!
    @IBOutlet var winCell: UITableViewCell!
    @IBOutlet var winSwitch: UISwitch!
    @IBOutlet var tagsLabel: UILabel!
    

    var defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
    var selectedGameArray:[Game] = []
    var selectedGame:Game = Game(newID: 1, newDate: NSDate(), newPlayerDeckName: "1", newPlayerDeckClass: "1", newOpponentDeck: "1", newCoin: true, newWin: true, newTag: "")
    static let sharedInstance = EditGame()
    var selectedTag: String = ""
    

    override func viewDidLoad() {
        super.viewDidLoad()
        selectedGameArray = StatsList.sharedInstance.readSelectedGame() as [Game]!
        selectedGame = selectedGameArray[0]

        // Populates the screen with data
        populateScreen()
    }
    
    // Populates the screen with latest data
    override func viewDidAppear(animated: Bool) {
        // Populates the screen with data
        populateScreen()
    }
    
    
    func populateScreen() {
        // Populates the screen with data
        putSavedDateOnLabel()
        putSavedPlayerDeckOnLabel()
        putSavedOpponentClassOnLabel()
        putSavedCoinStatusOnSwitch()
        putSavedWinStatusOnSwitch()
        putSavedTagOnLabel()
    }
    
    // Puts saved date on label
    func putSavedDateOnLabel() {
        let editedDate:NSDate! = defaults.objectForKey("Saved Edited Date") as? NSDate
        if editedDate != nil {
            let formatter = NSDateFormatter()
            formatter.dateStyle = NSDateFormatterStyle.ShortStyle
            let dateString = formatter.stringFromDate(editedDate)
            dateLabel.text = "Date: " + dateString
        } else {
            let savedDate = selectedGame.getDate()
            dateLabel.text = "Date: " + savedDate
        }

    }
    
    // Puts selected deck on label
    func putSavedPlayerDeckOnLabel() {
        let editedDeckName = NSUserDefaults(suiteName: "group.Decks")!.stringForKey("Edited Deck Name") as String!
        if editedDeckName != nil {
            playerDeckLabel.text = "Your deck: " + editedDeckName
        } else {
            let savedPlayedDeck = selectedGame.getPlayerDeckName()
            playerDeckLabel.text = "Your deck: " + savedPlayedDeck
        }

    }
    
    // Puts opponent class on label
    func putSavedOpponentClassOnLabel() {
        let editedOpponentClass = defaults.stringForKey("Edited Opponent Class") as String!
        if editedOpponentClass != nil {
            opponentDeckLabel.text = "Opponent's Class: " + editedOpponentClass
        } else {
            let savedOpponentDeck = selectedGame.getOpponentDeck()
            opponentDeckLabel.text = "Opponent's Class: " + savedOpponentDeck
        }

    }
    
    // Puts the coin status
    func putSavedCoinStatusOnSwitch() {
        let savedCoin = selectedGame.getCoin()
        coinSwitch.setOn(savedCoin, animated: true)
    }
    
    // Puts the win status
    func putSavedWinStatusOnSwitch() {
        let savedWin = selectedGame.getWin()
        winSwitch.setOn(savedWin, animated: true)
    }
    
    // Puts the selected tag
    func putSavedTagOnLabel() {
        
        selectedTag = selectedGame.getTag()
        //print("Selected Tag Edit Screen with default tags: " + String(stringInterpolationSegment: selectedTags))
        if let _ = defaults.stringForKey("Edited Selected Tag") {
            selectedTag = defaults.stringForKey("Edited Selected Tag") as String!
        }
        defaults.setObject(selectedTag, forKey: "Edited Selected Tag")
        defaults.synchronize()
        //print("Selected Tag Edit Screen after loading Edited Tags: " + String(stringInterpolationSegment: selectedTags))

        tagsLabel.text = "Tag: " + selectedTag
        
        
        
    }
    
    // Puts the selected date on the date label
    func putSelectedDateOnLabel() {
        let editedDate = EditDate.sharedInstance.readDate()
        //var savedDate = selectedGame.getNSDate()
        //println("Saved Date:")
        //println(savedDate)
        //println("Edited Date:")
        //println(editedDate)
        if editedDate != nil {
            dateLabel.text = "Date: " + EditDate.sharedInstance.dateToString(editedDate!)
        } else {
            dateLabel.text = "Date: " + selectedGame.getDate()
        }
    }
    
    // Puts edited deck name on label
    func putSelectedPlayerDeckOnLabel() {
        let savedDeck = selectedGame.getPlayerDeckName()
        let editedDeck = defaults.stringForKey("Edited Deck Name")
        if editedDeck == nil {
            playerDeckLabel.text = "Your deck: " + savedDeck
        } else {
            playerDeckLabel.text = "Your deck: " + editedDeck!
        }
    }
    
    // Puts edited opponent class on label
    func putSelectedOpponentClassOnLabel() {
        let savedOpponentClass = selectedGame.getOpponentDeck()
        //println(savedOpponentClass)
        let editedOpponentClass = defaults.stringForKey("Edited Opponent Class")
        //println(editedOpponentClass)
        if editedOpponentClass == nil {
            opponentDeckLabel.text = "Opponent's Class: " + savedOpponentClass
        } else {
            opponentDeckLabel.text = "Opponent's Class: " + editedOpponentClass!
        }
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func cancelButtonPressed(sender: UIBarButtonItem) {
        
        // Remove all edited stats
        NSUserDefaults.standardUserDefaults().removeObjectForKey("Selected Game")
        NSUserDefaults.standardUserDefaults().removeObjectForKey("Saved Edited Date")
        NSUserDefaults(suiteName: "group.Decks")!.removeObjectForKey("Edited Deck Name")
        NSUserDefaults.standardUserDefaults().removeObjectForKey("Edited Deck Class")
        NSUserDefaults.standardUserDefaults().removeObjectForKey("Edited Opponent Class")
        NSUserDefaults.standardUserDefaults().removeObjectForKey("Edited Selected Tag")
        NSUserDefaults.standardUserDefaults().synchronize()
        self.dismissViewControllerAnimated(true, completion: {});
    }
    
    @IBAction func saveButtonPressed(sender: UIBarButtonItem) {
        
        // Get required atributes to create a new Game
        let editedID = selectedGame.getID()
        
        var editedDate = EditDate.sharedInstance.readDate()
        if editedDate == nil {
            editedDate = selectedGame.getNSDate()
        }
        
        var editedPlayerDeckName = NSUserDefaults(suiteName: "group.Decks")!.stringForKey("Edited Deck Name")
        if editedPlayerDeckName == nil {
            editedPlayerDeckName = selectedGame.getPlayerDeckName()
        }
        
        var editedPlayerDeckClass = NSUserDefaults(suiteName: "group.Decks")!.stringForKey("Edited Deck Class") as String?
        if editedPlayerDeckClass == nil {
            editedPlayerDeckClass = selectedGame.getPlayerDeckClass()
        }
        
        var editedOpponentClass = defaults.stringForKey("Edited Opponent Class")
        if editedOpponentClass == nil {
            editedOpponentClass = selectedGame.getOpponentDeck()
        }
        
        let editedCoin = coinSwitch.on
        
        let editedWin = winSwitch.on
        
        let editedTag = defaults.stringForKey("Edited Selected Tag") as String!
       
        // Create a new Game object
        let editedGame = Game(newID: editedID, newDate: editedDate!, newPlayerDeckName: editedPlayerDeckName!, newPlayerDeckClass: editedPlayerDeckClass!, newOpponentDeck: editedOpponentClass!, newCoin: editedCoin, newWin: editedWin, newTag: editedTag)
        
        Data.sharedInstance.editGame(editedID, oldGame: selectedGame, newGame: editedGame)
        
        
        // Remove all edited stats
        NSUserDefaults.standardUserDefaults().removeObjectForKey("Selected Game")
        NSUserDefaults.standardUserDefaults().removeObjectForKey("Saved Edited Date")
        NSUserDefaults.standardUserDefaults().removeObjectForKey("Edited Deck Name")
        NSUserDefaults.standardUserDefaults().removeObjectForKey("Edited Deck Class")
        NSUserDefaults.standardUserDefaults().removeObjectForKey("Edited Opponent Class")
        NSUserDefaults.standardUserDefaults().removeObjectForKey("Edited Selected Tag")
        NSUserDefaults.standardUserDefaults().synchronize()
        self.dismissViewControllerAnimated(true, completion: {});
    }
}
