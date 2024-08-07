//
//  ActionAlertShowAnimation.swift
//  
//
//  Created by Misaka on 2024/1/15.
//

import Foundation
import UIKit

public class ActionAlertShowAnimation : NSObject, UIViewControllerAnimatedTransitioning {
 
    private var duration: TimeInterval = 0.4
    
    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let toVC = transitionContext.viewController(forKey: .to) else {
            transitionContext.completeTransition(false)
            return
        }
        
        guard let toView = transitionContext.view(forKey: .to) else {
            transitionContext.completeTransition(false)
            return
        }
        
        toView.frame = transitionContext.finalFrame(for: toVC)
        transitionContext.containerView.addSubview(toView)
        
        let popAnimation = CAKeyframeAnimation(keyPath: "transform")
        popAnimation.duration = duration
        popAnimation.values = [
            NSValue(caTransform3D: CATransform3DMakeScale(0.01, 0.01, 1.0)),
            NSValue(caTransform3D: CATransform3DMakeScale(1.1, 1.1, 1.0)),
            NSValue(caTransform3D: CATransform3DMakeScale(0.9, 0.9, 1.0)),
            NSValue(caTransform3D: CATransform3DIdentity)
        ]
        popAnimation.keyTimes = [0.0, 0.5, 0.75, 1.0]
        popAnimation.timingFunctions = [
            CAMediaTimingFunction(name: .easeInEaseOut),
            CAMediaTimingFunction(name: .easeInEaseOut),
            CAMediaTimingFunction(name: .easeInEaseOut)
        ]
        toView.layer.add(popAnimation, forKey: nil)
        
        transitionContext.completeTransition(true)
    }
}
