//
//  AddGame.swift
//  Deck Tracker
//
//  Created by Andrei Joghiu on 7/5/15.
//  Copyright (c) 2015 Andrei Joghiu. All rights reserved.
//

import UIKit

class AddGame: UITableViewController, UINavigationBarDelegate, UITableViewDelegate  {
    
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
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Puts today date on the date label
        var today = dateToday()
        dateCellLabel.text = "Date: " + today
        putSelectedDeckNameOnLabel()
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        putSelectedDateOnLabel()
        putSelectedDeckNameOnLabel()
        putSelectedOpponentClassOnLabel()
    }
    
    func putSelectedDateOnLabel() {
        // Puts the selected date on the date label
        var x = SelectDate()
        var newDate = x.readDate()
        var newDateString = x.dateToString(newDate)
        dateCellLabel.text = "Date: " + newDateString
    }
    
    // Reads the selected deck name from NSUserDefaults
    func readSelectedDeckName() -> String {
        let defaults = NSUserDefaults(suiteName: "group.Decks")!
        let name = defaults.stringForKey("Selected Deck Name") as String!
        if name == nil {
            return ""
        } else {
            return name
        }
    }
    
    // Gets the selected deck from NSUserDefaults and puts it on the label
    func putSelectedDeckNameOnLabel() {
        var selectedDeck = readSelectedDeckName()
        if selectedDeck == "" {
            playerDeckLabel.text = "You need to select a deck first"
        } else {
            playerDeckLabel.text = "Your deck: " + selectedDeck
        }
    }
    
    // Puts opponent's class in NSUserDefaults
    func putSelectedOpponentClassOnLabel() {
        var selectedOpponentClass = readSelectedOpponentClass()
        if selectedOpponentClass == "" {
            opponentDeckLabel.text = "Select Opponent's Class"
        } else {
            opponentDeckLabel.text = "Opponent's class: " + selectedOpponentClass
        }
    }
    
    // Reads the selected opponent's class from NSUserDefaults
    func readSelectedOpponentClass() -> String {
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
    
    // Remove the selected date and selected opponent class from NSUserDefaults and dismissed the screen    
    @IBAction func cancelButtonPressed(sender: UIBarButtonItem) {
        let defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
        defaults.removeObjectForKey("Saved Date")
        defaults.removeObjectForKey("Opponent Class")
        defaults.synchronize()
        self.dismissViewControllerAnimated(true, completion: {})
    }
    
    
    // Get today's date
    func dateToday() -> String {
        let now = NSDate()
        let formatter = NSDateFormatter()
        formatter.dateStyle = NSDateFormatterStyle.ShortStyle
        let dateString = formatter.stringFromDate(now)
        return dateString
    }
    
    // Removes the selected date and selected opponent class from NSUserDefaults and sends all the info to the Game List
    @IBAction func saveButtonPressed(sender: UIBarButtonItem) {
        let defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()

        
        // Gets all the atributes for a new Game
        var newGameID = newGameGetID()
        //var x = SelectDate()
        var newGameDate = SelectDate().readDate()
        //var newGameDateString = x.dateToString(newGameDate)
        var newGamePlayerDeckName = NSUserDefaults(suiteName: "group.Decks")!.stringForKey("Selected Deck Name") as String?
        var newGamePlayerDeckClass = NSUserDefaults(suiteName: "group.Decks")!.stringForKey("Selected Deck Class") as String?
        var newGameOpponentClass = defaults.stringForKey("Opponent Class") as String?
        var newGameCoin = coinCellSwitch.on
        var newGameWin = winCellSwitch.on
        
        if newGamePlayerDeckName != nil && newGameOpponentClass != nil {
            
            // Adds a new game
            var newGame = Game(newID: newGameID, newDate: newGameDate, newPlayerDeckName: newGamePlayerDeckName!, newPlayerDeckClass:newGamePlayerDeckClass! , newOpponentDeck: newGameOpponentClass!, newCoin: newGameCoin, newWin: newGameWin)
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
        
        // Deletes the date and opponent class so the user needs to select again
        defaults.removeObjectForKey("Saved Date")
        defaults.removeObjectForKey("Opponent Class")
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
}
