 //
//  Graphs.swift
//  Deck Tracker
//
//  Created by Andrei Joghiu on 18/5/15.
//  Copyright (c) 2015 Andrei Joghiu. All rights reserved.
//

import UIKit

class Graphs: UIViewController, UIPageViewControllerDataSource, PiechartDelegate {
    
    @IBOutlet var dateSegment: UISegmentedControl!
    @IBOutlet var deckSegment: UISegmentedControl!
    @IBOutlet weak var viewContainer: UIView!
    
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    
    var pageViewController: UIPageViewController!
    var pageTitles:NSArray!

    
    
    
    var total: CGFloat = 100
    var dateIndex = -1
    var deckIndex = -1
    var deckName = ""
    
    static let sharedInstance = Graphs()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getInitialStatus()
        
        // Sets the page titles and size of graphs
        self.pageTitles = NSArray(objects: "Win rate", "Heroes played", "Opponents faced", "Going first win rate", "Going second win rate")
        self.pageViewController = self.storyboard?.instantiateViewControllerWithIdentifier("PageViewController") as! UIPageViewController
        self.pageViewController.dataSource = self
        
        let startVC = self.viewControllerAtIndex(0) as GraphsViewController
        let viewControllers = [startVC]
        
        self.pageViewController.setViewControllers(viewControllers, direction: .Forward, animated: true, completion: nil)
        self.pageViewController.view.frame = CGRectMake(0, 150, self.view.frame.width, self.view.frame.size.height - 200)
        self.addChildViewController(self.pageViewController)
        self.view.addSubview(self.pageViewController.view)
        self.pageViewController.didMoveToParentViewController(self)
        
        
    }
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        getInitialStatus()
        
        for gvc in self.pageViewController.viewControllers as! [GraphsViewController] {
            gvc.updateCharts()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // Loads what buttons are pressed
    func getInitialStatus() {
        dateIndex = dateSegment.selectedSegmentIndex
        deckIndex = deckSegment.selectedSegmentIndex
        if deckIndex == 0 {
            //println(deckName)
            if let _ = NSUserDefaults(suiteName: "group.Decks")!.stringForKey("Selected Deck Name") as String! {
                deckName = NSUserDefaults(suiteName: "group.Decks")!.stringForKey("Selected Deck Name") as String!
            } else {
                deckName = ""
            }
        } else {
            deckName = "All"
        }
        
        NSUserDefaults.standardUserDefaults().setInteger(dateIndex, forKey: "Date Index")
        NSUserDefaults.standardUserDefaults().setInteger(deckIndex, forKey: "Deck Index")
        NSUserDefaults.standardUserDefaults().setObject(deckName, forKey: "Deck Name")
        NSUserDefaults.standardUserDefaults().synchronize()
        
        //printStatus()
        
        //Notifies the container that a change occured
        NSNotificationCenter.defaultCenter().postNotificationName("load", object: nil)

    }
    
    // Updates when the date button is changed
    @IBAction func dateChanged(sender: UISegmentedControl) {
        switch dateSegment.selectedSegmentIndex {
        case 0:
            dateIndex = 0
            //println("Last 7 days")
        case 1:
            dateIndex = 1
            //println("Last Month")
        case 2:
            dateIndex = 2
            //println("All games")
        default:
            break
        }
        
        NSUserDefaults.standardUserDefaults().setInteger(dateIndex, forKey: "Date Index")
        NSUserDefaults.standardUserDefaults().synchronize()
        //printStatus()
        
        //Notifies the container that a change occured
        NSNotificationCenter.defaultCenter().postNotificationName("load", object: nil)
        
        for gvc in self.pageViewController.viewControllers as! [GraphsViewController] {
            gvc.updateCharts()
        }

    }
    
    // Updates when the deck button is changed
    @IBAction func deckChanged(sender: UISegmentedControl) {
        switch deckSegment.selectedSegmentIndex {
        case 0:
            if let _ = NSUserDefaults(suiteName: "group.Decks")!.stringForKey("Selected Deck Name") as String! {
                deckName = NSUserDefaults(suiteName: "group.Decks")!.stringForKey("Selected Deck Name") as String!
            } else {
                deckName = ""
            }

            //println("Selected Deck")
        case 1:
            deckName = "All"
            //println("All decks")
        default:
            break
        }
        
        //NSUserDefaults.standardUserDefaults().setInteger(deckIndex, forKey: "Deck Index")
        NSUserDefaults.standardUserDefaults().setObject(deckName, forKey: "Deck Name")
        NSUserDefaults.standardUserDefaults().synchronize()
        //printStatus()
        
        //Notifies the container that a change occured
        NSNotificationCenter.defaultCenter().postNotificationName("load", object: nil)
        
        for gvc in self.pageViewController.viewControllers as! [GraphsViewController] {
            gvc.updateCharts()
        }
        
    }
    
    func printStatus() {
        print("Date Index: " + String(dateIndex))
        print("Deck Index: " + String(deckIndex))
        print("Deck Name: " + String(deckName))
    }
    
    func setSubtitle(slice: Piechart.Slice) -> String {
        return "\(Int(slice.value * 100))% \(slice.text)"
    }
    
    func setInfo(slice: Piechart.Slice) -> String {
        //return "\(Int(slice.value * total))/\(Int(total))"
        return ""
    }
    
    // Shows relevant graphs depending on page
    func viewControllerAtIndex(index: Int) -> GraphsViewController {
        if (self.pageTitles.count == 0) || (index >= self.pageTitles.count) {
            return GraphsViewController()
        }
        let vc: GraphsViewController = self.storyboard?.instantiateViewControllerWithIdentifier("ContentViewController") as! GraphsViewController
        vc.titleText = self.pageTitles[index] as! String
        vc.pageIndex = index
        
        for gvc in self.pageViewController.viewControllers as! [GraphsViewController] {
            gvc.updateCharts()
        }
        
        
        return vc
    }
    
    // Page View Controller data source
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        
        let vc = viewController as! GraphsViewController
        var index = vc.pageIndex as Int
        
        if (index == 0 || index == NSNotFound) {
            return nil
        }
        
        index--
        
        for gvc in self.pageViewController.viewControllers as! [GraphsViewController] {
            gvc.updateCharts()
        }
        
        
        return self.viewControllerAtIndex(index)
    }
    
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        
        let vc = viewController as! GraphsViewController
        var index = vc.pageIndex as Int
        
        if index == NSNotFound {
            return nil
        }
        
        index++
        
        if index == self.pageTitles.count {
            return nil
        }
        
        for gvc in self.pageViewController.viewControllers as! [GraphsViewController] {
            gvc.updateCharts()
        }
        
        return self.viewControllerAtIndex(index)
    }
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return self.pageTitles.count
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }
    

}