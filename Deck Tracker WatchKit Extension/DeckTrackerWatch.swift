//
//  DeckTrackerWatch.swift
//  Deck Tracker WatchKit Extension
//
//  Created by Andrei Joghiu on 29/5/15.
//  Copyright (c) 2015 Andrei Joghiu. All rights reserved.
//

import WatchKit
import Foundation


class DeckTrackerWatch: WKInterfaceController {
    // This is the main screen of the watch.
    
    @IBOutlet var selectDeckButton: WKInterfaceButton!
    @IBOutlet var selectOpponentButton: WKInterfaceButton!
    @IBOutlet var coinSwitch: WKInterfaceSwitch!
    @IBOutlet var winSwitch: WKInterfaceSwitch!
    @IBOutlet weak var tagsButton: WKInterfaceButton!
    @IBOutlet var saveGameButton: WKInterfaceButton!
    
    var coinSwitchInt:Int = 0
    var winSwitchInt:Int = 1
    var selectedDeckName: String = ""
    var selectedDeckClass: String = ""
    var selectedTags:[String] = []


    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        // Populates the "Selected Deck", "Opponent Class" and "Tags" buttons
        print("Watch app started")
        setSelectedDeckButton()
        setOpponentClassButton()
        setTagsButton()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    
    @IBAction func saveButtonPressed() {
        
        // Gathers the data to make the dict to send the info to the phone
        let defaults = NSUserDefaults(suiteName: "group.Decks")!
        var dict = NSMutableDictionary()
        // Gets selected deck and selected class associated with the deck
        if let checkSelectedDeckName = defaults.stringForKey("Selected Deck Name") {
            selectedDeckName = defaults.stringForKey("Selected Deck Name")!
            selectedDeckClass = defaults.stringForKey("Selected Deck Class")!
            dict.setValue(selectedDeckName, forKey: "selectedDeckName")
            dict.setValue(selectedDeckClass, forKey: "selectedDeckClass")
        }
        
        // Gets the Opponent Class
        let opponentClass = NSUserDefaults.standardUserDefaults().stringForKey("Watch Opponent Class")
        dict.setValue(opponentClass, forKey: "watchOpponentClass")
        
        // Gets if user had coin or not
        var coin:Bool = false
        if coinSwitchInt == 0 {
            coin = false
        } else {
            coin = true
        }
        dict.setValue(coin, forKey: "coin")
        
        // Gets if user won or not
        var win:Bool = true
        if winSwitchInt == 0 {
            win = false
        } else {
            win = true
        }
        dict.setValue(win, forKey: "win")
        
        // Gets the selected tags
        if let checkSelectedTags: AnyObject = NSUserDefaults.standardUserDefaults().objectForKey("Selected Tags Watch") {
            selectedTags = NSUserDefaults.standardUserDefaults().objectForKey("Selected Tags Watch") as! [String]
        } else {
            selectedTags = [""]
        }
        dict.setValue(selectedTags, forKey: "watchSelectedTags")
        
        // Saves the dictionary and sends the info to the phone
        if opponentClass != nil {
            if let checkSelectedDeckName = defaults.stringForKey("Selected Deck Name") {
                defaults.setObject(dict, forKey: "Add Game Watch")
                defaults.synchronize()
                
                WKInterfaceController.openParentApplication(["Save New Game" : ""] , reply: { [unowned self](reply, error) -> Void in
                    })
            } else {
                saveGameButton.setTitle("Select a deck!")
            }

            
        } else {
            saveGameButton.setTitle("Opponent Class needed!")
        }
        
        // Remove saved settings
        NSUserDefaults.standardUserDefaults().removeObjectForKey("Watch Opponent Class")
        NSUserDefaults.standardUserDefaults().removeObjectForKey("Selected Tags Watch")
        setOpponentClassButtonBackgroundToBlack()
        willActivate()
    }
    
    
    func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        // Transforms RGB colors to UI Color
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    
    func setSelectedDeckButton() {
        // Populates the selected deck button
        let defaults = NSUserDefaults(suiteName: "group.Decks")!
        if let selectedDeckID = defaults.integerForKey("Selected Deck ID") as Int! {
            if let selectedDeckName = defaults.stringForKey("Selected Deck Name") as String! {
                var selectedDeckClass = defaults.stringForKey("Selected Deck Class")!
                selectDeckButton.setTitle(selectedDeckName)
                colorCell(selectedDeckClass, button: selectDeckButton, opponent: false, deckName: selectedDeckName)
            }
        }
    }
    
    
    func setOpponentClassButton() {
        // Populates the opponent class button
        if let opponentClass = NSUserDefaults.standardUserDefaults().stringForKey("Watch Opponent Class") {
            //selectOpponentButton.setTitle("Opponent: " + String(opponentClass))
            colorCell(opponentClass, button: selectOpponentButton, opponent: true, deckName: "")
            saveGameButton.setTitle("Save Game")
        } else {
            selectOpponentButton.setTitle("Select Opponent")
            saveGameButton.setTitle("Opponent Class Needed!")
        }
    }
    
    
    func setOpponentClassButtonBackgroundToBlack() {
        // Sets the opponent class button to black
        selectOpponentButton.setBackgroundColor(UIColorFromRGB(0x333333))
    }
    
    
    func colorCell (classToBeColored:String, button:WKInterfaceButton, opponent:Bool, deckName:String) {
        // Colors the cell according to the Class specified
        if classToBeColored == "Warrior" {
            button.setBackgroundColor(UIColorFromRGB(0xCC0000))
            var boldFont = UIFont(name: "Helvetica Neue", size: 15.0)!
            var greenColor = UIColor.greenColor()
            var attributeDictionary = [NSFontAttributeName: boldFont, NSForegroundColorAttributeName: greenColor]
            if opponent == true {
               var attibuteString = NSAttributedString(string: "Versus: Warrior", attributes: attributeDictionary)
                button.setAttributedTitle(attibuteString)
            } else {
                var attibuteString = NSAttributedString(string: "Deck: " + deckName, attributes: attributeDictionary)
                button.setAttributedTitle(attibuteString)
            }
        } else if classToBeColored == "Paladin" {
            button.setBackgroundColor(UIColorFromRGB(0xCCC333))
            var boldFont = UIFont(name: "Helvetica Neue", size: 15.0)!
            var greenColor = UIColor.greenColor()
            var attributeDictionary = [NSFontAttributeName: boldFont, NSForegroundColorAttributeName: greenColor]
            if opponent == true {
                var attibuteString = NSAttributedString(string: "Versus: Paladin", attributes: attributeDictionary)
                button.setAttributedTitle(attibuteString)
            } else {
                var attibuteString = NSAttributedString(string: "Deck: " + deckName, attributes: attributeDictionary)
                button.setAttributedTitle(attibuteString)
            }
        } else if classToBeColored == "Shaman" {
            button.setBackgroundColor(UIColorFromRGB(0x3366CC))
            var boldFont = UIFont(name: "Helvetica Neue", size: 15.0)!
            var greenColor = UIColor.greenColor()
            var attributeDictionary = [NSFontAttributeName: boldFont, NSForegroundColorAttributeName: greenColor]
            if opponent == true {
                var attibuteString = NSAttributedString(string: "Versus: Shaman", attributes: attributeDictionary)
                button.setAttributedTitle(attibuteString)
            } else {
                var attibuteString = NSAttributedString(string: "Deck: " + deckName, attributes: attributeDictionary)
                button.setAttributedTitle(attibuteString)
            }
        } else if classToBeColored == "Hunter" {
            button.setBackgroundColor(UIColorFromRGB(0x339933))
            var boldFont = UIFont(name: "Helvetica Neue", size: 15.0)!
            var greenColor = UIColor.greenColor()
            var attributeDictionary = [NSFontAttributeName: boldFont, NSForegroundColorAttributeName: greenColor]
            if opponent == true {
                var attibuteString = NSAttributedString(string: "Versus: Hunter", attributes: attributeDictionary)
                button.setAttributedTitle(attibuteString)
            } else {
                var attibuteString = NSAttributedString(string: "Deck: " + deckName, attributes: attributeDictionary)
                button.setAttributedTitle(attibuteString)
            }
        } else if classToBeColored == "Druid" {
            button.setBackgroundColor(UIColorFromRGB(0x990000))
            var boldFont = UIFont(name: "Helvetica Neue", size: 15.0)!
            var greenColor = UIColor.greenColor()
            var attributeDictionary = [NSFontAttributeName: boldFont, NSForegroundColorAttributeName: greenColor]
            if opponent == true {
                var attibuteString = NSAttributedString(string: "Versus: Druid", attributes: attributeDictionary)
                button.setAttributedTitle(attibuteString)
            } else {
                var attibuteString = NSAttributedString(string: "Deck: " + deckName, attributes: attributeDictionary)
                button.setAttributedTitle(attibuteString)
            }
        } else if classToBeColored == "Rogue" {
            button.setBackgroundColor(UIColorFromRGB(0x666666))
            var boldFont = UIFont(name: "Helvetica Neue", size: 15.0)!
            var greenColor = UIColor.greenColor()
            var attributeDictionary = [NSFontAttributeName: boldFont, NSForegroundColorAttributeName: greenColor]
            if opponent == true {
                var attibuteString = NSAttributedString(string: "Versus: Rogue", attributes: attributeDictionary)
                button.setAttributedTitle(attibuteString)
            } else {
                var attibuteString = NSAttributedString(string: "Deck: " + deckName, attributes: attributeDictionary)
                button.setAttributedTitle(attibuteString)
            }
        } else if classToBeColored == "Warlock" {
            button.setBackgroundColor(UIColorFromRGB(0x9900CC))
            var boldFont = UIFont(name: "Helvetica Neue", size: 15.0)!
            var greenColor = UIColor.greenColor()
            var attributeDictionary = [NSFontAttributeName: boldFont, NSForegroundColorAttributeName: greenColor]
            if opponent == true {
                var attibuteString = NSAttributedString(string: "Versus: Warlock", attributes: attributeDictionary)
                button.setAttributedTitle(attibuteString)
            } else {
                var attibuteString = NSAttributedString(string: "Deck: " + deckName, attributes: attributeDictionary)
                button.setAttributedTitle(attibuteString)
            }
        } else if classToBeColored == "Mage" {
            button.setBackgroundColor(UIColorFromRGB(0x009999))
            var boldFont = UIFont(name: "Helvetica Neue", size: 15.0)!
            var greenColor = UIColor.greenColor()
            var attributeDictionary = [NSFontAttributeName: boldFont, NSForegroundColorAttributeName: greenColor]
            if opponent == true {
                var attibuteString = NSAttributedString(string: "Versus: Mage", attributes: attributeDictionary)
                button.setAttributedTitle(attibuteString)
            } else {
                var attibuteString = NSAttributedString(string: "Deck: " + deckName, attributes: attributeDictionary)
                button.setAttributedTitle(attibuteString)
            }
        } else if classToBeColored == "Priest" {
            button.setBackgroundColor(UIColorFromRGB(0x999999))
            var boldFont = UIFont(name: "Helvetica Neue", size: 15.0)!
            var greenColor = UIColor.greenColor()
            var attributeDictionary = [NSFontAttributeName: boldFont, NSForegroundColorAttributeName: greenColor]
            if opponent == true {
                var attibuteString = NSAttributedString(string: "Versus: Priest", attributes: attributeDictionary)
                button.setAttributedTitle(attibuteString)
            } else {
                var attibuteString = NSAttributedString(string: "Deck: " + deckName, attributes: attributeDictionary)
                button.setAttributedTitle(attibuteString)
            }
        }
    }
    
    
    
    @IBAction func coinSwitchToggled(value: Bool) {
        // Keep track of coin switch
        if value {
            coinSwitchInt = 1
        } else {
            coinSwitchInt = 0
        }
    }
    
    
    @IBAction func winSwitchToggled(value: Bool) {
        // Keep track of win switch
        if value {
            winSwitchInt = 1
        } else {
            winSwitchInt = 0
        }
    }
    
    func setTagsButton() {
        // Populates the tags button
        if let testSelectedTags: AnyObject = NSUserDefaults.standardUserDefaults().objectForKey("Selected Tags Watch") {
            selectedTags = testSelectedTags as! [String]
            tagsButton.setTitle("Tags Added")
        } else {
            tagsButton.setTitle("Add Tags")
        }
        //println(selectedTags)
    }
    
    

}
