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
    
    /// 添加带文本内容的Badge, 默认右上角, 红色, 18pts
    ///
    /// - Parameter text: 文本字符串
    public func pp_addBadge(text: String) {
        self.badgeLabel.text = text;
    }
    
    /// 添加带数字的Badge, 默认右上角,红色,18pts
    ///
    /// - Parameter number: 整形数字
    public func pp_addBadge(number: Int) {
        if number <= 0 {
            pp_addBadge(text: "0")
            pp_hiddenBadge()
            return
        }
        pp_addBadge(text: "\(number)")
    }
    
    /// 添加带颜色的小圆点, 默认右上角, 红色, 8pts
    ///
    /// - Parameter color: 颜色
    public func pp_addDot(color: UIColor?) {
        pp_addBadge(text: "")
        pp_setBadgeHeight(points: 8.0)
        if let color = color  {
            self.badgeLabel.backgroundColor = color
        }
    }
    
    /// 设置Badge的偏移量, Badge中心点默认为其父视图的右上角
    ///
    /// - Parameters:
    ///   - x: X轴偏移量 (x<0: 左移, x>0: 右移)
    ///   - y: Y轴偏移量 (y<0: 上移, y>0: 下移)
    public func pp_moveBadge(x: CGFloat, y: CGFloat) {
        /**
         self.badgeLabel.center = CGPointMake(self.p_width+x, y);
         
         如果通过badge的center来调整其在父视图的位置, 在给badge赋值不同长度的内容时
         会导致badge会以中心点向两边调整其自身宽度,如果badge过长会遮挡部分父视图, 所以
         正确的方式是以badge的x坐标为起点,其宽度向x轴正方向增加/x轴负方向减少
         */
        self.badgeLabel.p_x = (self.p_width - self.badgeLabel.p_height*0.5)/*badge的x坐标*/ + x;
        self.badgeLabel.p_y = -self.badgeLabel.p_height*0.5/*badge的y坐标*/ + y;
    }
    
    /// 设置Badge的高度,因为Badge宽度是动态可变的,通过改变Badge高度,其宽度也按比例变化,方便布局
    /// (注意: 此方法需要将Badge添加到控件上后再调用!!!)
    ///
    /// - Parameter points: 高度大小
    public func pp_setBadgeHeight(points: CGFloat) {
        let scale = points/self.badgeLabel.p_height        
        self.badgeLabel.transform = self.badgeLabel.transform.scaledBy(x: scale, y: scale);
    }
    
    /// 设置Bage的属性
    ///
    /// - Parameter attributes: 将badgeLabel对象回调出来的闭包
    public func pp_setBadgeLabel(attributes: (PPBadgeLabel)->()) {
        attributes(self.badgeLabel)
    }
    
    /// 显示Badge
    public func pp_showBadge() {
        self.badgeLabel.isHidden = false
    }
    
    /// 隐藏Badge
    public func pp_hiddenBadge() {
        self.badgeLabel.isHidden = true
    }
    
    // MARK: - 数字增加/减少, 注意:以下方法只适用于Badge内容为纯数字的情况
    /// badge数字加1
    public func pp_increase() {
        pp_increaseBy(number: 1)
    }
    
    /// badge数字加number
    public func pp_increaseBy(number: Int) {
        let result = (NumberFormatter().number(from: self.badgeLabel.text!)?.intValue)! + number
        if result > 0 {
            pp_showBadge()
        }
        self.badgeLabel.text = "\(String(describing: result))"
    }
    
    /// badge数字加1
    public func pp_decrease() {
        pp_decreaseBy(number: 1)
    }
    
    /// badge数字减number
    public func pp_decreaseBy(number: Int) {
        let result = (NumberFormatter().number(from: self.badgeLabel.text!)?.intValue)! - number;
        if (result <= 0) {
            pp_hiddenBadge()
            self.badgeLabel.text = "0";
            return;
        }
        self.badgeLabel.text = "\(result)";
    }
}

// MARK: - getter/setter
public extension UIView {

    public var badgeLabel: PPBadgeLabel {
        get {
            if let aValue = objc_getAssociatedObject(self, &kBadgeLabel) as? PPBadgeLabel {
                return aValue
            } else {
                let defaultBadgeLabel = PPBadgeLabel.defaultBadgeLabel()
                defaultBadgeLabel.center = CGPoint(x: self.p_width, y: 0)
                self.addSubview(defaultBadgeLabel)
                self.bringSubview(toFront: defaultBadgeLabel)
                self.badgeLabel = defaultBadgeLabel
                return defaultBadgeLabel
            }
        }
        set {
            objc_setAssociatedObject(self, &kBadgeLabel, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
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
