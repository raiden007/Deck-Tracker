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

    @IBAction func resetAllButtonPressed(sender: UIButton) {
        
        println("a")
        
    }
    

}
