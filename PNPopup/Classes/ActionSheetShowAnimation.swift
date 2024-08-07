//
//  ActionSheetShowAnimation.swift
//  
//
//  Created by Misaka on 2024/1/15.
//

import Foundation
import UIKit

public class ActionSheetShowAnimation : NSObject, UIViewControllerAnimatedTransitioning {
    
    private var duration: TimeInterval = 0.5
    
    private var delay: TimeInterval = 0.0
    
    private var springWithDamping: CGFloat = 1.0
    
    private var springVelocity: CGFloat = 2.0
    
    private var isAnimation: Bool = true
    
    public init(isAnimation: Bool = true, duration: TimeInterval = 0.5) {
        super.init()
        self.isAnimation = isAnimation
        self.duration = duration
    }
    
    open func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    open func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
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
        
        if isAnimation {
            toView.transform = CGAffineTransformMakeTranslation(0.0, UIScreen.main.bounds.height)
            
            UIView.animate(withDuration: duration, delay: delay, usingSpringWithDamping: springWithDamping, initialSpringVelocity: springVelocity, options: .curveEaseInOut, animations: {
                
                toView.transform = .identity
                
            }, completion: { finished in
                transitionContext.completeTransition(finished)
            })
        } else {
            toView.transform = CGAffineTransformMakeTranslation(0, 0)
            
            UIView.animate(withDuration: duration, delay: 0, options: [], animations: {
                
                toView.transform = .identity
                
            }, completion: { finished in
                transitionContext.completeTransition(finished)
            })
        }
    }
}
