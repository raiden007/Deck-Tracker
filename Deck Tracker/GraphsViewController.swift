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
    var deckName = ""

    
    static let sharedInstance = GraphsViewController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.titleLabel.text = self.titleText
        drawPieChart()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        self.titleLabel.text = self.titleText
        drawPieChart()

    }
    
    


    func drawPieChart() {
        
        var dateIndex = NSUserDefaults.standardUserDefaults().integerForKey("Date Index")
        var deckName = NSUserDefaults.standardUserDefaults().stringForKey("Deck Name") as String!
        println("Date Index: " + String(dateIndex))
        println("Deck Name: " + String(stringInterpolationSegment: deckName))
        
        if self.titleLabel.text == "Win Rate" {
            createWinRatePieChart(dateIndex, deckName: deckName!)
        } else if self.titleLabel.text == "Heroes Played" {
            createHeroesPlayedPieChart(dateIndex)
        } else if self.titleLabel.text == "Opponents Faced" {
            createOpponentsPlayedPieChart(dateIndex, deckName: deckName!)
        }
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func createWinRatePieChart(dateIndex:Int, deckName:String) {
        
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
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-25-[piechart(==200)]", options: nil, metrics: nil, views: views))
    }
    
    // Creates the Heroes Played Pie Chart
    func createHeroesPlayedPieChart(dateIndex:Int) {
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
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-25-[piechart(==200)]", options: nil, metrics: nil, views: views))
    }
    
    // Creates the opponents played pie chart
    func createOpponentsPlayedPieChart(dateIndex:Int, deckName:String) {
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
        piechart.title = "Opponent"
        piechart.activeSlice = 0
        piechart.layer.borderWidth = 1
        piechart.slices = [warriorSlice, paladinSlice, shamanSlice, hunterSlice, druidSlice, rogueSlice, mageSlice, warlockSlice, priestSlice]
        
        piechart.setTranslatesAutoresizingMaskIntoConstraints(false)
        view.addSubview(piechart)
        views["piechart"] = piechart
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[piechart]-|", options: nil, metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-25-[piechart(==200)]", options: nil, metrics: nil, views: views))
    }
    
    func setSubtitle(slice: Piechart.Slice) -> String {
        return "\(Int(slice.value * 100))% \(slice.text)"
    }
    
    func setInfo(slice: Piechart.Slice) -> String {
        //return "\(Int(slice.value * total))/\(Int(total))"
        return ""
    }
    
    func updateCharts() {

        drawPieChart()
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
