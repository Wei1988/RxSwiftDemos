//
//  LayoutConstraint+Convenience.swift
//  RxSwiftDemos
//
//  Created by Wei Zhang on 1/17/17.
//  Copyright © 2017 Wei Zhang. All rights reserved.
//
//  Add convenience methods to add layout constraints programmatically
//  Use "static" to declare type method, use "class" if you want to allow subclass to override this type method

import Foundation
import UIKit

extension NSLayoutConstraint {
    // pin four edges
    static func pinAllEdges(_ subView: UIView, superView: UIView, shouldPinLeft: Bool, leftMargin: CGFloat, shouldPinRight: Bool, rightMargin: CGFloat, shouldPinTop: Bool, topMargin: CGFloat, shouldPinBottom: Bool, bottomMargin: CGFloat) {
        if shouldPinLeft == true {
           pinLeft(subView, superView: superView, leftMargin: leftMargin)
        }
        if shouldPinRight == true {
            pinRight(subView, superView: superView, rightMargin: rightMargin)
        }
        if shouldPinTop == true {
            pinTop(subView, superView: superView, topMargin: topMargin)
        }
        if shouldPinBottom == true {
            pinBottom(subView, superView: superView, bottomMargin: bottomMargin)
        }
    }
    
    // pin left
    static func pinLeft(_ subView: UIView, superView: UIView, leftMargin: CGFloat) {
        NSLayoutConstraint(item: subView, attribute: NSLayoutAttribute.left, relatedBy: NSLayoutRelation.equal, toItem: superView, attribute: .left, multiplier: 1, constant: leftMargin).isActive = true
    }
    
    // pin right
    static func pinRight(_ subView: UIView, superView: UIView, rightMargin: CGFloat) {
        NSLayoutConstraint.init(item: subView, attribute: .right, relatedBy: .equal, toItem: superView, attribute: .right, multiplier: 1.0, constant: -rightMargin).isActive = true
    }
    
    // pin top
    static func pinTop(_ subView: UIView, superView: UIView, topMargin: CGFloat) {
        NSLayoutConstraint.init(item: subView, attribute: .top, relatedBy: .equal, toItem: superView, attribute: .top, multiplier: 1.0, constant: topMargin).isActive = true
    }
    
    // pin bottom
    static func pinBottom(_ subView: UIView, superView: UIView, bottomMargin: CGFloat) {
        NSLayoutConstraint.init(item: subView, attribute: .bottom, relatedBy: .equal, toItem: superView, attribute: .bottom, multiplier: 1.0, constant: -bottomMargin).isActive = true
    }
    
    // pin center
    static func pinCenter(_ subView: UIView, superView: UIView) {
        pinCenterX(subView, superView: superView)
        pinCenterY(subView, superView: superView)
    }
    
    
    // pin centerX
    static func pinCenterX(_ subView: UIView, superView: UIView) {
        NSLayoutConstraint.init(item: subView, attribute: .centerX, relatedBy: .equal, toItem: superView, attribute: .centerX, multiplier: 1.0, constant: 0).isActive = true
    }
    // pin centerY
    static func pinCenterY(_ subView: UIView, superView: UIView) {
        NSLayoutConstraint.init(item: subView, attribute: .centerY, relatedBy: .equal, toItem: superView, attribute: .centerY, multiplier: 1.0, constant: 0).isActive = true
    }
    
    // pin height
    static func pinHeight(_ subView: UIView, height: CGFloat) {
        NSLayoutConstraint.init(item: subView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: height).isActive = true
    }
    
    // pin width
    static func pinWidth(_ subView: UIView, width: CGFloat) {
        NSLayoutConstraint.init(item: subView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: width).isActive = true
    }
    
}
