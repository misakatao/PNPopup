//
//  PopupViewController.swift
//
//
//  Created by Misaka on 2024/1/15.
//

import Foundation
import UIKit

open class PopupViewController : UIViewController {
    
    public typealias YJPopupBlock = (_ popupVC: PopupViewController?) -> Void
    
    public var touchAutoDismiss: Bool = false
    
    public var useNavigationController: Bool = true
    
    public var willPresentBlock: YJPopupBlock?
    public func willPresentBlock(block: @escaping YJPopupBlock) {
        self.willPresentBlock = block
    }
    
    public var didPresentBlock: YJPopupBlock?
    public func didPresentBlock(block: @escaping YJPopupBlock) {
        self.didPresentBlock = block
    }
    
    public var willDismissBlock: YJPopupBlock?
    public func willDismissBlock(block: @escaping YJPopupBlock) {
        self.willDismissBlock = block
    }
    
    public var didDismissBlock: YJPopupBlock?
    public func didDismissBlock(block: @escaping YJPopupBlock) {
        self.didDismissBlock = block
    }
    
    public var touchBlock: YJPopupBlock?
    public func touchBlock(block: @escaping YJPopupBlock) {
        self.touchBlock = block
    }
    
    private(set) var showAnimation: UIViewControllerAnimatedTransitioning? = ActionSheetShowAnimation()
    
    private(set) var dismissAnimation: UIViewControllerAnimatedTransitioning? = ActionSheetDismissAnimation()
    
    public var isSelfDisappear: Bool = false
    
    lazy public var backgroundView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = UIColor.black.withAlphaComponent(0.55)
        return view
    }()
    
    // 子类继承时，视图均放在该 view 上
    lazy open var contentView: PopupContentView = {
        return PopupContentView(frame: .zero)
    }()
    
    deinit {
        PopupViewController.debugPrint(self.classForCoder)
    }
    
    private static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSSZ"
        return dateFormatter
    }()
    
    public static func debugPrint(_ items: Any...,
                                  separator: String = " ",
                                  terminator: String = "\n",
                                  file: String = #file,
                                  funcName: String = #function,
                                  line: Int = #line,
                                  column: Int = #column) {
#if DEBUG
        let fileName = (file as NSString).lastPathComponent
        let time = dateFormatter.string(from: Date())
        print("\(time) \(fileName)[\(line)] \(funcName):", terminator: separator)
        let j = items.count - 1
        for (i, item) in items.enumerated() {
            print(item, terminator: i == j ? terminator : separator)
        }
#endif
    }
    
    public init(useNavigationController: Bool = false) {
        self.useNavigationController = useNavigationController
        super.init(nibName: nil, bundle: nil)
        
        modalPresentationStyle = .custom
        if !useNavigationController {
            transitioningDelegate = self
        }
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(contentView)
    }
    
    private var isNavigationBarHidden: Bool = true
    
    open override func viewWillAppear(_ animated: Bool) {
        isNavigationBarHidden = navigationController?.navigationBar.isHidden ?? true
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    open override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if !isSelfDisappear { navigationController?.setNavigationBarHidden(isNavigationBarHidden, animated: animated) }
    }
    
    open func setShowAnimation(_ transitioning: UIViewControllerAnimatedTransitioning?) {
        showAnimation = transitioning
    }
    
    open func setDismissAnimation(_ transitioning: UIViewControllerAnimatedTransitioning?) {
        dismissAnimation = transitioning
    }
    
    open func presentPopupViewController(_ viewControllerToPresent: UIViewController, completion: (() -> Void)? = nil) {
        
        var presentVC: UIViewController = viewControllerToPresent
        if let tmp = presentVC.presentedViewController {
            if tmp.isKind(of: PopupViewController.self) {
                backgroundView.backgroundColor = UIColor.clear
            }
            presentVC = tmp
        }
        
        willPresentBlock?(self)
        
        if useNavigationController {
            presentVC.present(PopupNavigationController(rootViewController: self), animated: true)
        } else {
            presentVC.present(self, animated: true)
        }
        
        didPresentBlock?(self)
    }
    
    open func dismissPopupViewController(animated flag: Bool, completion: (() -> Void)? = nil) {
        
        willDismissBlock?(self)
        
        isSelfDisappear = true
        if let nav = navigationController {
            nav.dismiss(animated: flag, completion: completion)
        } else {
            dismiss(animated: flag, completion: completion)
        }
        
        didDismissBlock?(self)
    }
    
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        if !isViewLoaded && view.window == nil {
            return
        }
        
        if !touchAutoDismiss {
            return
        }
        
        if let touch = touches.first {
            if !contentView.frame.contains(touch.location(in: view)) {
                self.dismissPopupViewController(animated: true) { [weak self] in
                    if let touchBlock = self?.touchBlock {
                        touchBlock(self)
                    }
                }
            }
        }
    }
}

extension PopupViewController : UIViewControllerTransitioningDelegate {
    
    open func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return showAnimation
    }
    
    open func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return dismissAnimation
    }
    
    open func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        
        let presentationC = PopupPresentationController(presentedViewController: presented, presenting: presenting)
        presentationC.backgroundView = self.backgroundView
        return presentationC
    }
}
