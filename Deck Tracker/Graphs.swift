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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //createPlayedHeroesPieChart()
        //createOpponentClassesPieChart()
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        createWinRatePieChart()
        //TODO: create variables based on the buttons
        //TODO: create win rate graph
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
    
    func setSubtitle(slice: Piechart.Slice) -> String {
        return "\(Int(slice.value * 100))% \(slice.text)"
    }
    
    func setInfo(slice: Piechart.Slice) -> String {
        //return "\(Int(slice.value * total))/\(Int(total))"
        return ""
    }
    
    func createWinRatePieChart() {
        
        var views: [String: UIView] = [:]
        let selectedDeckName = NSUserDefaults.standardUserDefaults().stringForKey("Selected Deck Name") as String!
        
        var winRate:CGFloat = CGFloat(Data.sharedInstance.generalWinRate(1, deckName: selectedDeckName))
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

    

    
}
