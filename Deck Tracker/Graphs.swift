 //
//  Graphs.swift
//  Deck Tracker
//
//  Created by Andrei Joghiu on 18/5/15.
//  Copyright (c) 2015 Andrei Joghiu. All rights reserved.
//

import UIKit

class Graphs: UIViewController {
    
    @IBOutlet var dateSegment: UISegmentedControl!
    @IBOutlet var deckSegment: UISegmentedControl!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var graphContainerBottomConstraint: NSLayoutConstraint!

    var total: CGFloat = 100
    var dateIndex = -1
    var deckIndex = -1
    var deckName = ""
    static let sharedInstance = Graphs()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getInitialStatus()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        getInitialStatus()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // Loads what buttons are pressed
    func getInitialStatus() {
        dateIndex = dateSegment.selectedSegmentIndex
        deckIndex = deckSegment.selectedSegmentIndex
        if deckIndex == 0 {
            if let _ = UserDefaults(suiteName: "group.Decks")!.string(forKey: "Selected Deck Name") as String! {
                deckName = UserDefaults(suiteName: "group.Decks")!.string(forKey: "Selected Deck Name") as String!
            } else {
                deckName = ""
            }
        } else {
            deckName = "All"
        }
        
        UserDefaults.standard.set(dateIndex, forKey: "Date Index")
        UserDefaults.standard.set(deckIndex, forKey: "Deck Index")
        UserDefaults.standard.set(deckName, forKey: "Deck Name")
        UserDefaults.standard.synchronize()
        
        // Notifies the container that a change occured
        NotificationCenter.default.post(name: Notification.Name(rawValue: "load"), object: nil)
    }
    
    // Updates when the date button is changed
    @IBAction func dateChanged(_ sender: UISegmentedControl) {
        switch dateSegment.selectedSegmentIndex {
        case 0:
            // Last 7 days
            dateIndex = 0
        case 1:
            // Last mont
            dateIndex = 1
        case 2:
            // All games
            dateIndex = 2
        default:
            break
        }
        
        UserDefaults.standard.set(dateIndex, forKey: "Date Index")
        UserDefaults.standard.synchronize()
        //Notifies the container that a change occured
        NotificationCenter.default.post(name: Notification.Name(rawValue: "load"), object: nil)

    }
    
    // Updates when the deck button is changed
    @IBAction func deckChanged(_ sender: UISegmentedControl) {
        switch deckSegment.selectedSegmentIndex {
        // Selected deck
        case 0:
            if let _ = UserDefaults(suiteName: "group.Decks")!.string(forKey: "Selected Deck Name") as String! {
                deckName = UserDefaults(suiteName: "group.Decks")!.string(forKey: "Selected Deck Name") as String!
            } else {
                deckName = ""
            }
        // All decks
        case 1:
            deckName = "All"
        default:
            break
        }
        
        UserDefaults.standard.set(deckName, forKey: "Deck Name")
        UserDefaults.standard.synchronize()
        //Notifies the container that a change occured
        NotificationCenter.default.post(name: Notification.Name(rawValue: "load"), object: nil)
        
    }
    
    func printStatus() {
        print("Date Index: " + String(dateIndex))
        print("Deck Index: " + String(deckIndex))
        print("Deck Name: " + String(deckName))
    }
}
