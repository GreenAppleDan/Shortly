//
//  LoadableButton.swift
//  Shortly
//
//  Created by Denis on 13.03.2022.
//

import UIKit

class LoadableButton: UIButton {
    
    var loadingLayerBackgroundColor: UIColor { .lightBlue }
    var loadingLayerCircleColor: UIColor { .white }
    
    private weak var loadingLayer: CALayer?
    private weak var circle: CALayer?
    
    final var isLoading: Bool { loadingLayer != nil }
    
    final func showLoading() {
        isUserInteractionEnabled = false
        let layer = CAReplicatorLayer()
        layer.frame = bounds
        let circle = CALayer()
        let circleDiameter = min(bounds.height / 4, bounds.width / 8)
        circle.frame = CGRect(x: 0, y: 0, width: circleDiameter, height: circleDiameter)
        circle.cornerRadius = circle.frame.width / 2
        circle.backgroundColor = loadingLayerCircleColor.cgColor
        layer.backgroundColor = loadingLayerBackgroundColor.cgColor
        layer.addSublayer(circle)
        let xOffset = circleDiameter * 1.5
        circle.position = CGPoint(x: bounds.midX - xOffset, y: bounds.midY)
        layer.instanceCount = 3
        layer.instanceTransform = CATransform3DMakeTranslation(xOffset, 0, 0)
        layer.instanceDelay = 0.33
        let scaleAnimation = CAKeyframeAnimation(keyPath: "transform.scale")
        scaleAnimation.duration = 1.6
        scaleAnimation.repeatCount = .infinity
        scaleAnimation.values = [1, 0, 1]
        scaleAnimation.keyTimes = [0, 0.5, 1]
        circle.add(scaleAnimation, forKey: nil)
        
        loadingLayer = layer
        self.layer.addSublayer(layer)
    }
    
    final func hideLoading() {
        isUserInteractionEnabled = true
        loadingLayer?.removeFromSuperlayer()
    }
}
