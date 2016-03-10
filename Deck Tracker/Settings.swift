//
//  Settings.swift
//  Deck Tracker
//
//  Created by Andrei Joghiu on 14/09/15.
//  Copyright (c) 2015 Andrei Joghiu. All rights reserved.
//

import UIKit

class Settings: UITableViewController {

    @IBOutlet weak var resetButton: UIButton!
    
    var iCloudKeyStore: NSUbiquitousKeyValueStore = NSUbiquitousKeyValueStore()
    
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
    
    @IBAction func resetButtonPressed(sender: UIButton) {
        // Create the alert controller
        let alertController = UIAlertController(title: "Full reset", message: "What do you want to delete ?", preferredStyle: .Alert)
        
        // Create the actions
        let resetAllAction = UIAlertAction(title: "Reset everything", style: UIAlertActionStyle.Destructive) {
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
            
            // Remove from iCloud as well
            self.iCloudKeyStore.removeObjectForKey("iCloud list of decks")
            self.iCloudKeyStore.removeObjectForKey("iCloud list of games")
            self.iCloudKeyStore.removeObjectForKey("iCloud All Tags")
            self.iCloudKeyStore.synchronize()
            
            NSLog("Reset everything pressed")
        }
        
        let resetGamesAction = UIAlertAction(title: "Reset all games", style: UIAlertActionStyle.Destructive) {
            UIAlertAction in
            
            // Delete from NSUserDefaults
            NSUserDefaults.standardUserDefaults().removeObjectForKey("List of games")
            Data.sharedInstance.listOfGames = []
            // Sync
            NSUserDefaults.standardUserDefaults().synchronize()
            
            // Remove from iCloud as well
            self.iCloudKeyStore.removeObjectForKey("iCloud list of games")
            self.iCloudKeyStore.synchronize()
            
            NSLog("Reset all games pressed")
            
        }
        
        let resetGamesAndDecksAction = UIAlertAction(title: "Reset all games AND all decks", style: UIAlertActionStyle.Destructive) {
            UIAlertAction in
            
            // Delete from NSUserDefaults
            NSUserDefaults.standardUserDefaults().removeObjectForKey("List of games")
            NSUserDefaults(suiteName: "group.Decks")!.removeObjectForKey("List of decks")
            NSUserDefaults(suiteName: "group.Decks")!.removeObjectForKey("Selected Deck Name")
            Data.sharedInstance.listOfGames = []
            Data.sharedInstance.listOfDecks = []
            // Sync
            NSUserDefaults.standardUserDefaults().synchronize()
            
            // Remove from iCloud as well
            self.iCloudKeyStore.removeObjectForKey("iCloud list of decks")
            self.iCloudKeyStore.removeObjectForKey("iCloud list of games")
            self.iCloudKeyStore.synchronize()
            
            NSLog("Reset all games AND decks pressed")
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel) {
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
