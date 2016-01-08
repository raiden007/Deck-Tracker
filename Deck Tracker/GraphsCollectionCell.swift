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
    @IBOutlet weak var winInfoLabel: UILabel!
    @IBOutlet weak var classImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //setup("setup from cell")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func setup(information: String) {
        print(information)
    }
    
    func drawRectangle(rect: CGRect, winRate:Int) {
    
        print(winRate)
        let path = UIBezierPath(ovalInRect: rect)

        if winRate > 50 {
            UIColor.greenColor().setFill()
        } else {
            UIColor.redColor().setFill()
        }
        UIColor.yellowColor().setFill()
        path.fill()
    }

}
