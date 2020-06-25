//
//  CustomUIView.swift
//  IzibookTestAnimation
//
//  Created by Eugene Kireichev on 25/06/2020.
//  Copyright © 2020 Eugene Kireichev. All rights reserved.
//

import UIKit

class CustomUIView: UIView {
    
    private let colors: [CGColor] = [
        CGColor(srgbRed: 37/255, green: 204/255, blue: 195/255, alpha: 1.0),
        CGColor(srgbRed: 247/255, green: 206/255, blue: 35/255, alpha: 1.0),
        CGColor(srgbRed: 143/255, green: 39/255, blue: 204/255, alpha: 1.0),
        CGColor(srgbRed: 31/255, green: 170/255, blue: 193/255, alpha: 1.0),
        CGColor(srgbRed: 7/255, green: 135/255, blue: 220/255, alpha: 1.0)
    ]
    
    private var shapeLayers = [CAShapeLayer]()
    
    @IBOutlet weak var iziImageView: UIImageView!
    
    func beginAnimations() {
        prepareShapeLayers()
        for index in 0..<shapeLayers.count {
            let delayTiming = 0.1 + Double(index)/10
            beginAnimation(duration: 2, delay: delayTiming, fromValue: 0.0, toValue: 1.0, for: shapeLayers[index])
        }
    }
    
    private func prepareShapeLayers() {
        colors.forEach { shapeLayers.append(createShapeLayer(for: $0)) }
        shapeLayers.forEach { layer.addSublayer($0) }
    }
    
    private func createShapeLayer(for color: CGColor) -> CAShapeLayer {
        let shapeLayer = CAShapeLayer()
        shapeLayer.lineWidth = 10
        shapeLayer.lineCap = CAShapeLayerLineCap(rawValue: "round")
        shapeLayer.fillColor = nil
        shapeLayer.strokeStart = 0
        shapeLayer.strokeEnd = 0
        shapeLayer.strokeColor = color
        let circlepPath = UIBezierPath(arcCenter: iziImageView.center, radius: iziImageView.bounds.width / 2, startAngle: CGFloat(0), endAngle: CGFloat(Double.pi * 2), clockwise: true)
        shapeLayer.path = circlepPath.cgPath
        return shapeLayer
    }
    
    private func beginAnimation(duration: Double, delay: Double, fromValue: CGFloat, toValue: CGFloat, for shapeLayer: CAShapeLayer) {
        let strokeEndAnimation = CABasicAnimation(keyPath: "strokeEnd")
        strokeEndAnimation.fromValue = fromValue
        strokeEndAnimation.toValue = toValue
        strokeEndAnimation.repeatCount = 1
        strokeEndAnimation.duration = duration/2
        strokeEndAnimation.beginTime = 0
        strokeEndAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        strokeEndAnimation.fillMode = CAMediaTimingFillMode.forwards
        strokeEndAnimation.isRemovedOnCompletion = false
        
        let strokeEndAnimTime = strokeEndAnimation.beginTime + strokeEndAnimation.duration
        
        let strokeStartAnimation = CABasicAnimation(keyPath: "strokeStart")
        strokeStartAnimation.fromValue = fromValue
        strokeStartAnimation.toValue = toValue
        strokeStartAnimation.repeatCount = 1
        strokeStartAnimation.duration = duration/2 - duration/4
        strokeStartAnimation.beginTime = strokeEndAnimTime + duration/4
        strokeStartAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        strokeStartAnimation.fillMode = CAMediaTimingFillMode.forwards
        strokeStartAnimation.isRemovedOnCompletion = false
        
        let pathAnimation = CAAnimationGroup()
        pathAnimation.animations = [strokeEndAnimation, strokeStartAnimation]
        pathAnimation.fillMode = CAMediaTimingFillMode.forwards
        pathAnimation.repeatCount = .greatestFiniteMagnitude
        pathAnimation.duration = duration
        pathAnimation.beginTime = CACurrentMediaTime() + delay
        pathAnimation.isRemovedOnCompletion = false
        
        shapeLayer.add(pathAnimation, forKey: nil)
    }

}
