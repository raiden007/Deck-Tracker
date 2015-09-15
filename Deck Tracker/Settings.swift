//
//  Settings.swift
//  Deck Tracker
//
//  Created by Andrei Joghiu on 14/09/15.
//  Copyright (c) 2015 Andrei Joghiu. All rights reserved.
//

import UIKit

class Settings: UITableViewController {

    
    
    @IBOutlet weak var resetAllButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // Selects the row and saves the info so we can add a checkmark
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //var cell = tableView.cellForRowAtIndexPath(indexPath)
        //cell?.accessoryType = UITableViewCellAccessoryType.Checkmark
        
        if indexPath.row == 0 {
            // Create the alert controller
            var alertController = UIAlertController(title: "Full reset", message: "What do you want to delete ?", preferredStyle: .Alert)
            
            // Create the actions
            var resetAllAction = UIAlertAction(title: "Reset everything", style: UIAlertActionStyle.Destructive) {
                UIAlertAction in
                
                // Delete from NSUserDefaults
                NSUserDefaults.standardUserDefaults().removeObjectForKey("List of games")
                NSUserDefaults(suiteName: "group.Decks")!.removeObjectForKey("List of decks")
                NSUserDefaults(suiteName: "group.Decks")!.removeObjectForKey("Selected Deck Name")
                NSUserDefaults(suiteName: "group.Decks")!.removeObjectForKey("All Tags")
                Data.sharedInstance.listOfGames = []
                Data.sharedInstance.listOfDecks = []
                
                // Sync
                NSUserDefaults.standardUserDefaults().synchronize()
                
                NSLog("Reset everything pressed")
            }
            
            var resetGamesAction = UIAlertAction(title: "Reset all games", style: UIAlertActionStyle.Destructive) {
                UIAlertAction in
                
                // Delete from NSUserDefaults
                NSUserDefaults.standardUserDefaults().removeObjectForKey("List of games")
                Data.sharedInstance.listOfGames = []
                // Sync
                NSUserDefaults.standardUserDefaults().synchronize()
                
                NSLog("Reset all games pressed")
                
            }
            
            var resetGamesAndDecksAction = UIAlertAction(title: "Reset all games AND all decks", style: UIAlertActionStyle.Destructive) {
                UIAlertAction in
                
                // Delete from NSUserDefaults
                NSUserDefaults.standardUserDefaults().removeObjectForKey("List of games")
                NSUserDefaults(suiteName: "group.Decks")!.removeObjectForKey("List of decks")
                NSUserDefaults(suiteName: "group.Decks")!.removeObjectForKey("Selected Deck Name")
                Data.sharedInstance.listOfGames = []
                Data.sharedInstance.listOfDecks = []
                // Sync
                NSUserDefaults.standardUserDefaults().synchronize()
                
                NSLog("Reset all games AND decks pressed")
            }
            
            var cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel) {
                UIAlertAction in
                NSLog("Cancel Pressed")
            }
            
            // Add the actions
            alertController.addAction(resetAllAction)
            alertController.addAction(resetGamesAction)
            alertController.addAction(resetGamesAndDecksAction)
            alertController.addAction(cancelAction)
            
            // Present the controller
            self.presentViewController(alertController, animated: true, completion: nil)
        }
    }
}
