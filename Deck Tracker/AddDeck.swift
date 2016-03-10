//
//  AddDeck.swift
//  Deck Tracker
//
//  Created by Andrei Joghiu on 28/4/15.
//  Copyright (c) 2015 Andrei Joghiu. All rights reserved.
//

import UIKit
import Fabric
import Crashlytics

class AddDeck: UIViewController, UITextFieldDelegate, UINavigationBarDelegate {

    @IBOutlet var cancelButton: UIBarButtonItem!
    @IBOutlet var deck1: UIButton!
    @IBOutlet var saveButton: UIBarButtonItem!
    @IBOutlet var deck2: UIButton!
    @IBOutlet var deck3: UIButton!
    @IBOutlet var deck4: UIButton!
    @IBOutlet var deck5: UIButton!
    @IBOutlet var deck6: UIButton!
    @IBOutlet var deck7: UIButton!
    @IBOutlet var deck8: UIButton!
    @IBOutlet var deck9: UIButton!
    @IBOutlet var deckNameTxtField: UITextField!
    
    var deckClass:String = ""
    var iCloudKeyStore: NSUbiquitousKeyValueStore = NSUbiquitousKeyValueStore()
    var deckID = 0

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.deckNameTxtField.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // Cancel button is pressed
    @IBAction func cancelButtonPressed(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: {})
    }
    
    @IBAction func saveButtonPressed(sender: UIBarButtonItem) {
        
        // Get the atributes from the user
        let deckName:String = deckNameTxtField.text!
        let deckSelected = selectedDeck()
        // Loads and increments the deck ID then saves the new ID
        readDeckID()
        deckID++
        setDeckID()
        // Create a new Deck object and add it to the deck array
        if deckName != "" && deckSelected != "" {
            var deckNameAlreadyExists = false
            let deckList = Data.sharedInstance.listOfDecks
            
            for deck in deckList {
                if deck.deckName.lowercaseString == deckName.lowercaseString {
                    deckNameAlreadyExists = true
                }
            }
            
            if deckNameAlreadyExists == true {
                let alert = UIAlertView()
                alert.title = "Deck already exists"
                alert.message = "Deck name already exists"
                alert.addButtonWithTitle("OK")
                alert.show()
            } else {
                let newDeck = Deck(newDeckID: deckID, newDeckName: deckName, newDeckClass: deckSelected)
                //println("Added: " + newDeck.toString())
                Data.sharedInstance.addDeck(newDeck)
                self.dismissViewControllerAnimated(true, completion: {})
                
                Answers.logCustomEventWithName("New deck added",
                    customAttributes: [
                        "Deck Name": deckName,
                        "Deck Class": deckSelected
                    ])
            }

        } else {
            if deckName == "" && deckSelected == "" {
                let alert = UIAlertView()
                alert.title = "Error"
                alert.message = "Please enter a name and select a class"
                alert.addButtonWithTitle("OK")
                alert.show()
            } else if deckSelected == "" {
                let alert = UIAlertView()
                alert.title = "Error"
                alert.message = "No Deck Selected"
                alert.addButtonWithTitle("OK")
                alert.show()
            } else if deckName == "" {
                let alert = UIAlertView()
                alert.title = "Error"
                alert.message = "Please enter a name"
                alert.addButtonWithTitle("OK")
                alert.show()
            }
        }
    }
    
    // Reads the saved Deck ID from iCloud or local storage
    func readDeckID() {
        if let _ = iCloudKeyStore.objectForKey("iCloud deck ID") {
            deckID = iCloudKeyStore.objectForKey("iCloud deck ID") as! Int
        } else if let _ = NSUserDefaults.standardUserDefaults().integerForKey("Deck ID") as Int? {
            deckID = NSUserDefaults.standardUserDefaults().integerForKey("Deck ID")
        } else {
            deckID = 0
        }
    }
    
    // Saves the Deck ID to iCloud and Local storage
    func setDeckID() {
        NSUserDefaults.standardUserDefaults().setInteger(deckID, forKey: "Deck ID")
        NSUserDefaults.standardUserDefaults().synchronize()
        
        iCloudKeyStore.setObject(deckID, forKey: "iCloud deck ID")
        iCloudKeyStore.synchronize()
    }
    
   
    @IBAction func deck1Pressed(sender: UIButton) {
        self.deselectAll()
        deck1.selected = true
    }
    
    
    @IBAction func deck2Pressed(sender: UIButton) {
        self.deselectAll()
        deck2.selected = true
    }
    
    @IBAction func deck3Pressed(sender: UIButton) {
        self.deselectAll()
        deck3.selected = true
    }
    
    @IBAction func deck4Pressed(sender: UIButton) {
        self.deselectAll()
        deck4.selected = true
    }
    
    @IBAction func deck5Pressed(sender: UIButton) {
        self.deselectAll()
        deck5.selected = true
    }
    
    @IBAction func deck6Pressed(sender: UIButton) {
        self.deselectAll()
        deck6.selected = true
    }
    
    @IBAction func deck7Pressed(sender: UIButton) {
        self.deselectAll()
        deck7.selected = true
    }
    
    @IBAction func deck8Pressed(sender: UIButton) {
        self.deselectAll()
        deck8.selected = true
    }
    
    @IBAction func deck9Pressed(sender: UIButton) {
        self.deselectAll()
        deck9.selected = true
    }
    
    // Deselects all decks
    func deselectAll () {
        deck1.selected = false
        deck2.selected = false
        deck3.selected = false
        deck4.selected = false
        deck5.selected = false
        deck6.selected = false
        deck7.selected = false
        deck8.selected = false
        deck9.selected = false
        
    }
    
    // Returns the selected deck class
    func selectedDeck() -> String {
        if deck1.selected == true {
            return "Warrior"
        } else if deck2.selected == true {
            return "Paladin"
        } else if deck3.selected == true {
            return "Shaman"
        } else if deck4.selected == true {
            return "Hunter"
        } else if deck5.selected == true {
            return "Druid"
        } else if deck6.selected == true {
            return "Rogue"
        } else if deck7.selected == true {
            return "Mage"
        } else if deck8.selected == true {
            return "Warlock"
        } else if deck9.selected == true {
            return "Priest"
        } else {
            return ""
        }
    }
    
    
    // Hide keyboard on return
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    // Hide keyboard when taping outside of it
    //override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
    //   self.view.endEditing(true)
    //}
}
