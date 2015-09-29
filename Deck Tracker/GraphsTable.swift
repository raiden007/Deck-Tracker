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
        
        getNumberOfRows()
    }
    
    override func viewDidAppear(animated: Bool) {
        getNumberOfRows()
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
    
    func reloadData() {
        //self.graphsTable.reloadData()
        dispatch_async(dispatch_get_main_queue()) {
            self.graphsTable.reloadData()
        }
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
        reloadData()
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
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
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
