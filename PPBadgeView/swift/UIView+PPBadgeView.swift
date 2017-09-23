//
//  UIView+PPBadgeView.swift
//  PPBadgeViewSwift
//
//  Created by AndyPang on 2017/6/19.
//  Copyright © 2017年 AndyPang. All rights reserved.
//

/*
 *********************************************************************************
 *
 * Weibo : jkpang-庞 ( http://weibo.com/jkpang )
 * Email : jkpang@outlook.com
 * QQ 群 : 323408051
 * GitHub: https://github.com/jkpang
 *
 *********************************************************************************
 */

import UIKit

private var kBadgeLabel = "kBadgeLabel"

public struct PP<Base> {
    public let base: Base
    public init(_ base: Base) {
        self.base = base
    }
}

public extension UIView {
    public var pp: PP<UIView> {
        return PP(self)
    }
}

// MARK: - add Badge
public extension PP where Base: UIView {
    
    /// 添加带文本内容的Badge, 默认右上角, 红色, 18pts 
    ///
    /// Add Badge with text content, the default upper right corner, red backgroundColor, 18pts
    ///
    /// - Parameter text: 文本字符串
    public func addBadge(text: String) {
        showBadge()
        self.base.badgeLabel.text = text;
    }
    
    /// 添加带数字的Badge, 默认右上角,红色,18pts 
    ///
    /// Add the Badge with numbers, the default upper right corner, red backgroundColor, 18pts
    ///
    /// - Parameter number: 整形数字
    public func addBadge(number: Int) {
        if number <= 0 {
            addBadge(text: "0")
            hiddenBadge()
            return
        }
        addBadge(text: "\(number)")
    }
    
    /// 添加带颜色的小圆点, 默认右上角, 红色, 8pts 
    ///
    /// Add small dots with color, the default upper right corner, red backgroundColor, 8pts
    ///
    /// - Parameter color: 颜色
    public func addDot(color: UIColor?) {
        addBadge(text: "")
        setBadgeHeight(points: 8.0)
        if let color = color  {
            self.base.badgeLabel.backgroundColor = color
        }
    }
    
    /// 设置Badge的偏移量, Badge中心点默认为其父视图的右上角 
    ///
    /// Set Badge offset, Badge center point defaults to the top right corner of its parent view
    ///
    /// - Parameters:
    ///   - x: X轴偏移量 (x<0: 左移, x>0: 右移) axis offset (x <0: left, x> 0: right)
    ///   - y: Y轴偏移量 (y<0: 上移, y>0: 下移) axis offset (Y <0: up,   y> 0: down)
    public func moveBadge(x: CGFloat, y: CGFloat) {
        /**
         self.badgeLabel.center = CGPointMake(self.p_width+x, y);
         
         如果通过badge的center来调整其在父视图的位置, 在给badge赋值不同长度的内容时
         会导致badge会以中心点向两边调整其自身宽度,如果badge过长会遮挡部分父视图, 所以
         正确的方式是以badge的x坐标为起点,其宽度向x轴正方向增加/x轴负方向减少
         */
        self.base.badgeLabel.p_x = (self.base.p_width - self.base.badgeLabel.p_height*0.5)/*badge的x坐标*/ + x;
        self.base.badgeLabel.p_y = -self.base.badgeLabel.p_height*0.5/*badge的y坐标*/ + y;
    }
    
    /// 设置Badge的高度,因为Badge宽度是动态可变的,通过改变Badge高度,其宽度也按比例变化,方便布局
    ///
    /// (注意: 此方法需要将Badge添加到控件上后再调用!!!)
    ///
    /// Set the height of Badge, because the Badge width is dynamically and  variable.By changing the Badge height in proportion to facilitate the layout.
    ///
    /// (Note: this method needs to add Badge to the controls and then use it !!!)
    ///
    /// - Parameter points: 高度大小
    public func setBadgeHeight(points: CGFloat) {
        let scale = points/self.base.badgeLabel.p_height
        self.base.badgeLabel.transform = self.base.badgeLabel.transform.scaledBy(x: scale, y: scale);
    }
    
    /// 设置Bage的属性 ;
    ///
    /// Set properties for Badge
    ///
    /// - Parameter attributes: 将badgeLabel对象回调出来的闭包
    public func setBadgeLabel(attributes: (PPBadgeLabel)->()) {
        attributes(self.base.badgeLabel)
    }
    
    /// 显示Badge
    public func showBadge() {
        self.base.badgeLabel.isHidden = false
    }
    
    /// 隐藏Badge
    public func hiddenBadge() {
        self.base.badgeLabel.isHidden = true
    }
    
    // MARK: - 数字增加/减少, 注意:以下方法只适用于Badge内容为纯数字的情况
    // MARK: - Digital increase /decrease, note: the following method applies only to cases where the Badge content is purely numeric
    /// badge数字加1
    public func increase() {
        increaseBy(number: 1)
    }
    
    /// badge数字加number
    public func increaseBy(number: Int) {
        let label = self.base.badgeLabel
        let result = ((NumberFormatter().number(from: label.text ?? "")?.intValue) ?? 0) + number
        if result > 0 {
            showBadge()
        }
        label.text = "\(String(describing: result))"
    }
    
    /// badge数字加1
    public func decrease() {
        decreaseBy(number: 1)
    }
    
    /// badge数字减number
    public func decreaseBy(number: Int) {
        let result = (NumberFormatter().number(from: self.base.badgeLabel.text!)?.intValue)! - number;
        if (result <= 0) {
            hiddenBadge()
            self.base.badgeLabel.text = "0";
            return;
        }
        self.base.badgeLabel.text = "\(result)";
    }
}

// MARK: - getter/setter
extension UIView {

    var badgeLabel: PPBadgeLabel {
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
    
    var p_x: CGFloat {
        get {
            return frame.origin.x
        }
        set {
            frame.origin.x = newValue
        }
    }
    
    var p_y: CGFloat {
        get {
            return frame.origin.y
        }
        set {
            frame.origin.y = newValue
        }
    }
    
    var p_right: CGFloat {
        get {
            return frame.origin.x + frame.size.width
        }
        set {
            frame.origin.x = newValue - frame.size.width
        }
    }
    
    var p_bottom: CGFloat {
        get {
            return frame.origin.y + frame.size.height
        }
        set {
            frame.origin.y = newValue - frame.size.height
        }
    }
    
    var p_width: CGFloat {
        get {
            return frame.size.width
        }
        set {
            frame.size.width = newValue
        }
    }
    
    var p_height: CGFloat {
        get {
            return frame.size.height
        }
        set {
            frame.size.height = newValue
        }
    }
    
    var p_centerX: CGFloat {
        get {
            return center.x
        }
        set {
            center.x = newValue
        }
    }
    
    var p_centerY: CGFloat {
        get {
            return center.y
        }
        set {
            center.y = newValue
        }
    }
}
