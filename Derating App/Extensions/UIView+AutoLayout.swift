//
//  UIView+AutoLayout.swift
//  GiraProdutor
//
//  Created by GIRA on 28/04/21.
//

import UIKit

extension UIView {
    
    /// Add anchors from any side of the current view into the specified anchors and returns the newly added constraints.
    ///
    /// - Parameters:
    ///   - top: current view's top anchor will be anchored into the specified anchor
    ///   - left: current view's left anchor will be anchored into the specified anchor
    ///   - bottom: current view's bottom anchor will be anchored into the specified anchor
    ///   - right: current view's right anchor will be anchored into the specified anchor
    ///   - topConstant: current view's top anchor margin
    ///   - leftConstant: current view's left anchor margin
    ///   - bottomConstant: current view's bottom anchor margin
    ///   - rightConstant: current view's right anchor margin
    ///   - widthConstant: current view's width
    ///   - heightConstant: current view's height
    /// - Returns: array of newly added constraints (if applicable).
    @available(iOS 9, *)
    @discardableResult
    public func anchor(
        top: NSLayoutYAxisAnchor? = nil,
        left: NSLayoutXAxisAnchor? = nil,
        bottom: NSLayoutYAxisAnchor? = nil,
        right: NSLayoutXAxisAnchor? = nil,
        centerX: NSLayoutXAxisAnchor? = nil,
        centerY: NSLayoutYAxisAnchor? = nil,
        topConstant: CGFloat = 0,
        leftConstant: CGFloat = 0,
        bottomConstant: CGFloat = 0,
        rightConstant: CGFloat = 0,
        widthConstant: CGFloat = 0,
        heightConstant: CGFloat = 0
    ) -> [NSLayoutConstraint] {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        var anchors = [NSLayoutConstraint]()
        
        if let top = top {
            anchors.append(topAnchor.constraint(equalTo: top, constant: topConstant))
        }
        
        if let left = left {
            anchors.append(leftAnchor.constraint(equalTo: left, constant: leftConstant))
        }
        
        if let bottom = bottom {
            anchors.append(bottomAnchor.constraint(equalTo: bottom, constant: -bottomConstant))
        }
        
        if let right = right {
            anchors.append(rightAnchor.constraint(equalTo: right, constant: -rightConstant))
        }
        
        if let centerY = centerY {
            anchors.append(centerYAnchor.constraint(equalTo: centerY, constant: 0))
        }
        
        if let centerX = centerX {
            anchors.append(centerXAnchor.constraint(equalTo: centerX, constant: 0))
        }
        
        if widthConstant > 0 {
            anchors.append(widthAnchor.constraint(equalToConstant: widthConstant))
        }
        
        if heightConstant > 0 {
            anchors.append(heightAnchor.constraint(equalToConstant: heightConstant))
        }
        
        NSLayoutConstraint.activate(anchors)
        
        return anchors
    }

    public func anchorTo(superview: UIView) {
        anchor(
            top: superview.topAnchor,
            left: superview.leftAnchor,
            bottom: superview.bottomAnchor,
            right: superview.rightAnchor
        )
    }
    
    public func anchorWidth(with constant: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        if constant > 0 {
            widthAnchor.constraint(equalToConstant: constant).isActive = true
        }
    }
    
    public func anchorHeight(with constant: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        if constant > 0 {
            heightAnchor.constraint(equalToConstant: constant).isActive = true
        }
    }
    
    public func anchorWidth() {
        translatesAutoresizingMaskIntoConstraints = false
        if let width = superview?.widthAnchor {
            widthAnchor.constraint(equalTo: width, multiplier: 1).isActive = true
        }
    }
    
    public func anchorHeight() {
        translatesAutoresizingMaskIntoConstraints = false
        if let height = superview?.heightAnchor {
            heightAnchor.constraint(equalTo: height, multiplier: 1).isActive = true
        }
    }
    
    public func anchorWidthHeight() {
        anchorWidth()
        anchorHeight()
    }
    
    public func anchorWidthHeight(with constant: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        if constant > 0 {
            widthAnchor.constraint(equalToConstant: constant).isActive = true
            heightAnchor.constraint(equalToConstant: constant).isActive = true
        }
    }
    
    /// Anchor center X into current view's superview with a constant margin value.
    ///
    /// - Parameter constant: constant of the anchor constraint (default is 0).
    @available(iOS 9, *)
    public func anchorCenterXToSuperview(constant: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        if let anchor = superview?.centerXAnchor {
            centerXAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
        }
    }
    
    /// Anchor center Y into current view's superview with a constant margin value.
    ///
    /// - Parameter withConstant: constant of the anchor constraint (default is 0).
    @available(iOS 9, *)
    public func anchorCenterYToSuperview(constant: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        if let anchor = superview?.centerYAnchor {
            centerYAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
        }
    }
    
    /// Anchor center X and Y into current view's superview
    @available(iOS 9, *)
    public func anchorCenterSuperview() {
        anchorCenterXToSuperview()
        anchorCenterYToSuperview()
    }
}
