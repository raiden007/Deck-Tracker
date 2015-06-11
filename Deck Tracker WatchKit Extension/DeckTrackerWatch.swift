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
    @IBOutlet var saveGameButton: WKInterfaceButton!
    
    var coinSwitchInt:Int = 0
    var winSwitchInt:Int = 1
    


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
        let selectedDeckName = defaults.stringForKey("Selected Deck Name")!
        let selectedDeckClass = defaults.stringForKey("Selected Deck Class")!
        let opponentClass = NSUserDefaults.standardUserDefaults().stringForKey("Watch Opponent Class")

        var coin:Bool = false
        if coinSwitchInt == 0 {
            coin = false
        } else {
            coin = true
        }
        
        var win:Bool = true
        if winSwitchInt == 0 {
            win = false
        } else {
            win = true
        }

        // Creates the dictionary to send to phone
        dict.setValue(selectedDeckName, forKey: "selectedDeckName")
        dict.setValue(selectedDeckClass, forKey: "selectedDeckClass")
        dict.setValue(opponentClass, forKey: "watchOpponentClass")
        dict.setValue(coin, forKey: "coin")
        dict.setValue(win, forKey: "win")
        
        // Saves the dictionary and sends the info to the phone
        if opponentClass != nil {
            defaults.setObject(dict, forKey: "Add Game Watch")
            defaults.synchronize()
            
            WKInterfaceController.openParentApplication(["Save New Game" : ""] , reply: { [unowned self](reply, error) -> Void in
                })
            
        } else {
            saveGameButton.setTitle("Opponent Class needed!")
        }
        
        // Remove saved settings
        NSUserDefaults.standardUserDefaults().removeObjectForKey("Watch Opponent Class")
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
            var selectedDeckName = defaults.stringForKey("Selected Deck Name")!
            var selectedDeckClass = defaults.stringForKey("Selected Deck Class")!
            selectDeckButton.setTitle(selectedDeckName)
            colorCell(selectedDeckClass, button: selectDeckButton, opponent: false, deckName: selectedDeckName)
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
    
    

}
