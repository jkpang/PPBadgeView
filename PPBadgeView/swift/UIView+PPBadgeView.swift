//
//  UIView+PPBadgeView.swift
//  PPBadgeViewSwift
//
//  Created by AndyPang on 2017/6/19.
//  Copyright © 2017年 AndyPang. All rights reserved.
//

import UIKit
import WebKit

private var kBadgeLabel = "kBadgeLabel"

// MARK: - add Badge
public extension UIView {
    
    
    public func pp_addBadgeWithText(text: String) {
        lazyLoadBadgeLabel()
        self.badgeLabel.text = text;
    }
    
    public func pp_addBadgeWithNumber(number: Int) {
        if number <= 0 {
            pp_addBadgeWithText(text: "0")
            pp_hiddenBadge()
            return
        }
        pp_addBadgeWithText(text: "\(number)")
    }
    
    public func pp_addDotWithColor(color: UIColor) {
        pp_addBadgeWithText(text: "")
        pp_setBadgeHeightPoints(points: 8.0)
        if !color.isEqual(nil) {
            self.badgeLabel.backgroundColor = color
        }
    }
    
    public func pp_setBadgeHeightPoints(points: CGFloat) {
        let scale = points/self.badgeLabel.p_height
        self.badgeLabel.transform = self.badgeLabel.transform.scaledBy(x: scale, y: scale);
    }
    
    public func pp_moveBadge(x: CGFloat, y: CGFloat) {
        lazyLoadBadgeLabel()
        /**
         self.badgeLabel.center = CGPointMake(self.p_width+x, y);
         
         如果通过badge的center来调整其在父视图的位置, 在给badge赋值不同长度的内容时
         会导致badge会以中心点向两边调整其自身宽度,如果badge过长会遮挡部分父视图, 所以
         正确的方式是以badge的x坐标为起点,其宽度向x轴正方向增加/x轴负方向减少
         */
        self.badgeLabel.p_x = (self.p_width - self.badgeLabel.p_height*0.5)/*badge的x坐标*/ + x;
        self.badgeLabel.p_y = -self.badgeLabel.p_height*0.5/*badge的y坐标*/ + y;
    }
//    public func pp_setBadgeLabelAttributes(()->(badgeLabel: )) {
//        <#function body#>
//    }
    
    public func pp_showBadge() {
        self.badgeLabel.isHidden = false
    }
    
    public func pp_hiddenBadge() {
        self.badgeLabel.isHidden = true
    }
    
    public func pp_increase() {
        pp_increaseBy(number: 1)
    }
    
    public func pp_increaseBy(number: Int) {
        let result = (NumberFormatter().number(from: self.badgeLabel.text!)?.intValue)! + number
        if result > 0 {
            pp_showBadge()
        }
        self.badgeLabel.text = "\(String(describing: result))"
        
    }
    
    public func pp_decrease() {
        pp_decreaseBy(number: 1)
    }
    
    public func pp_decreaseBy(number: Int) {
        let result = (NumberFormatter().number(from: self.badgeLabel.text!)?.intValue)! - number;
        if (result <= 0) {
            pp_hiddenBadge()
            self.badgeLabel.text = "0";
            return;
        }
        self.badgeLabel.text = "\(result)";
    }
    
    
    internal var badgeLabel: PPBadgeLabel {
        get {
            return objc_getAssociatedObject(self, &kBadgeLabel) as! PPBadgeLabel
        }
        set {
            objc_setAssociatedObject(self, &kBadgeLabel, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    private func lazyLoadBadgeLabel() {
        if self.badgeLabel.isEqual(nil) {
            self.badgeLabel = PPBadgeLabel.defaultBadgeLabel()
            self.badgeLabel.center = CGPoint(x: self.p_width, y: 0)
            self.addSubview(self.badgeLabel)
            self.bringSubview(toFront: self.badgeLabel)
        }
    }
    
}

// MARK: - getter/setter
public extension UIView {

    public var p_x: CGFloat {
        get {
            return frame.origin.x
        }
        set {
            frame.origin.x = newValue
        }
    }
    
    public var p_y: CGFloat {
        get {
            return frame.origin.y
        }
        set {
            frame.origin.y = newValue
        }
    }
    
    public var p_right: CGFloat {
        get {
            return frame.origin.x + frame.size.width
        }
        set {
            frame.origin.x = newValue - frame.size.width
        }
    }
    
    public var p_bottom: CGFloat {
        get {
            return frame.origin.y + frame.size.height
        }
        set {
            frame.origin.y = newValue - frame.size.height
        }
    }
    
    public var p_width: CGFloat {
        get {
            return frame.size.width
        }
        set {
            frame.size.width = newValue
        }
    }
    
    public var p_height: CGFloat {
        get {
            return frame.size.height
        }
        set {
            frame.size.height = newValue
        }
    }
    
    public var p_centerX: CGFloat {
        get {
            return center.x
        }
        set {
            center.x = newValue
        }
    }
    
    public var p_centerY: CGFloat {
        get {
            return center.y
        }
        set {
            center.y = newValue
        }
    }
}
