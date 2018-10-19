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
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: {})
    }
    
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        
        // Get the atributes from the user
        let deckName:String = deckNameTxtField.text!
        let deckSelected = selectedDeck()
        // Loads and increments the deck ID then saves the new ID
        readDeckID()
        deckID += 1
        setDeckID()
        // Create a new Deck object and add it to the deck array
        if deckName != "" && deckSelected != "" {
            var deckNameAlreadyExists = false
            let deckList = Data.sharedInstance.listOfDecks
            
            for deck in deckList {
                if deck.deckName.lowercased() == deckName.lowercased() {
                    deckNameAlreadyExists = true
                }
            }
            
            if deckNameAlreadyExists == true {
                let alert = UIAlertView()
                alert.title = "Deck already exists"
                alert.message = "Deck name already exists"
                alert.addButton(withTitle: "OK")
                alert.show()
            } else {
                let newDeck = Deck(newDeckID: deckID, newDeckName: deckName, newDeckClass: deckSelected)
                //println("Added: " + newDeck.toString())
                Data.sharedInstance.addDeck(newDeck)
                self.dismiss(animated: true, completion: {})
                
                Answers.logCustomEvent(withName: "New deck added",
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
                alert.addButton(withTitle: "OK")
                alert.show()
            } else if deckSelected == "" {
                let alert = UIAlertView()
                alert.title = "Error"
                alert.message = "No Deck Selected"
                alert.addButton(withTitle: "OK")
                alert.show()
            } else if deckName == "" {
                let alert = UIAlertView()
                alert.title = "Error"
                alert.message = "Please enter a name"
                alert.addButton(withTitle: "OK")
                alert.show()
            }
        }
    }
    
    // Reads the saved Deck ID from iCloud or local storage
    func readDeckID() {
        if let _ = iCloudKeyStore.object(forKey: "iCloud deck ID") {
            deckID = iCloudKeyStore.object(forKey: "iCloud deck ID") as! Int
        } else if let _ = UserDefaults.standard.integer(forKey: "Deck ID") as Int? {
            deckID = UserDefaults.standard.integer(forKey: "Deck ID")
        } else {
            deckID = 0
        }
    }
    
    // Saves the Deck ID to iCloud and Local storage
    func setDeckID() {
        UserDefaults.standard.set(deckID, forKey: "Deck ID")
        UserDefaults.standard.synchronize()
        
        iCloudKeyStore.set(deckID, forKey: "iCloud deck ID")
        iCloudKeyStore.synchronize()
    }
    
   
    @IBAction func deck1Pressed(_ sender: UIButton) {
        self.deselectAll()
        deck1.isSelected = true
    }
    
    
    @IBAction func deck2Pressed(_ sender: UIButton) {
        self.deselectAll()
        deck2.isSelected = true
    }
    
    @IBAction func deck3Pressed(_ sender: UIButton) {
        self.deselectAll()
        deck3.isSelected = true
    }
    
    @IBAction func deck4Pressed(_ sender: UIButton) {
        self.deselectAll()
        deck4.isSelected = true
    }
    
    @IBAction func deck5Pressed(_ sender: UIButton) {
        self.deselectAll()
        deck5.isSelected = true
    }
    
    @IBAction func deck6Pressed(_ sender: UIButton) {
        self.deselectAll()
        deck6.isSelected = true
    }
    
    @IBAction func deck7Pressed(_ sender: UIButton) {
        self.deselectAll()
        deck7.isSelected = true
    }
    
    @IBAction func deck8Pressed(_ sender: UIButton) {
        self.deselectAll()
        deck8.isSelected = true
    }
    
    @IBAction func deck9Pressed(_ sender: UIButton) {
        self.deselectAll()
        deck9.isSelected = true
    }
    
    // Deselects all decks
    func deselectAll () {
        deck1.isSelected = false
        deck2.isSelected = false
        deck3.isSelected = false
        deck4.isSelected = false
        deck5.isSelected = false
        deck6.isSelected = false
        deck7.isSelected = false
        deck8.isSelected = false
        deck9.isSelected = false
        
    }
    
    // Returns the selected deck class
    func selectedDeck() -> String {
        if deck1.isSelected == true {
            return "Warrior"
        } else if deck2.isSelected == true {
            return "Paladin"
        } else if deck3.isSelected == true {
            return "Shaman"
        } else if deck4.isSelected == true {
            return "Hunter"
        } else if deck5.isSelected == true {
            return "Druid"
        } else if deck6.isSelected == true {
            return "Rogue"
        } else if deck7.isSelected == true {
            return "Mage"
        } else if deck8.isSelected == true {
            return "Warlock"
        } else if deck9.isSelected == true {
            return "Priest"
        } else {
            return ""
        }
    }
    
    
    // Hide keyboard on return
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    // Hide keyboard when taping outside of it
    //override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
    //   self.view.endEditing(true)
    //}
}
