//
//  Graphs.swift
//  Deck Tracker
//
//  Created by Andrei Joghiu on 18/5/15.
//  Copyright (c) 2015 Andrei Joghiu. All rights reserved.
//

import UIKit

class Graphs: UIViewController, UIPageViewControllerDataSource, PiechartDelegate  {
    
    @IBOutlet var dateSegment: UISegmentedControl!
    @IBOutlet var deckSegment: UISegmentedControl!
    
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
        
        self.pageTitles = NSArray(objects: "Win Rate", "Heroes Played", "Opponents Faced", "With Coin WinRate", "Without Coin WinRate")
        self.pageViewController = self.storyboard?.instantiateViewControllerWithIdentifier("PageViewController") as! UIPageViewController
        self.pageViewController.dataSource = self
        
        var startVC = self.viewControllerAtIndex(0) as GraphsViewController
        var viewControllers = [startVC]
        
        self.pageViewController.setViewControllers(viewControllers, direction: .Forward, animated: true, completion: nil)
        self.pageViewController.view.frame = CGRectMake(0, 150, self.view.frame.width, self.view.frame.size.height - 200)
        self.addChildViewController(self.pageViewController)
        self.view.addSubview(self.pageViewController.view)
        self.pageViewController.didMoveToParentViewController(self)
        
    }
    
    override func viewDidAppear(animated: Bool) {
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
            //println(deckName)
            var testNilValue = NSUserDefaults.standardUserDefaults().stringForKey("Selected Deck Name") as String!
            if testNilValue == nil {
                deckName = ""
            } else {
                deckName = NSUserDefaults.standardUserDefaults().stringForKey("Selected Deck Name") as String!
            }
        } else {
            deckName = "All"
        }
        
        NSUserDefaults.standardUserDefaults().setInteger(dateIndex, forKey: "Date Index")
        NSUserDefaults.standardUserDefaults().setInteger(deckIndex, forKey: "Deck Index")
        NSUserDefaults.standardUserDefaults().setObject(deckName, forKey: "Deck Name")
        NSUserDefaults.standardUserDefaults().synchronize()
        
        println("Date Index: " + String(dateIndex))
        println("Deck Index: " + String(deckIndex))
        println("Deck Name: " + String(deckName))
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
        
        for gvc in self.pageViewController.viewControllers as! [GraphsViewController] {
            gvc.updateCharts()
        }

    }
    
    // Updates when the deck button is changed
    @IBAction func deckChanged(sender: UISegmentedControl) {
        switch deckSegment.selectedSegmentIndex {
        case 0:
            var testNilValue = NSUserDefaults.standardUserDefaults().stringForKey("Selected Deck Name") as String!
            if testNilValue == nil {
                deckName = ""
            } else {
               deckName = NSUserDefaults.standardUserDefaults().stringForKey("Selected Deck Name") as String!
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
        
        for gvc in self.pageViewController.viewControllers as! [GraphsViewController] {
            gvc.updateCharts()
        }
        
    }
    
    
    
    func setSubtitle(slice: Piechart.Slice) -> String {
        return "\(Int(slice.value * 100))% \(slice.text)"
    }
    
    func setInfo(slice: Piechart.Slice) -> String {
        //return "\(Int(slice.value * total))/\(Int(total))"
        return ""
    }
    
    func drawPieCharts() {
        //createWinRatePieChart()
        //createHeroesPlayedPieChart()
        //createOpponentsPlayedPieChart()
    }
    
    func getDateIndex() -> Int {
        return dateIndex
    }
    
    
    
    

    
    

    
    func viewControllerAtIndex(index: Int) -> GraphsViewController {
        if (self.pageTitles.count == 0) || (index >= self.pageTitles.count) {
            return GraphsViewController()
        }
        
        var vc: GraphsViewController = self.storyboard?.instantiateViewControllerWithIdentifier("ContentViewController") as! GraphsViewController
        vc.titleText = self.pageTitles[index] as! String
        vc.pageIndex = index
        
        return vc
        
    }
    
    // Page View Controller data source
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        
        var vc = viewController as! GraphsViewController
        var index = vc.pageIndex as Int
        
        if (index == 0 || index == NSNotFound) {
            return nil
        }
        
        index--
        return self.viewControllerAtIndex(index)
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        
        var vc = viewController as! GraphsViewController
        var index = vc.pageIndex as Int
        
        if index == NSNotFound {
            return nil
        }
        
        index++
        
        if index == self.pageTitles.count {
            return nil
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
