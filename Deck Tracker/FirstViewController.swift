//
//  FirstViewController.swift
//  Deck Tracker
//
//  Created by Andrei Joghiu on 28/4/15.
//  Copyright (c) 2015 Andrei Joghiu. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UITableViewDelegate, UINavigationBarDelegate {
    
    @IBOutlet var decksTable: UITableView!
    
    var decksList:[Deck] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        readData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Gets the number of rows to be displayed in the table
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return decksList.count
    }
    
    // Populates the table with data
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "Cell")
        let cell:CustomCell = tableView.dequeueReusableCellWithIdentifier("Cell") as! CustomCell
        //cell.textLabel?.text = decksList[indexPath.row].toString()
        cell.customLabel.text = decksList[indexPath.row].getName()
        var image = decksList[indexPath.row].getClass()
        var imageName = getImage(image)
        cell.customImage.image = UIImage(named: imageName)
        return cell
    }
    
    // Refreshes the view after adding a deck
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        readData()
        decksTable.reloadData()
    }
    
    // Reads the data from Data file
    func readData() {
        if Data.sharedInstance.readDeckData() == nil {
            
        } else {
            decksList = Data.sharedInstance.readDeckData()!
        }
    }
    
    // Deletes the row
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            var index = indexPath.row
            Data.sharedInstance.deleteDeck(index)
            readData()
            self.decksTable.reloadData()
            println("Deck deleted")
        }
    }
    
    // Returns the image depeding on the deck class
    func getImage (str:String) -> String {
        
        if str == "Warrior" {
            return "WarriorSmall"
        } else if str == "Paladin" {
            return "PaladinSmall"
        } else if str == "Shaman" {
            return "ShamanSmall"
        } else if str == "Druid" {
            return "DruidSmall"
        } else if str == "Rogue" {
            return "RogueSmall"
        } else if str == "Mage" {
            return "MageSmall"
        } else if str == "Warlock" {
            return "WarlockSmall"
        } else if str == "Priest" {
            return "PriestSmall"
        } else if str == "Hunter" {
            return "HunterSmall"
        } else {
            return ""
        }
        
        
    }
    
    // Have the nav bar show ok. 
    // You need to crtl+drag the nav bar to the view controller in storyboard to create a delegate
    // Then add "UINavigationBarDelegate" to the class on top
    // And move the nav bar 20 points down
    func positionForBar(bar: UIBarPositioning) -> UIBarPosition  {
        return UIBarPosition.TopAttached
    }

}

