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
    
    
    func drawRectangle(rect: CGRect, winRate:Int) {
        
        
        //let path = UIBezierPath(ovalInRect: rect)
        
//        if winRate > 50 {
//            UIColor.greenColor().setFill()
//        } else {
//            UIColor.redColor().setFill()
//        }
        //UIColor.yellowColor().setFill()
        //path.fill()
    }
    
    override func drawRect(rect: CGRect) {
        let path = UIBezierPath(ovalInRect: rect)
        UIColor.redColor().setFill()
        path.fill()
    }
    
}
