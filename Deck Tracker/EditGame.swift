//
//  EditGame.swift
//  Deck Tracker
//
//  Created by Andrei Joghiu on 12/5/15.
//  Copyright (c) 2015 Andrei Joghiu. All rights reserved.
//

import UIKit

class EditGame: UITableViewController, UINavigationBarDelegate, UITableViewDelegate {
    
    @IBOutlet var cancelButton: UIBarButtonItem!
    @IBOutlet var saveButton: UIBarButtonItem!
    @IBOutlet var dateCell: UITableViewCell!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var playerDeckCell: UITableViewCell!
    @IBOutlet var playerDeckLabel: UILabel!
    @IBOutlet var opponentDeckCell: UITableViewCell!
    @IBOutlet var opponentDeckLabel: UILabel!
    @IBOutlet var coinCell: UITableViewCell!
    @IBOutlet var coinSwitch: UISwitch!
    @IBOutlet var winCell: UITableViewCell!
    @IBOutlet var winSwitch: UISwitch!

    var defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
    var selectedGameArray:[Game] = []
    var selectedGame:Game = Game(newID: 1, newDate: NSDate(), newPlayerDeckName: "1", newPlayerDeckClass: "1", newOpponentDeck: "1", newCoin: true, newWin: true)
    static let sharedInstance = EditGame()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        selectedGameArray = StatsList.sharedInstance.readSelectedGame() as [Game]!
        selectedGame = selectedGameArray[0]

        // Populates the screen with data
        populateScreen()
    }
    
    override func viewDidAppear(animated: Bool) {
        // Populates the screen with data
        putSelectedDateOnLabel()
        putSelectedPlayerDeckOnLabel()
        putSelectedOpponentClassOnLabel()
    }
    
    func populateScreen() {
        putSavedDateOnLabel()
        putSavedPlayerDeckOnLabel()
        putSavedOpponentClassOnLabel()
        putSavedCoinStatusOnSwitch()
        putSavedWinStatusOnSwitch()
    }
    
    func putSavedDateOnLabel() {
        var savedDate = selectedGame.getDate()
        dateLabel.text = "Date: " + savedDate
    }
    
    func putSavedPlayerDeckOnLabel() {
        var savedPlayedDeck = selectedGame.getPlayerDeckName()
        playerDeckLabel.text = "Your deck: " + savedPlayedDeck
    }
    
    func putSavedOpponentClassOnLabel() {
        var savedOpponentDeck = selectedGame.getOpponentDeck()
        opponentDeckLabel.text = "Opponent's Class: " + savedOpponentDeck
    }
    
    func putSavedCoinStatusOnSwitch() {
        var savedCoin = selectedGame.getCoin()
        coinSwitch.setOn(savedCoin, animated: true)
    }
    
    func putSavedWinStatusOnSwitch() {
        var savedWin = selectedGame.getWin()
        winSwitch.setOn(savedWin, animated: true)
    }
    
    // Puts the selected date on the date label
    func putSelectedDateOnLabel() {
        var editedDate = EditDate.sharedInstance.readDate()
        var savedDate = selectedGame.getNSDate()
        //println("Saved Date:")
        //println(savedDate)
        //println("Edited Date:")
        //println(editedDate)
        if editedDate != nil {
            dateLabel.text = "Date: " + EditDate.sharedInstance.dateToString(editedDate!)
        } else {
            dateLabel.text = "Date: " + selectedGame.getDate()
        }
    }
    
    func putSelectedPlayerDeckOnLabel() {
        var savedDeck = selectedGame.getPlayerDeckName()
        var editedDeck = defaults.stringForKey("Edited Deck Name")
        if editedDeck == nil {
            playerDeckLabel.text = "Your deck: " + savedDeck
        } else {
            playerDeckLabel.text = "Your deck: " + editedDeck!
        }
    }
    
    func putSelectedOpponentClassOnLabel() {
        var savedOpponentClass = selectedGame.getOpponentDeck()
        //println(savedOpponentClass)
        var editedOpponentClass = defaults.stringForKey("Edited Opponent Class")
        //println(editedOpponentClass)
        if editedOpponentClass == nil {
            opponentDeckLabel.text = "Opponent's Class: " + savedOpponentClass
        } else {
            opponentDeckLabel.text = "Opponent's Class: " + editedOpponentClass!
        }
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    


    // MARK: - Table view data source

//    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        // #warning Potentially incomplete method implementation.
//        // Return the number of sections.
//        return 0
//    }
//
//    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete method implementation.
//        // Return the number of rows in the section.
//        return 5
//    }
    
    @IBAction func cancelButtonPressed(sender: UIBarButtonItem) {
        
        // Remove all edited stats
        NSUserDefaults.standardUserDefaults().removeObjectForKey("Selected Game")
        NSUserDefaults.standardUserDefaults().removeObjectForKey("Saved Edited Date")
        NSUserDefaults.standardUserDefaults().removeObjectForKey("Edited Deck Name")
        NSUserDefaults.standardUserDefaults().removeObjectForKey("Edited Opponent Class")
        NSUserDefaults.standardUserDefaults().synchronize()
        self.dismissViewControllerAnimated(true, completion: {});
    }
    
    @IBAction func saveButtonPressed(sender: UIBarButtonItem) {
        
        // Get required atributes to create a new Game
        let editedID = selectedGame.getID()
        
        var editedDate = EditDate.sharedInstance.readDate()
        if editedDate == nil {
            editedDate = selectedGame.getNSDate()
        }
        
        var editedPlayerDeckName = defaults.stringForKey("Edited Deck Name")
        if editedPlayerDeckName == nil {
            editedPlayerDeckName = selectedGame.getPlayerDeckName()
        }
        
        var editedPlayerDeckClass = defaults.stringForKey("Edited Deck Class") as String?
        
        var editedOpponentClass = defaults.stringForKey("Edited Opponent Class")
        if editedOpponentClass == nil {
            editedOpponentClass = selectedGame.getOpponentDeck()
        }
        
        var editedCoin = coinSwitch.on
        
        var editedWin = winSwitch.on
        
       
        // Create a new Game object
        var editedGame = Game(newID: editedID, newDate: editedDate!, newPlayerDeckName: editedPlayerDeckName!, newPlayerDeckClass: editedPlayerDeckClass!, newOpponentDeck: editedOpponentClass!, newCoin: editedCoin, newWin: editedWin)
        
        Data.sharedInstance.editGame(editedID, oldGame: selectedGame, newGame: editedGame)
        
        
        // Remove all edited stats
        NSUserDefaults.standardUserDefaults().removeObjectForKey("Selected Game")
        NSUserDefaults.standardUserDefaults().removeObjectForKey("Saved Edited Date")
        NSUserDefaults.standardUserDefaults().removeObjectForKey("Edited Deck Name")
        NSUserDefaults.standardUserDefaults().removeObjectForKey("Edited Opponent Class")
        NSUserDefaults.standardUserDefaults().synchronize()
        self.dismissViewControllerAnimated(true, completion: {});
    }
    
    

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as! UITableViewCell

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
