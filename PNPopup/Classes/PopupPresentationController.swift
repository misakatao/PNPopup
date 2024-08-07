//
//  PopupPresentationController.swift
//
//
//  Created by Misaka on 2024/1/15.
//

import Foundation
import UIKit

class PopupPresentationController : UIPresentationController {
    
    public var backgroundView: UIView?
    
    override func presentationTransitionWillBegin() {
        
        if let containerView = self.containerView, let backgroundView = self.backgroundView {
            containerView.insertSubview(backgroundView, at: 0)
            backgroundView.frame = containerView.bounds
        }
        
        excuteBackgroundAnimation()
    }
    
    override func dismissalTransitionWillBegin() {
        excuteBackgroundDismissAnimation()
    }
    
    override var shouldRemovePresentersView: Bool {
        return false
    }
    
    // MARK: - Custom
    private func excuteBackgroundAnimation() {
        backgroundView?.alpha = 0
        self.presentedViewController.transitionCoordinator?.animate(alongsideTransition: { [weak self] (_) in
            self?.backgroundView?.alpha = 1
        }, completion: { _ in
            
        })
    }
    
    private func excuteBackgroundDismissAnimation() {
        self.presentedViewController.transitionCoordinator?.animate(alongsideTransition: { [weak self] (_) in
            self?.backgroundView?.alpha = 0
        }, completion: { _ in
            
        })
    }
}
