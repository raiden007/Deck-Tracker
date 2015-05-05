//
//  AddDeck.swift
//  Deck Tracker
//
//  Created by Andrei Joghiu on 28/4/15.
//  Copyright (c) 2015 Andrei Joghiu. All rights reserved.
//

import UIKit

class AddDeck: UIViewController {

    @IBOutlet var cancelButton: UIBarButtonItem!
    @IBOutlet var deck1: UIButton!
    @IBOutlet var saveButton: UIBarButtonItem!
    
    var selected = 0

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var countTest:String  = String (NSUserDefaults.standardUserDefaults().integerForKey("Matches Count"))
        
 //       println("Count Test: " + countTest)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func cancelButtonPressed(sender: UIBarButtonItem) {
 //       self.dismissViewControllerAnimated(true, completion: {})
        Data.sharedInstance.readData()
        println("Add Deck dismissed")
    }
    
    @IBAction func deck1Pressed(sender: UIButton) {
        
        if selected % 2 == 0 {
            selected++
            deck1.selected = true
        } else {
            deck1.selected = false
            selected++
        }
        
        
    }
    
    @IBAction func saveButtonPressed(sender: UIBarButtonItem) {
        
        let now = NSDate()
        let formatter = NSDateFormatter()
        formatter.dateStyle = NSDateFormatterStyle.ShortStyle
        let dateString = formatter.stringFromDate(now)
 //       println(dateString)
        
        // Adding into the NSUserDedaults
        
        // Reading current value
        var matchesCount = NSUserDefaults.standardUserDefaults().integerForKey("Matches Count");
        matchesCount++
        // Writing the new one
        NSUserDefaults.standardUserDefaults().setInteger(matchesCount, forKey: "Matches Count");
        // Sync
        NSUserDefaults.standardUserDefaults().synchronize()

        
        // Adding a match into the array
        var newGame = Game(idNumber: matchesCount, playerDeck: "abc", opponentDeck: "asdhasdhaosuddas", coin: true, win: false)
        println(newGame.toString())
        
        // Add to Data class file
        Data.sharedInstance.addGame(newGame)
        
//        println(Data.sharedInstance.generalWinRate())
        

        
        
        self.dismissViewControllerAnimated(true, completion: {})
        
    }
    
    
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
