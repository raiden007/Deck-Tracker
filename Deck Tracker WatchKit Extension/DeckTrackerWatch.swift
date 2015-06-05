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
    
    
    


    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
        println("Watch app started")
        
        //setSelectedDeckButton()
        setOpponentClassButton()
        
        

        
        
        
        
        
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    @IBAction func saveButtonPressed() {
        
        // Remove saved settings
        NSUserDefaults.standardUserDefaults().removeObjectForKey("Watch Opponent Class")
        
    }
    
    func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    func setSelectedDeckButton() {
        let defaults = NSUserDefaults(suiteName: "group.Decks")!
        if let selectedDeckID = defaults.integerForKey("Selected Deck ID") as Int! {
            var selectedDeckName = defaults.stringForKey("Selected Deck Name")!
            var selectedDeckClass = defaults.stringForKey("Selected Deck Class")!
            selectDeckButton.setTitle(selectedDeckName)
            colorCell(selectedDeckClass, button: selectDeckButton, opponent: false, deckName: selectedDeckName)
        }

    }
    
    func setOpponentClassButton() {
        if let opponentClass = NSUserDefaults.standardUserDefaults().stringForKey("Watch Opponent Class") {
            //selectOpponentButton.setTitle("Opponent: " + String(opponentClass))
            colorCell(opponentClass, button: selectOpponentButton, opponent: true, deckName: "")
            
        } else {
            selectOpponentButton.setTitle("Select Opponent")
        }
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

}
