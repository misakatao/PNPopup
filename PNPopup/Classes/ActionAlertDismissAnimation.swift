//
//  ActionAlertDismissAnimation.swift
//  
//
//  Created by Misaka on 2024/1/15.
//

import Foundation
import UIKit

public class ActionAlertDismissAnimation : NSObject, UIViewControllerAnimatedTransitioning {
    
    private var duration: TimeInterval = 0.2
    private var delay: TimeInterval = 0.0
    
    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        guard let fromView = transitionContext.view(forKey: .from) else {
            transitionContext.completeTransition(false)
            return
        }
        
        UIView.animate(withDuration: duration, delay: delay, options: .curveEaseOut, animations: {
            
            fromView.alpha = 0.0
            
        }, completion: { finished in
            
            fromView.alpha = 1.0
            transitionContext.completeTransition(finished)
        })
    }
}
