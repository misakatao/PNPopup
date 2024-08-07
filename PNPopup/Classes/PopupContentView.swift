//
//  PopupContentView.swift
//  
//
//  Created by Misaka on 2024/1/15.
//

import Foundation
import UIKit

open class PopupContentView : UIView {
    
    open var roundingCorners: UIRectCorner = [.topLeft, .topRight]
    
    open var cornerRadius: CGFloat = 16
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: roundingCorners, cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}
