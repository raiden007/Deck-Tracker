//
//  GraphsTable.swift
//  Deck Tracker
//
//  Created by Andrei Joghiu on 27/09/15.
//  Copyright © 2015 Andrei Joghiu. All rights reserved.
//

import UIKit

class GraphsTable: UITableViewController {

    @IBOutlet var graphsTable: UITableView!
    
    
    var numberOfRows = 0
    var deckName = ""
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "loadList:",name:"load", object: nil)

    }
    
    override func viewDidAppear(animated: Bool) {
        loadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return numberOfRows
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        let cell:GraphsCell = tableView.dequeueReusableCellWithIdentifier("Cell") as! GraphsCell

        // Configure the cell...
        cell.playerDeckLabel.text = "Get in here !!!"
        cell.winPercentLabel.text = "80%"
        cell.gamesListLabel.text = "21-10"
        cell.opponentLabel.text = "Paladin"

        return cell
    }
    
    func loadList(notification: NSNotification){
        //Gets info on rows and reloads the table view
        loadData()
        self.graphsTable.reloadData()
    }
    
    
    func getNumberOfRows() {
        if let _ = NSUserDefaults.standardUserDefaults().stringForKey("Deck Name") {
            deckName = NSUserDefaults.standardUserDefaults().stringForKey("Deck Name") as String!
        }
        print(deckName)
        if deckName == "All" {
            numberOfRows = 10
        } else {
            numberOfRows = 2
        }
        
        print("Number of rows to be displayed: " + String(numberOfRows))
        //reloadData()
    }
    
    func loadData() {
        //TODO: Load all data needed to display the table view
        getNumberOfRows()
    }

}
