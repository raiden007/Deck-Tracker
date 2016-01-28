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
            dispatch_async(dispatch_get_main_queue()) { () -> Void in
                self.setup()
                self.setNeedsLayout()
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configure()
    }
    
    func setup() {
        
        layer.borderWidth = 1
        let width = bgLayer.bounds.width
        //print(width)
        
        var lineWidth = width / 5.5
        // For iPhone 4S
        if width == 139.0 {
            lineWidth = 25
        }
        
        // Setup background layer
        bgLayer.lineWidth = lineWidth
        bgLayer.fillColor = nil
        bgLayer.strokeEnd = 1
        layer.addSublayer(bgLayer)
        
        // Setup foreground layer
        fgLayer.lineWidth = lineWidth
        fgLayer.fillColor = nil
        fgLayer.strokeEnd = 1
        layer.addSublayer(fgLayer)
        
    }
    
    func configure() {
        bgLayer.strokeColor = UIColorFromRGB(0xC40233).CGColor
        fgLayer.strokeColor = UIColorFromRGB(0x009F6B).CGColor
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupBGShapeLayer(bgLayer)
        setupFGShapeLayer(fgLayer)
    }

    
    private func setupFGShapeLayer(shapeLayer: CAShapeLayer) {
        
        let width = bgLayer.bounds.width
        print(width)
        var radiusFactor: CGFloat = 0.25
        // For iPhone 4S
        if width == 139.0 {
            radiusFactor = 0.23
        }
        
        
        shapeLayer.frame = self.bounds
        let startAngle = DegreesToRadians(90.0)
        let calculatedEndAngle = getAngleFromWinRate()
        let endAngle = DegreesToRadians(calculatedEndAngle)
        let center = opponentClassImage.center
        let radius = CGRectGetWidth(self.bounds) * radiusFactor
        let path = UIBezierPath(arcCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        shapeLayer.path = path.CGPath
    }
    
    private func setupBGShapeLayer(shapeLayer: CAShapeLayer) {
        
        let width = bgLayer.bounds.width
        print(width)
        var radiusFactor: CGFloat = 0.25
        // For iPhone 4S
        if width == 139.0 {
            radiusFactor = 0.23
        }
        
        shapeLayer.frame = self.bounds
        let calculatedEndAngle = getAngleFromWinRate()
        var startAngle = DegreesToRadians(calculatedEndAngle) + 0.00001
        if winInfoLabel.text == "No Data" {
            startAngle = DegreesToRadians(calculatedEndAngle)
        }
        let endAngle = DegreesToRadians(90.0)
        let center = opponentClassImage.center
        let radius = CGRectGetWidth(self.bounds) * radiusFactor
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
        
        let fromValue = fgLayer.strokeEnd
        let toValue = per/100
        
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
