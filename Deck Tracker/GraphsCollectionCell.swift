//
//  GraphsCollectionCell.swift
//  Deck Tracker
//
//  Created by Andrei Joghiu on 22/10/15.
//  Copyright © 2015 Andrei Joghiu. All rights reserved.
//

import UIKit

class GraphsCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var versusLabel: UILabel!
    @IBOutlet weak var graphsLabel: UILabel!
    @IBOutlet weak var winInfoLabel: UILabel!
    
    
    override func drawRect(rect: CGRect) {
        let path = UIBezierPath(ovalInRect: rect)
        let graphs = graphsLabel.text as String!
        var winRateString = ""
        var index1 = graphs.endIndex.advancedBy(-2)
        
        var substring1 = graphs.substringToIndex(index1)
        
        if graphs == "No Data" {
            winRateString = ""
        } else {
            winRateString = substring1
        }
        
        print(winRateString)
        var winRate:Int = -1
        if winRateString == "" {
            winRate = 0
        } else {
            winRate = Int(winRateString) as Int!
        }
        
        if winRate > 50 {
            UIColor.greenColor().setFill()
        } else {
            UIColor.redColor().setFill()
        }
        //UIColor.greenColor().setFill()
        path.fill()
    }
    
}
