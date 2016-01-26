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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configure()
        setup()
    }
    
    func setup() {
        
        layer.borderWidth = 1
        
        let width = bgLayer.bounds.width
        
        // Setup background layer
        bgLayer.lineWidth = width / 5.5
        bgLayer.fillColor = nil
        bgLayer.strokeEnd = 1
        layer.addSublayer(bgLayer)
        
        // Setup foreground layer
        fgLayer.lineWidth = width / 5.7
        fgLayer.fillColor = nil
        fgLayer.strokeEnd = 1
        layer.addSublayer(fgLayer)
    }
    
    func configure() {
        bgLayer.strokeColor = bgColor.CGColor
        fgLayer.strokeColor = fgColor.CGColor
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupBGShapeLayer(bgLayer)
        setupFGShapeLayer(fgLayer)
    }
    
    private func setupFGShapeLayer(shapeLayer: CAShapeLayer) {
        shapeLayer.frame = self.bounds
        let startAngle = DegreesToRadians(90.0)
        let calculatedEndAngle = getAngleFromWinRate()
        let endAngle = DegreesToRadians(calculatedEndAngle)
        let center = opponentClassImage.center
        let radius = CGRectGetWidth(self.bounds) * 0.25
        let path = UIBezierPath(arcCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        shapeLayer.path = path.CGPath
    }
    
    private func setupBGShapeLayer(shapeLayer: CAShapeLayer) {
        shapeLayer.frame = self.bounds
        let calculatedEndAngle = getAngleFromWinRate()
        var startAngle = DegreesToRadians(calculatedEndAngle) + 0.00001
        if winInfoLabel.text == "No Data" {
            startAngle = DegreesToRadians(calculatedEndAngle)
        }
        let endAngle = DegreesToRadians(90.0)
        let center = opponentClassImage.center
        let radius = CGRectGetWidth(self.bounds) * 0.25
        let path = UIBezierPath(arcCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        shapeLayer.path = path.CGPath
    }
    
    private func getAngleFromWinRate() -> CGFloat {
        let angle = (per * 3.6) + 90
        return angle
    }
    
    func DegreesToRadians (value:CGFloat) -> CGFloat {
        return value * π / 180.0
    }
    
    func RadiansToDegrees (value:CGFloat) -> CGFloat {
        return value * 180.0 / π
    }
    
    func animate() {
        
        var fromValue = fgLayer.strokeEnd
        var toValue = per/100
//        if let presentationLayer = fgLayer.presentationLayer() as? CAShapeLayer {
//            fromValue = presentationLayer.strokeEnd
//        }

        //print(String(fromValue) + " -> " + String(toValue))
        
        let percentChange = abs(fromValue - toValue)
        
        //print(percentChange)
        
        if toValue >= fromValue {
            // 1
            let animation = CABasicAnimation(keyPath: "strokeEnd")
            animation.fromValue = fromValue
            animation.toValue = toValue
            // 2
            animation.duration = CFTimeInterval(1000000)
            // 3
            fgLayer.removeAnimationForKey("stroke")
            fgLayer.addAnimation(animation, forKey: "stroke")
            
            CATransaction.begin()
            CATransaction.setDisableActions(true)
            fgLayer.strokeEnd = toValue
            CATransaction.commit()
        }
        

    }

}
