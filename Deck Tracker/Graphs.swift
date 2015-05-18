//
//  Graphs.swift
//  Deck Tracker
//
//  Created by Andrei Joghiu on 18/5/15.
//  Copyright (c) 2015 Andrei Joghiu. All rights reserved.
//

import UIKit

class Graphs: UIViewController, PiechartDelegate {

    var total: CGFloat = 100
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var views: [String: UIView] = [:]
        
        var winRate:CGFloat = CGFloat(Data.sharedInstance.generalWinRate())
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
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-200-[piechart(==200)]", options: nil, metrics: nil, views: views))
        
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
}
