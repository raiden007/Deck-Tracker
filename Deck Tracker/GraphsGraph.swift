//
//  GraphsGraph.swift
//  Deck Tracker
//
//  Created by Andrei Joghiu on 07/01/16.
//  Copyright © 2016 Andrei Joghiu. All rights reserved.
//

import UIKit

class GraphsGraph: UIImageView {

    override func drawRect(rect: CGRect) {
        let path = UIBezierPath(ovalInRect: rect)
        UIColor.greenColor().setFill()
        path.fill()
    }

}
