//
//  GraphsViewController.swift
//  Deck Tracker
//
//  Created by Andrei Joghiu on 22/5/15.
//  Copyright (c) 2015 Andrei Joghiu. All rights reserved.
//

import UIKit

class GraphsViewController: UIViewController, PiechartDelegate {

    @IBOutlet var titleLabel: UILabel!
    
    var pageIndex: Int!
    var titleText: String!
    var total: CGFloat = 100
    var dateIndex = -1
    var deckIndex = -1
    var deckName = ""
    
    static let sharedInstance = GraphsViewController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.titleLabel.text = self.titleText
        getButtonsStatus()
        drawPieChart()
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        self.titleLabel.text = self.titleText
        getButtonsStatus()
        
    }
    
    func getButtonsStatus() {
        dateIndex = NSUserDefaults.standardUserDefaults().integerForKey("Date Index")
        deckIndex = NSUserDefaults.standardUserDefaults().integerForKey("Deck Index")
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
    
    
    func drawPieChart() {
        if self.titleLabel.text == "Win Rate" {
            createWinRatePieChart()
        }
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func createWinRatePieChart() {
        
        var views: [String: UIView] = [:]
        
        var winRate:CGFloat = CGFloat(Data.sharedInstance.generalWinRate(dateIndex, deckName: deckName))
        println("Win Rate: " + String(stringInterpolationSegment: winRate))
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
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-125-[piechart(==200)]", options: nil, metrics: nil, views: views))
    }
    
    func setSubtitle(slice: Piechart.Slice) -> String {
        return "\(Int(slice.value * 100))% \(slice.text)"
    }
    
    func setInfo(slice: Piechart.Slice) -> String {
        //return "\(Int(slice.value * total))/\(Int(total))"
        return ""
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
