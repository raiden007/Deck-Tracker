//
//  AppDelegate.swift
//  Deck Tracker
//
//  Created by Andrei Joghiu on 28/4/15.
//  Copyright (c) 2015 Andrei Joghiu. All rights reserved.
//

import UIKit
import Fabric
import Crashlytics

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var deckListForPhone:[NSDictionary] = []

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch
        
        // Crashlytics
        Fabric.with([Crashlytics()])
        
        // Initialize the data structure and print it to the console at app launch
        Data.init()
        Data.sharedInstance.convertDataFromVersion1ToVersion2()
        Data.sharedInstance.printGameData()
        Data.sharedInstance.printDeckData()
        
        // Show page UI for graphs
        var pageControl = UIPageControl.appearance()
        pageControl.pageIndicatorTintColor = UIColor.lightGrayColor()
        pageControl.currentPageIndicatorTintColor = UIColor.blackColor()
        pageControl.backgroundColor = UIColor.whiteColor()
        
        // Show tab 2 at startup
        if let tabBarController = self.window!.rootViewController as? UITabBarController {
            tabBarController.selectedIndex = 1
        }
        

        
        return true
    }
    
    // Executes the code when the watch sends a request
    func application(application: UIApplication, handleWatchKitExtensionRequest userInfo: [NSObject : AnyObject]?, reply: (([NSObject : AnyObject]!) -> Void)!) {
        
        var infoFromWatch: NSDictionary = userInfo!
        println(infoFromWatch)

        // Depending on what screen this function is called do stuff
        if let val: AnyObject = infoFromWatch["Save New Game"] {
            saveGameFromWatch()
        } else  {
            println("test")
            saveSelectedDeckFromWatch()
        }
    }
    
    func saveGameFromWatch() {
        // Fetches the saved dictionary
        let defaults = NSUserDefaults(suiteName: "group.Decks")!
        var dict: NSDictionary = defaults.objectForKey("Add Game Watch") as! NSDictionary
        
        // Gets the values needed from the dictionary and adds a New Game
        let gameID = AddGame().newGameGetID()
        let date = NSDate()
        let playerDeckName = dict["selectedDeckName"] as! String
        let playerDeckClass = dict["selectedDeckClass"] as! String
        let opponentClass = dict["watchOpponentClass"] as! String
        let coin = dict["coin"] as! Bool
        let win = dict["win"] as! Bool
        let tags = dict["watchSelectedTags"] as! [String]
        
        var newGame = Game(newID: gameID, newDate: date, newPlayerDeckName: playerDeckName, newPlayerDeckClass: playerDeckClass, newOpponentDeck: opponentClass, newCoin: coin, newWin: win, newNote: tags)
        Data.sharedInstance.addGame(newGame)
        
        // Posts a notification for another screen (Games List)
        NSNotificationCenter.defaultCenter().postNotificationName("GameAdded", object: nil)
    }
    
    func saveSelectedDeckFromWatch() {
        // Posts a notification for another screen (Decks List)
        NSNotificationCenter.defaultCenter().postNotificationName("DeckSelected", object: nil)
    }


    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    



}

