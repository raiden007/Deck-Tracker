//
//  SelectOpponent.swift
//  Deck Tracker
//
//  Created by Andrei Joghiu on 2/6/15.
//  Copyright (c) 2015 Andrei Joghiu. All rights reserved.
//

import WatchKit
import Foundation


class SelectOpponent: WKInterfaceController {
    
    @IBOutlet var warriorButton: WKInterfaceButton!
    @IBOutlet var paladinButton: WKInterfaceButton!
    @IBOutlet var shamanButton: WKInterfaceButton!
    @IBOutlet var hunterButton: WKInterfaceButton!
    @IBOutlet var druidButton: WKInterfaceButton!
    @IBOutlet var rogueButton: WKInterfaceButton!
    @IBOutlet var warlockButton: WKInterfaceButton!
    @IBOutlet var mageButton: WKInterfaceButton!
    @IBOutlet var priestButton: WKInterfaceButton!
    
    
    

    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
        

        
        
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    @IBAction func warriorButtonPressed() {
        NSUserDefaults.standardUserDefaults().setObject("Warrior", forKey: "Watch Opponent Class")
        NSUserDefaults.standardUserDefaults().synchronize()
        self.popController()
    }
    
    @IBAction func paladinButtonPressed() {
        NSUserDefaults.standardUserDefaults().setObject("Paladin", forKey: "Watch Opponent Class")
        NSUserDefaults.standardUserDefaults().synchronize()
        self.popController()
    }
    
    @IBAction func shamanButtonPressed() {
        NSUserDefaults.standardUserDefaults().setObject("Shaman", forKey: "Watch Opponent Class")
        NSUserDefaults.standardUserDefaults().synchronize()
        self.popController()
    }
    
    @IBAction func hunterButtonPressed() {
        NSUserDefaults.standardUserDefaults().setObject("Hunter", forKey: "Watch Opponent Class")
        NSUserDefaults.standardUserDefaults().synchronize()
        self.popController()
    }
    
    @IBAction func druidButtonPressed() {
        NSUserDefaults.standardUserDefaults().setObject("Druid", forKey: "Watch Opponent Class")
        NSUserDefaults.standardUserDefaults().synchronize()
        self.popController()
    }
    
    @IBAction func rogueButtonPressed() {
        NSUserDefaults.standardUserDefaults().setObject("Rogue", forKey: "Watch Opponent Class")
        NSUserDefaults.standardUserDefaults().synchronize()
        self.popController()
    }
    
    @IBAction func warlockButtonPressed() {
        NSUserDefaults.standardUserDefaults().setObject("Warlock", forKey: "Watch Opponent Class")
        NSUserDefaults.standardUserDefaults().synchronize()
        self.popController()
    }
    
    @IBAction func mageButtonPressed() {
        NSUserDefaults.standardUserDefaults().setObject("Mage", forKey: "Watch Opponent Class")
        NSUserDefaults.standardUserDefaults().synchronize()
        self.popController()
    }
    
    @IBAction func priestButtonPressed() {
        NSUserDefaults.standardUserDefaults().setObject("Priest", forKey: "Watch Opponent Class")
        NSUserDefaults.standardUserDefaults().synchronize()
        self.popController()
    }
    

}
