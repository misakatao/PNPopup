//
//  PopupNavigationController.swift
//
//
//  Created by Misaka on 2024/1/15.
//

import Foundation
import UIKit

public class PopupNavigationController : UINavigationController {
    
    var rootViewController = PopupViewController()
    
    public override init(rootViewController: UIViewController) {
        
        super.init(rootViewController: rootViewController)
        
        self.rootViewController = rootViewController as! PopupViewController
        modalPresentationStyle = .custom
        transitioningDelegate = self
    }
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        //navigationBar.setBackgroundImage(UIImage(), for: .default)
        //navigationBar.shadowImage = UIImage()
        //navigationBar.isTranslucent = true
        //view.backgroundColor = UIColor.clear
    }
}

extension PopupNavigationController : UIViewControllerTransitioningDelegate {
    
    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return rootViewController.showAnimation
    }
    
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return rootViewController.dismissAnimation
    }
    
    public func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        
        let presentationC = PopupPresentationController(presentedViewController: presented, presenting: presenting)
        presentationC.backgroundView = rootViewController.backgroundView
        return presentationC
    }
}
