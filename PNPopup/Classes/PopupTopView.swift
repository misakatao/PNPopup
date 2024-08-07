//
//  PopupTopView.swift
//  
//
//  Created by Misaka on 2024/1/15.
//

import Foundation
import UIKit

open class PopupTopView : UIView {
    
    open override class var layerClass: AnyClass {
        get {
            return CAShapeLayer.self
        }
    }
    
    open override var backgroundColor: UIColor? {
        didSet {
            if let shapeLayer = self.layer as? CAShapeLayer {
                shapeLayer.fillColor = backgroundColor?.cgColor
            }
        }
    }
}
