//
//  AddDeck.swift
//  Deck Tracker
//
//  Created by Andrei Joghiu on 28/4/15.
//  Copyright (c) 2015 Andrei Joghiu. All rights reserved.
//

import UIKit

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

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.deckNameTxtField.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func cancelButtonPressed(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: {})
        println("Add Deck dismissed")
    }
    
    @IBAction func deck1Pressed(sender: UIButton) {
        self.deselectAll()
        deck1.selected = true
    }
    
    @IBAction func saveButtonPressed(sender: UIBarButtonItem) {
        
        //MARK: Below is the code for adding games in database
        let now = NSDate()
        let formatter = NSDateFormatter()
        formatter.dateStyle = NSDateFormatterStyle.ShortStyle
        let dateString = formatter.stringFromDate(now)
        
        // Reading current value
        var matchesCount = NSUserDefaults.standardUserDefaults().integerForKey("Matches Count");
        matchesCount++
        // Writing the new one
        NSUserDefaults.standardUserDefaults().setInteger(matchesCount, forKey: "Matches Count");
        // Sync
        NSUserDefaults.standardUserDefaults().synchronize()

        // Adding a match into the array
        var newGame = Game(newID: matchesCount, newDate: dateString, newPlayerDeck: "abc", newOpponentDeck: "asdhasdhaosuddas", newCoin: true, newWin: false)
        println(newGame.toString())
        
        // Add to Data class file
        Data.sharedInstance.addGame(newGame)
        

        //MARK: Actual code
        // Get the atributes from the user
        var deckName:String = deckNameTxtField.text
        var deckSelected = selectedDeck()
        var deckCount = NSUserDefaults.standardUserDefaults().integerForKey("Deck Count");
        deckCount++
        NSUserDefaults.standardUserDefaults().setInteger(deckCount, forKey: "Deck Count");
        NSUserDefaults.standardUserDefaults().synchronize()
        // Create a new Deck object and add it to the deck array
        if deckName != "" && deckSelected != "" {
            var newDeck = Deck(newDeckID: deckCount, newDeckName: deckName, newDeckClass: deckSelected)
            println(newDeck.toString())
            Data.sharedInstance.addDeck(newDeck)
            self.dismissViewControllerAnimated(true, completion: {})
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
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        self.view.endEditing(true)
    }
    
    // Have the nav bar show ok.
    // You need to crtl+drag the nav bar to the view controller in storyboard to create a delegate
    // Then add "UINavigationBarDelegate" to the class on top
    // And move the nav bar 20 points down
    func positionForBar(bar: UIBarPositioning) -> UIBarPosition  {
        return UIBarPosition.TopAttached
    }
    
    //TODO: Add error when no name is entered
    //TODO: Add error if no hero is selected
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
