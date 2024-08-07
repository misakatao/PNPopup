//
//  ActionSheetDismissAnimation.swift
//  
//
//  Created by Misaka on 2024/1/15.
//

import Foundation
import UIKit

public class ActionSheetDismissAnimation : NSObject, UIViewControllerAnimatedTransitioning {
    
    private var duration: TimeInterval = 0.5
    private var delay: TimeInterval = 0.0
    private var isAnimation: Bool = true
    
    public init(isAnimation: Bool = true, duration: TimeInterval = 0.4) {
        super.init()
        self.isAnimation = isAnimation
        self.duration = duration
    }
    
    open func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    open func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromView = transitionContext.view(forKey: .from) else {
            transitionContext.completeTransition(false)
            return
        }
        
        if isAnimation {
            UIView.animate(withDuration: duration, delay: delay, options: .curveEaseOut, animations: {
                
                fromView.transform = CGAffineTransformMakeTranslation(0.0, UIScreen.main.bounds.height)
                fromView.alpha = 0.0
                
            }, completion: { finished in

                fromView.transform = .identity
                fromView.alpha = 1.0
                transitionContext.completeTransition(finished)
            })
        } else {
            transitionContext.completeTransition(true)
        }
    }
}
