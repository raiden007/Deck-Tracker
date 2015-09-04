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
        
        println("Watch app started")
        setSelectedDeckButton()
        setOpponentClassButton()
        setTagsButton()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
        NSUserDefaults.standardUserDefaults().removeObjectForKey("Watch Opponent Class")
    }

    @IBAction func saveButtonPressed() {
        
        // Gathers the data to make the dict
        let defaults = NSUserDefaults(suiteName: "group.Decks")!
        var dict = NSMutableDictionary()
        if let checkSelectedDeckName = defaults.stringForKey("Selected Deck Name") {
            selectedDeckName = defaults.stringForKey("Selected Deck Name")!
            selectedDeckClass = defaults.stringForKey("Selected Deck Class")!
            dict.setValue(selectedDeckName, forKey: "selectedDeckName")
            dict.setValue(selectedDeckClass, forKey: "selectedDeckClass")
        }
        
        let opponentClass = NSUserDefaults.standardUserDefaults().stringForKey("Watch Opponent Class")
        dict.setValue(opponentClass, forKey: "watchOpponentClass")
        
        var coin:Bool = false
        if coinSwitchInt == 0 {
            coin = false
        } else {
            coin = true
        }
        dict.setValue(coin, forKey: "coin")
        
        var win:Bool = true
        if winSwitchInt == 0 {
            win = false
        } else {
            win = true
        }
        dict.setValue(win, forKey: "win")
        
        if let checkSelectedTags: AnyObject = NSUserDefaults.standardUserDefaults().objectForKey("Selected Tags Watch") {
            selectedTags = NSUserDefaults.standardUserDefaults().objectForKey("Selected Tags Watch") as! [String]
        } else {
            selectedTags = [""]
        }
        dict.setValue(selectedTags, forKey: "watchSelectedTags")
        
        println(selectedDeckName)
        
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
        setOpponentClassBUttonBackgroundToBlack()
        willActivate()
    }
    
    // Transforms RGB colors to UI Color
    func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    // Populates the selected deck button
    func setSelectedDeckButton() {
        let defaults = NSUserDefaults(suiteName: "group.Decks")!
        if let selectedDeckID = defaults.integerForKey("Selected Deck ID") as Int! {
            if let selectedDeckName = defaults.stringForKey("Selected Deck Name") as String! {
                var selectedDeckClass = defaults.stringForKey("Selected Deck Class")!
                selectDeckButton.setTitle(selectedDeckName)
                colorCell(selectedDeckClass, button: selectDeckButton, opponent: false, deckName: selectedDeckName)
            }
        }
    }
    
    // Populates the opponent class button
    func setOpponentClassButton() {
        if let opponentClass = NSUserDefaults.standardUserDefaults().stringForKey("Watch Opponent Class") {
            //selectOpponentButton.setTitle("Opponent: " + String(opponentClass))
            colorCell(opponentClass, button: selectOpponentButton, opponent: true, deckName: "")
            saveGameButton.setTitle("Save Game")
        } else {
            selectOpponentButton.setTitle("Select Opponent")
            saveGameButton.setTitle("Opponent Class Needed!")
        }
    }
    
    // Sets the opponent class button to black
    func setOpponentClassBUttonBackgroundToBlack() {
        selectOpponentButton.setBackgroundColor(UIColorFromRGB(0x333333))
    }
    
    // Colors the cell according to the Class specified
    func colorCell (classToBeColored:String, button:WKInterfaceButton, opponent:Bool, deckName:String) {
        
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
    
    
    // Keep track of coin switch
    @IBAction func coinSwitchToggled(value: Bool) {
        if value {
            coinSwitchInt = 1
        } else {
            coinSwitchInt = 0
        }
    }
    
    // Keep track of win switch
    @IBAction func winSwitchToggled(value: Bool) {
        if value {
            winSwitchInt = 1
        } else {
            winSwitchInt = 0
        }
    }
    
    func setTagsButton() {
        if let tags: AnyObject = NSUserDefaults.standardUserDefaults().objectForKey("Selected Tags Watch") {
            selectedTags = NSUserDefaults.standardUserDefaults().objectForKey("Selected Tags Watch") as! [String]!
            tagsButton.setTitle("Tags Added")
        } else {
            tagsButton.setTitle("Add Tags")
        }
        println(selectedTags)
    }
    
    

}
