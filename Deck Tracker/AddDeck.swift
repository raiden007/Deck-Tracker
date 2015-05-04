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
        
        println("Count Test: " + countTest)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func cancelButtonPressed(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: {})
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
        
        var matchesCount = NSUserDefaults.standardUserDefaults().integerForKey("Matches Count");
        matchesCount++
        NSUserDefaults.standardUserDefaults().setInteger(matchesCount, forKey: "Matches Count");
        NSUserDefaults.standardUserDefaults().synchronize()
        
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
