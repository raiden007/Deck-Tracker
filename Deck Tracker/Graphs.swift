//
//  Graphs.swift
//  Deck Tracker
//
//  Created by Andrei Joghiu on 18/5/15.
//  Copyright (c) 2015 Andrei Joghiu. All rights reserved.
//

import UIKit

class Graphs: UIViewController, PiechartDelegate {
    
    @IBOutlet var dateSegment: UISegmentedControl!
    @IBOutlet var deckSegment: UISegmentedControl!
    

    var total: CGFloat = 100
    var dateIndex = -1
    var deckIndex = -1
    var deckName = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getInitialStatus()
        drawPieCharts()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)

        getInitialStatus()
        drawPieCharts()
        
        
        //TODO: create Heroes Playes graph (and not take in consideration selected deck obviously)
        //TODO: create Opponents played graph (to take in consideration)
        //TODO: create withCoin graph
        //TODO: create without coin graph
        //TODO: settings screen where you can customize this
        //TODO: add about in settings screen
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
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
    }
    
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
        drawPieCharts()
    }
    
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
        createWinRatePieChart()
        createHeroesPlayedPieChart()
    }
    
    func createWinRatePieChart() {
        
        var views: [String: UIView] = [:]
        
        var winRate:CGFloat = CGFloat(Data.sharedInstance.generalWinRate(dateIndex, deckName: deckName))
        //println("winRate")
        //println(winRate)
        var loseRate:CGFloat = 100 - winRate
        
        var winSlice = Piechart.Slice()
        winSlice.value = winRate / total
        winSlice.color = UIColor.greenColor()
        winSlice.text = "Win"
        
        var loseSlice = Piechart.Slice()
        loseSlice.value = loseRate / total
        loseSlice.color = UIColor.redColor()
        loseSlice.text = "Loss"
        
        
        var piechart = Piechart()
        piechart.delegate = self
        piechart.title = "% Win"
        piechart.activeSlice = 0
        piechart.layer.borderWidth = 1
        piechart.slices = [winSlice, loseSlice]
        
        piechart.setTranslatesAutoresizingMaskIntoConstraints(false)
        view.addSubview(piechart)
        views["piechart"] = piechart
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[piechart]-|", options: nil, metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-150-[piechart(==200)]", options: nil, metrics: nil, views: views))
    }
    
    func createHeroesPlayedPieChart() {
        var views: [String: UIView] = [:]
        
        var winRate:CGFloat = CGFloat(Data.sharedInstance.generalWinRate(dateIndex, deckName: deckName))
        //println("winRate")
        //println(winRate)
        var loseRate:CGFloat = 100 - winRate
        
        var winSlice = Piechart.Slice()
        winSlice.value = winRate / total
        winSlice.color = UIColor.greenColor()
        winSlice.text = "Win"
        
        var loseSlice = Piechart.Slice()
        loseSlice.value = loseRate / total
        loseSlice.color = UIColor.redColor()
        loseSlice.text = "Loss"
        
        
        var piechart = Piechart()
        piechart.delegate = self
        piechart.title = "% Win"
        piechart.activeSlice = 0
        piechart.layer.borderWidth = 1
        piechart.slices = [winSlice, loseSlice]
        
        piechart.setTranslatesAutoresizingMaskIntoConstraints(false)
        view.addSubview(piechart)
        views["piechart"] = piechart
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[piechart]-|", options: nil, metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-350-[piechart(==200)]", options: nil, metrics: nil, views: views))
    }
    
    
    


    

    
}
