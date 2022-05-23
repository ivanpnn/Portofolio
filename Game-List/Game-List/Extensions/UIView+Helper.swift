//
//  UIView+Helper.swift
//  Game-List
//
//  Created by MacBook Noob on 11/08/21.
//

import UIKit

extension UIView {
    public func height() -> CGFloat {
        return self.frame.size.height
    }
    
    public func width() -> CGFloat {
        return self.frame.size.width
    }
    
    public func top() -> CGFloat {
        return self.frame.origin.y
    }
    
    public func bottom() -> CGFloat {
        return self.frame.origin.y + self.frame.size.height
    }
    
    public func left() -> CGFloat {
        return self.frame.origin.x
    }
    
    public func right() -> CGFloat {
        return self.frame.origin.x + self.frame.size.width
    }
    
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}

extension UILabel {
    func labelFontSize() -> CGSize {
        let labelSize = self.text?.size(withAttributes: [.font: self.font!])
        return labelSize ?? CGSize(width: 0, height: 0)
    }
}
