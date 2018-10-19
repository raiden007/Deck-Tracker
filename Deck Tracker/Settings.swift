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
    
    @IBAction func resetButtonPressed(_ sender: UIButton) {
        // Create the alert controller
        let alertController = UIAlertController(title: "Full reset", message: "What do you want to delete ?", preferredStyle: .alert)
        
        // Create the actions
        let resetAllAction = UIAlertAction(title: "Reset everything", style: UIAlertAction.Style.destructive) {
            UIAlertAction in
            
            // Delete from NSUserDefaults
            UserDefaults.standard.removeObject(forKey: "List of games")
            UserDefaults(suiteName: "group.Decks")!.removeObject(forKey: "List of decks")
            UserDefaults(suiteName: "group.Decks")!.removeObject(forKey: "Selected Deck Name")
            UserDefaults(suiteName: "group.Decks")!.removeObject(forKey: "All Tags")
            Data.sharedInstance.listOfGames = []
            Data.sharedInstance.listOfDecks = []
            
            // Sync
            UserDefaults.standard.synchronize()
            
            // Remove from iCloud as well
            self.iCloudKeyStore.removeObject(forKey: "iCloud list of decks")
            self.iCloudKeyStore.removeObject(forKey: "iCloud list of games")
            self.iCloudKeyStore.removeObject(forKey: "iCloud All Tags")
            self.iCloudKeyStore.removeObject(forKey: "iCloud Selected Deck Name")
            self.iCloudKeyStore.synchronize()
            
            NSLog("Reset everything pressed")
        }
        
        let resetGamesAction = UIAlertAction(title: "Reset all games", style: UIAlertAction.Style.destructive) {
            UIAlertAction in
            
            // Delete from NSUserDefaults
            UserDefaults.standard.removeObject(forKey: "List of games")
            Data.sharedInstance.listOfGames = []
            // Sync
            UserDefaults.standard.synchronize()
            
            // Remove from iCloud as well
            self.iCloudKeyStore.removeObject(forKey: "iCloud list of games")
            self.iCloudKeyStore.synchronize()
            
            NSLog("Reset all games pressed")
            
        }
        
        let resetGamesAndDecksAction = UIAlertAction(title: "Reset all games AND all decks", style: UIAlertAction.Style.destructive) {
            UIAlertAction in
            
            // Delete from NSUserDefaults
            UserDefaults.standard.removeObject(forKey: "List of games")
            UserDefaults(suiteName: "group.Decks")!.removeObject(forKey: "List of decks")
            UserDefaults(suiteName: "group.Decks")!.removeObject(forKey: "Selected Deck Name")
            Data.sharedInstance.listOfGames = []
            Data.sharedInstance.listOfDecks = []
            // Sync
            UserDefaults.standard.synchronize()
            
            // Remove from iCloud as well
            self.iCloudKeyStore.removeObject(forKey: "iCloud list of decks")
            self.iCloudKeyStore.removeObject(forKey: "iCloud list of games")
            self.iCloudKeyStore.removeObject(forKey: "iCloud Selected Deck Name")
            self.iCloudKeyStore.synchronize()
            
            NSLog("Reset all games AND decks pressed")
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel) {
            UIAlertAction in
            NSLog("Cancel Pressed")
        }
        
        // Add the actions
        alertController.addAction(resetAllAction)
        alertController.addAction(resetGamesAction)
        alertController.addAction(resetGamesAndDecksAction)
        alertController.addAction(cancelAction)
        
        // Present the controller
        self.present(alertController, animated: true, completion: nil)

    }
    
    // When selecting the table cell from the first section have reset all button press
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
           resetButtonPressed(self.resetButton)
        }
    }
}
