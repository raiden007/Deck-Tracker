//
//  GraphsCollectionCell.swift
//  Deck Tracker
//
//  Created by Andrei Joghiu on 22/10/15.
//  Copyright © 2015 Andrei Joghiu. All rights reserved.
//

import UIKit

class GraphsCollectionCell: UICollectionViewCell, ARPieChartDataSource, ARPieChartDelegate {
    
    @IBOutlet weak var versusLabel: UILabel!
    @IBOutlet weak var winInfoLabel: UILabel!
    @IBOutlet weak var opponentClassImage: UIImageView!
    @IBOutlet weak var pieChart: ARPieChart!
    
    let bgLayer = CAShapeLayer()
    var bgColor: UIColor = UIColor.redColor()
    
    let fgLayer = CAShapeLayer()
    var fgColor: UIColor = UIColor.greenColor()
    
    let π = CGFloat(M_PI)
    var per : CGFloat = 0 {
        didSet {
            setup()
        }
    }
    
    var outerRadius: CGFloat = 5.0
    
    var innerRadius: CGFloat = 2.0
    
    var selectedPieOffset: CGFloat = 1.0
    
    var labelFont: UIFont = UIFont.systemFontOfSize(10)
    
    var showDescriptionText: Bool = false
    
    var animationDuration: Double = 1.0

    
    
    private func setup() {
        
//        layer.borderWidth = 2
//        
//        if per != -1 {
            // Setup background layer
            bgLayer.strokeColor = bgColor.CGColor
            bgLayer.lineWidth = 20.0
            bgLayer.fillColor = nil
            bgLayer.strokeEnd = 1
            layer.addSublayer(bgLayer)
            
            // Setup foreground layer
            fgLayer.strokeColor = fgColor.CGColor
            fgLayer.lineWidth = 20.0
            fgLayer.fillColor = nil
            fgLayer.strokeEnd = per/100
            layer.addSublayer(fgLayer)
//        }

        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupShapeLayer(bgLayer)
        setupShapeLayer(fgLayer)
    }
    
    private func setupShapeLayer(shapeLayer: CAShapeLayer) {
        shapeLayer.frame = self.bounds
        let startAngle = DegreesToRadians(135.0)
        let endAngle = DegreesToRadians(45.0)
        let center = opponentClassImage.center
        let radius = CGRectGetWidth(self.bounds) * 0.35
        let path = UIBezierPath(arcCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        shapeLayer.path = path.CGPath
    }
    
    func DegreesToRadians (value:CGFloat) -> CGFloat {
        return value * π / 180.0
    }
    
    func RadiansToDegrees (value:CGFloat) -> CGFloat {
        return value * 180.0 / π
    }
    
    
    func numberOfSlicesInPieChart(pieChart: ARPieChart) -> Int {
        return 2
    }
    
    func pieChart(pieChart: ARPieChart, valueForSliceAtIndex index: Int) -> CGFloat {
        return 5.0
    }
    
    func pieChart(pieChart: ARPieChart, colorForSliceAtIndex index: Int) -> UIColor {
        return UIColor.redColor()
    }
    
    func pieChart(pieChart: ARPieChart, descriptionForSliceAtIndex index: Int) -> String {
        return "a"
    }
    
    func pieChart(pieChart: ARPieChart, itemSelectedAtIndex index: Int) {
        
    }
    
    func pieChart(pieChart: ARPieChart, itemDeselectedAtIndex index: Int) {
        
    }

}
