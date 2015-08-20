//
//  About.swift
//  Deck Tracker
//
//  Created by Andrei Joghiu on 27/5/15.
//  Copyright (c) 2015 Andrei Joghiu. All rights reserved.
//

import UIKit

class About: UIViewController {

    @IBOutlet var versionLabel: UILabel!
    @IBOutlet var emailButton: UIButton!
    
    let version = "1.1"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        versionLabel.text = "Version: " + version
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func emailButtonPressed(sender: UIButton) {
        let email = "raiden007@gmail.com"
        let url = NSURL(string: "mailto:\(email)")
        UIApplication.sharedApplication().openURL(url!)
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
