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
        
        self.pageTitles = NSArray(objects: "Win Rate", "Heroes Playes", "Opponents Faced", "With Coin WinRate", "Without Coin WinRate")
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
        drawPieCharts()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // Loads what buttons are pressed
    func getInitialStatus() {
        dateIndex = dateSegment.selectedSegmentIndex
        deckIndex = deckSegment.selectedSegmentIndex
        if deckIndex == 0 {
            println(deckName)
            var testNilValue = NSUserDefaults.standardUserDefaults().stringForKey("Selected Deck Name") as String!
            if testNilValue == nil {
                deckName = ""
            } else {
                deckName = NSUserDefaults.standardUserDefaults().stringForKey("Selected Deck Name") as String!
            }
        } else {
            deckName = "All"
        }
        
        //println("Date Index: " + String(dateIndex))
        //println("Deck Index: " + String(deckIndex))
        //println("Deck Name: " + String(deckName))
    }
    
    // Updates when the date button is changed
    @IBAction func dateChanged(sender: UISegmentedControl) {
        switch dateSegment.selectedSegmentIndex {
        case 0:
            dateIndex = 0
            NSUserDefaults.standardUserDefaults().setInteger(dateIndex, forKey: "Date Index")
            NSUserDefaults.standardUserDefaults().synchronize()
            println("Date Index: " + String(dateIndex))
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
        //GraphsViewController.sharedInstance.drawPieChart()
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
        drawPieCharts()
        
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
    
    
    // Creates the Win Rate Pie Chart
//    func createWinRatePieChart() {
//        
//        var views: [String: UIView] = [:]
//        
//        var winRate:CGFloat = CGFloat(Data.sharedInstance.generalWinRate(dateIndex, deckName: deckName))
//        //println("winRate")
//        //println(winRate)
//        var loseRate:CGFloat = 100 - winRate
//        
//        var winSlice = Piechart.Slice()
//        winSlice.value = winRate / total
//        winSlice.color = UIColor.greenColor()
//        winSlice.text = "Win"
//        
//        var loseSlice = Piechart.Slice()
//        loseSlice.value = loseRate / total
//        loseSlice.color = UIColor.redColor()
//        loseSlice.text = "Loss"
//        
//        
//        var piechart = Piechart()
//        piechart.delegate = self
//        piechart.title = "% Win"
//        piechart.activeSlice = 0
//        piechart.layer.borderWidth = 1
//        piechart.slices = [winSlice, loseSlice]
//        
//        piechart.setTranslatesAutoresizingMaskIntoConstraints(false)
//        view.addSubview(piechart)
//        views["piechart"] = piechart
//        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[piechart]-|", options: nil, metrics: nil, views: views))
//        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-125-[piechart(==200)]", options: nil, metrics: nil, views: views))
//    }
    
    
    // Creates the Heroes Played Pie Chart
    func createHeroesPlayedPieChart() {
        var views: [String: UIView] = [:]
        
        var heroesPlayed:[Int] = []
        heroesPlayed = Data.sharedInstance.heroesPlayed(dateIndex)
        var totalGames = heroesPlayed[0] + heroesPlayed[1] + heroesPlayed[2] + heroesPlayed[3] + heroesPlayed[4] + heroesPlayed[5] + heroesPlayed[6] + heroesPlayed[7] + heroesPlayed[8]
        
        if totalGames == 0 {
            totalGames = 1
        }
        
        var warriorSlice = Piechart.Slice()
        warriorSlice.value = CGFloat(heroesPlayed[0]) / CGFloat(totalGames)
        warriorSlice.color = UIColor.redColor()
        warriorSlice.text = "Warrior"
        
        var paladinSlice = Piechart.Slice()
        paladinSlice.value = CGFloat(heroesPlayed[1]) / CGFloat(totalGames)
        paladinSlice.color = UIColor.yellowColor()
        paladinSlice.text = "Paladin"
        
        var shamanSlice = Piechart.Slice()
        shamanSlice.value = CGFloat(heroesPlayed[2]) / CGFloat(totalGames)
        shamanSlice.color = UIColor.blueColor()
        shamanSlice.text = "Shaman"
        
        var hunterSlice = Piechart.Slice()
        hunterSlice.value = CGFloat(heroesPlayed[3]) / CGFloat(totalGames)
        hunterSlice.color = UIColor.greenColor()
        hunterSlice.text = "Hunter"
        
        var druidSlice = Piechart.Slice()
        druidSlice.value = CGFloat(heroesPlayed[4]) / CGFloat(totalGames)
        druidSlice.color = UIColor.brownColor()
        druidSlice.text = "Druid"
        
        var rogueSlice = Piechart.Slice()
        rogueSlice.value = CGFloat(heroesPlayed[5]) / CGFloat(totalGames)
        rogueSlice.color = UIColor.darkGrayColor()
        rogueSlice.text = "Rogue"
        
        var mageSlice = Piechart.Slice()
        mageSlice.value = CGFloat(heroesPlayed[6]) / CGFloat(totalGames)
        mageSlice.color = UIColor.cyanColor()
        mageSlice.text = "Mage"
        
        var warlockSlice = Piechart.Slice()
        warlockSlice.value = CGFloat(heroesPlayed[7]) / CGFloat(totalGames)
        warlockSlice.color = UIColor.purpleColor()
        warlockSlice.text = "Warlock"
        
        var priestSlice = Piechart.Slice()
        priestSlice.value = CGFloat(heroesPlayed[8]) / CGFloat(totalGames)
        priestSlice.color = UIColor.lightGrayColor()
        priestSlice.text = "Priest"
        

        var piechart = Piechart()
        piechart.delegate = self
        piechart.title = "Heroes"
        piechart.activeSlice = 0
        piechart.layer.borderWidth = 1
        piechart.slices = [warriorSlice, paladinSlice, shamanSlice, hunterSlice, druidSlice, rogueSlice, mageSlice, warlockSlice, priestSlice]
        
        piechart.setTranslatesAutoresizingMaskIntoConstraints(false)
        view.addSubview(piechart)
        views["piechart"] = piechart
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[piechart]-|", options: nil, metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-300-[piechart(==200)]", options: nil, metrics: nil, views: views))
    }
    
    
    // Creates the opponents played pie chart
    func createOpponentsPlayedPieChart() {
        var views: [String: UIView] = [:]
        
        var opponentsPlayed:[Int] = Data.sharedInstance.opponentsPlayed(dateIndex, deckName: deckName)
        var totalGames = opponentsPlayed[0] + opponentsPlayed[1] + opponentsPlayed[2] + opponentsPlayed[3] + opponentsPlayed[4] + opponentsPlayed[5] + opponentsPlayed[6] + opponentsPlayed[7] + opponentsPlayed[8]
        if totalGames == 0 {
            totalGames = 1
        }
        
        println("Opponents Played array: " + String(stringInterpolationSegment: opponentsPlayed))
        println("Total Games count : " + String(totalGames))
        
        var warriorSlice = Piechart.Slice()
        warriorSlice.value = CGFloat(opponentsPlayed[0]) / CGFloat(totalGames)
        warriorSlice.color = UIColor.redColor()
        warriorSlice.text = "Warrior"
        
        var paladinSlice = Piechart.Slice()
        paladinSlice.value = CGFloat(opponentsPlayed[1]) / CGFloat(totalGames)
        paladinSlice.color = UIColor.yellowColor()
        paladinSlice.text = "Paladin"
        
        var shamanSlice = Piechart.Slice()
        shamanSlice.value = CGFloat(opponentsPlayed[2]) / CGFloat(totalGames)
        shamanSlice.color = UIColor.blueColor()
        shamanSlice.text = "Shaman"
        
        var hunterSlice = Piechart.Slice()
        hunterSlice.value = CGFloat(opponentsPlayed[3]) / CGFloat(totalGames)
        hunterSlice.color = UIColor.greenColor()
        hunterSlice.text = "Hunter"
        
        var druidSlice = Piechart.Slice()
        druidSlice.value = CGFloat(opponentsPlayed[4]) / CGFloat(totalGames)
        druidSlice.color = UIColor.brownColor()
        druidSlice.text = "Druid"
        
        var rogueSlice = Piechart.Slice()
        rogueSlice.value = CGFloat(opponentsPlayed[5]) / CGFloat(totalGames)
        rogueSlice.color = UIColor.darkGrayColor()
        rogueSlice.text = "Rogue"
        
        var mageSlice = Piechart.Slice()
        mageSlice.value = CGFloat(opponentsPlayed[6]) / CGFloat(totalGames)
        mageSlice.color = UIColor.cyanColor()
        mageSlice.text = "Mage"
        
        var warlockSlice = Piechart.Slice()
        warlockSlice.value = CGFloat(opponentsPlayed[7]) / CGFloat(totalGames)
        warlockSlice.color = UIColor.purpleColor()
        warlockSlice.text = "Warlock"
        
        var priestSlice = Piechart.Slice()
        priestSlice.value = CGFloat(opponentsPlayed[8]) / CGFloat(totalGames)
        priestSlice.color = UIColor.lightGrayColor()
        priestSlice.text = "Priest"
        
        
        var piechart = Piechart()
        piechart.delegate = self
        piechart.title = "Opponents"
        piechart.activeSlice = 0
        piechart.layer.borderWidth = 1
        piechart.slices = [warriorSlice, paladinSlice, shamanSlice, hunterSlice, druidSlice, rogueSlice, mageSlice, warlockSlice, priestSlice]
        
        piechart.setTranslatesAutoresizingMaskIntoConstraints(false)
        view.addSubview(piechart)
        views["piechart"] = piechart
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[piechart]-|", options: nil, metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-450-[piechart(==200)]", options: nil, metrics: nil, views: views))
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
