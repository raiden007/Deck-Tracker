//
//  AddGame.swift
//  Deck Tracker
//
//  Created by Andrei Joghiu on 7/5/15.
//  Copyright (c) 2015 Andrei Joghiu. All rights reserved.
//

import UIKit

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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Puts today date on the date label
        let today = dateToday()
        dateCellLabel.text = "Date: " + today
        putSelectedDeckNameOnLabel()
        
    }
    
    override func viewDidAppear(animated: Bool) {
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
        // Reads the selected deck name from NSUserDefaults
        let defaults = NSUserDefaults(suiteName: "group.Decks")!
        let name = defaults.stringForKey("Selected Deck Name") as String!
        if name == nil {
            return ""
        } else {
            return name
        }
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
        let defaults = NSUserDefaults.standardUserDefaults()
        if let name:String = defaults.stringForKey("Opponent Class") as String! {
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
    func positionForBar(bar: UIBarPositioning) -> UIBarPosition  {
        return UIBarPosition.TopAttached
    }
    
    
    @IBAction func cancelButtonPressed(sender: UIBarButtonItem) {
        // Remove the selected date and selected opponent class from NSUserDefaults and dismissed the screen
        let defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
        defaults.removeObjectForKey("Saved Date")
        defaults.removeObjectForKey("Opponent Class")
        defaults.removeObjectForKey("Selected Tag")
        defaults.synchronize()
        self.dismissViewControllerAnimated(true, completion: {})
    }
    
    
    
    func dateToday() -> String {
        // Get today's date as a String
        let now = NSDate()
        let formatter = NSDateFormatter()
        formatter.dateStyle = NSDateFormatterStyle.ShortStyle
        let dateString = formatter.stringFromDate(now)
        return dateString
    }
    
    
    @IBAction func saveButtonPressed(sender: UIBarButtonItem) {
        // Removes the selected date, opponent class and selected tag from NSUserDefaults and sends all the info to the Game List
        let defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()

        
        // Gets all the atributes for a new Game
        let newGameID = newGameGetID()
        //var x = SelectDate()
        let newGameDate = SelectDate().readDate()
        //var newGameDateString = x.dateToString(newGameDate)
        let newGamePlayerDeckName = NSUserDefaults(suiteName: "group.Decks")!.stringForKey("Selected Deck Name") as String?
        let newGamePlayerDeckClass = NSUserDefaults(suiteName: "group.Decks")!.stringForKey("Selected Deck Class") as String?
        let newGameOpponentClass = defaults.stringForKey("Opponent Class") as String?
        let newGameCoin = coinCellSwitch.on
        let newGameWin = winCellSwitch.on
        let newGameTag = tag

        
        if newGamePlayerDeckName != nil && newGameOpponentClass != nil {
            
            // Adds a new game
            let newGame = Game(newID: newGameID, newDate: newGameDate, newPlayerDeckName: newGamePlayerDeckName!, newPlayerDeckClass:newGamePlayerDeckClass! , newOpponentDeck: newGameOpponentClass!, newCoin: newGameCoin, newWin: newGameWin, newTag: newGameTag)
            // Add to Data class file
            Data.sharedInstance.addGame(newGame)
            self.dismissViewControllerAnimated(true, completion: {})
            
        } else {
            if newGamePlayerDeckName == "" && newGameOpponentClass == nil {
                let alert = UIAlertView()
                alert.title = "Missing Info"
                alert.message = "You need to enter all required info"
                alert.addButtonWithTitle("OK")
                alert.show()
            } else if newGamePlayerDeckName == "" {
                let alert = UIAlertView()
                alert.title = "Missing Info"
                alert.message = "You need to select a deck"
                alert.addButtonWithTitle("OK")
                alert.show()
            } else if newGameOpponentClass == nil {
                let alert = UIAlertView()
                alert.title = "Missing Info"
                alert.message = "You need to select your opponent's class"
                alert.addButtonWithTitle("OK")
                alert.show()
            } else {
                let alert = UIAlertView()
                alert.title = "Missing Info"
                alert.message = "You need to enter all required info"
                alert.addButtonWithTitle("OK")
                alert.show()
            }

        }
        
        // Deletes the date, opponent class and selected tag so the user needs to select again
        defaults.removeObjectForKey("Saved Date")
        defaults.removeObjectForKey("Opponent Class")
        defaults.removeObjectForKey("Selected Tag")
        defaults.synchronize()
    }
    
    // Gets the ID for a new Game
    func newGameGetID () -> Int {
        var matchesCount = NSUserDefaults.standardUserDefaults().integerForKey("Matches Count");
        matchesCount++
        NSUserDefaults.standardUserDefaults().setInteger(matchesCount, forKey: "Matches Count");
        NSUserDefaults.standardUserDefaults().synchronize()
        return matchesCount
    }
    
    // Puts the tags on the Tags Label
    func putTagLabel() {
        let defaults = NSUserDefaults.standardUserDefaults()
        if let _ = defaults.stringForKey("Selected Tag") {
            tag = defaults.stringForKey("Selected Tag") as String!
        }
        if tag.isEmpty {
            tagsLabel.text = "Add Tags"
        } else {
            tagsLabel.text = "Tags: " + tag
        }
    }
}
