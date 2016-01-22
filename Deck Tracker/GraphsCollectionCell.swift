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
    @IBOutlet weak var opponentClassImage: UIImageView!
    
    let bgLayer = CAShapeLayer()
    var bgColor: UIColor = UIColor.redColor()
    
    let fgLayer = CAShapeLayer()
    var fgColor: UIColor = UIColor.greenColor()
    
    let π = CGFloat(M_PI)
    var per : CGFloat = 0 {
        didSet {
            setup()
            animate()
        }
    }

    private func setup() {
        
        layer.borderWidth = 2
        
        let width = bgLayer.bounds.width
        
        // Setup background layer
        bgLayer.strokeColor = bgColor.CGColor
        bgLayer.lineWidth = width / 5.5
        bgLayer.fillColor = nil
        bgLayer.strokeEnd = 1
        layer.addSublayer(bgLayer)
        
        // Setup foreground layer
        fgLayer.strokeColor = fgColor.CGColor
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
        let center = opponentClassImage.center
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
    
    private func animate() {
        var fromValue = fgLayer.strokeEnd
        let toValue = per/100
        let percentChange = abs(fromValue - toValue)
        
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = fromValue
        animation.toValue = toValue
        
        //animation.duration = CFTimeInterval(percentChange * 4000)
        animation.duration = CFTimeInterval(1)

        
        fgLayer.removeAnimationForKey("stroke")
        fgLayer.addAnimation(animation, forKey: "stroke")
    }

}
