//
//  TagsGraphsCollectionCell.swift
//  Deck Tracker
//
//  Created by Andrei Joghiu on 27/10/15.
//  Copyright © 2015 Andrei Joghiu. All rights reserved.
//

import UIKit

class TagsGraphsCollectionCell: UICollectionViewCell {
    
    
    @IBOutlet weak var tagLabel: UILabel!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var winInfoLabel: UILabel!
    
    let bgLayer = CAShapeLayer()
    var bgColor: UIColor = UIColor.redColor()
    
    let fgLayer = CAShapeLayer()
    var fgColor: UIColor = UIColor.greenColor()
    
    let π = CGFloat(M_PI)
    // This updates the graph every time it's changed
    var per : CGFloat = 0 {
        didSet {
            setup()
        }
    }
    
    private func setup() {
        
        layer.borderWidth = 2
        
        let width = self.bounds.width
        
        // Setup background layer
        bgLayer.strokeColor = UIColorFromRGB(0xC40233).CGColor
        bgLayer.lineWidth = width / 5.5
        bgLayer.fillColor = nil
        bgLayer.strokeEnd = 1
        layer.addSublayer(bgLayer)
        
        // Setup foreground layer
        fgLayer.strokeColor = UIColorFromRGB(0x009F6B).CGColor
        fgLayer.lineWidth = width / 5.7
        fgLayer.fillColor = nil
        fgLayer.strokeEnd = per/100
        layer.addSublayer(fgLayer)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupShapeLayer(bgLayer)
        setupShapeLayer(fgLayer)
    }
    
    private func setupShapeLayer(shapeLayer: CAShapeLayer) {
        shapeLayer.frame = self.bounds
        let startAngle = DegreesToRadians(90.0)
        let endAngle = DegreesToRadians(89.999999)
        let center = CGPoint(x: shapeLayer.frame.width / 2, y: shapeLayer.frame.height / 2)
        let radius = CGRectGetWidth(self.bounds) * 0.25
        let path = UIBezierPath(arcCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        shapeLayer.path = path.CGPath
    }
    
    func DegreesToRadians (value:CGFloat) -> CGFloat {
        return value * π / 180.0
    }
    
    func RadiansToDegrees (value:CGFloat) -> CGFloat {
        return value * 180.0 / π
    }
    
    func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        // Transforms RGB colors to UI Color
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
}
