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

private var kBadgeView = "kBadgeView"

// MARK: - add Badge
public extension PP where Base: UIView {
    
    var badgeView: PPBadgeControl {
        return base.badgeView
    }
    
    /// 添加带文本内容的Badge, 默认右上角, 红色, 18pts 
    ///
    /// Add Badge with text content, the default upper right corner, red backgroundColor, 18pts
    ///
    /// - Parameter text: 文本字符串
    func addBadge(text: String?) {
        showBadge()
        base.badgeView.text = text
        setBadge(flexMode: base.badgeView.flexMode)
        if text == nil {
            if base.badgeView.widthConstraint()?.relation == .equal { return }
            base.badgeView.widthConstraint()?.isActive = false
            let constraint = NSLayoutConstraint(item: base.badgeView, attribute: .width, relatedBy: .equal, toItem: base.badgeView, attribute: .height, multiplier: 1.0, constant: 0)
            base.badgeView.addConstraint(constraint)
        } else {
            if base.badgeView.widthConstraint()?.relation == .greaterThanOrEqual { return }
            base.badgeView.widthConstraint()?.isActive = false
            let constraint = NSLayoutConstraint(item: base.badgeView, attribute: .width, relatedBy: .greaterThanOrEqual, toItem: base.badgeView, attribute: .height, multiplier: 1.0, constant: 0)
            base.badgeView.addConstraint(constraint)
        }
    }
    
    /// 添加带数字的Badge, 默认右上角,红色,18pts 
    ///
    /// Add the Badge with numbers, the default upper right corner, red backgroundColor, 18pts
    ///
    /// - Parameter number: 整形数字
    func addBadge(number: Int) {
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
    func addDot(color: UIColor? = .red) {
        addBadge(text: nil)
        setBadge(height: 8.0)
        base.badgeView.backgroundColor = color
    }
    
    /// 设置Badge的偏移量, Badge中心点默认为其父视图的右上角 
    ///
    /// Set Badge offset, Badge center point defaults to the top right corner of its parent view
    ///
    /// - Parameters:
    ///   - x: X轴偏移量 (x<0: 左移, x>0: 右移) axis offset (x <0: left, x> 0: right)
    ///   - y: Y轴偏移量 (y<0: 上移, y>0: 下移) axis offset (Y <0: up,   y> 0: down)
    func moveBadge(x: CGFloat, y: CGFloat) {
        base.badgeView.offset = CGPoint(x: x, y: y)
        base.centerYConstraint(with: base.badgeView)?.constant = y
        
        let badgeHeight = base.badgeView.heightConstraint()?.constant ?? 0
        switch base.badgeView.flexMode {
        case .head:
            base.centerXConstraint(with: base.badgeView)?.isActive = false
            base.leadingConstraint(with: base.badgeView)?.isActive = false
            if let constraint = base.trailingConstraint(with: base.badgeView) {
                constraint.constant = badgeHeight * 0.5 + x
                return
            }
            let trailingConstraint = NSLayoutConstraint(item: base.badgeView, attribute: .trailing, relatedBy: .equal, toItem: base, attribute: .trailing, multiplier: 1.0, constant: badgeHeight * 0.5 + x)
            base.addConstraint(trailingConstraint)
            
        case .tail:
            base.centerXConstraint(with: base.badgeView)?.isActive = false
            base.trailingConstraint(with: base.badgeView)?.isActive = false
            if let constraint = base.leadingConstraint(with: base.badgeView) {
                constraint.constant = x - badgeHeight * 0.5
                return
            }
            let leadingConstraint = NSLayoutConstraint(item: base.badgeView, attribute: .leading, relatedBy: .equal, toItem: base, attribute: .trailing, multiplier: 1.0, constant: x - badgeHeight * 0.5)
            base.addConstraint(leadingConstraint)
            
        case .middle:
            base.leadingConstraint(with: base.badgeView)?.isActive = false
            base.trailingConstraint(with: base.badgeView)?.isActive = false
            base.centerXConstraint(with: base.badgeView)?.constant = x
            if let constraint = base.centerXConstraint(with: base.badgeView) {
                constraint.constant = x
                return
            }
            let centerXConstraint = NSLayoutConstraint(item: base.badgeView, attribute: .centerX, relatedBy: .equal, toItem: base, attribute: .centerX, multiplier: 1.0, constant: x)
            base.addConstraint(centerXConstraint)
        }
    }
    
    /// 设置Badge伸缩的方向
    ///
    /// Setting the direction of Badge expansion
    ///
    /// PPBadgeViewFlexModeHead,    左伸缩 Head Flex    : <==●
    /// PPBadgeViewFlexModeTail,    右伸缩 Tail Flex    : ●==>
    /// PPBadgeViewFlexModeMiddle   左右伸缩 Middle Flex : <=●=>
    /// - Parameter flexMode : Default is PPBadgeViewFlexModeTail
    func setBadge(flexMode: PPBadgeViewFlexMode = .tail) {
        base.badgeView.flexMode = flexMode
        moveBadge(x: base.badgeView.offset.x, y: base.badgeView.offset.y)
    }
    
    /// 设置Badge的高度,因为Badge宽度是动态可变的,通过改变Badge高度,其宽度也按比例变化,方便布局
    ///
    /// (注意: 此方法需要将Badge添加到控件上后再调用!!!)
    ///
    /// Set the height of Badge, because the Badge width is dynamically and  variable.By changing the Badge height in proportion to facilitate the layout.
    ///
    /// (Note: this method needs to add Badge to the controls and then use it !!!)
    ///
    /// - Parameter height: 高度大小
    func setBadge(height: CGFloat) {
        base.badgeView.layer.cornerRadius = height * 0.5
        base.badgeView.heightConstraint()?.constant = height
        moveBadge(x: base.badgeView.offset.x, y: base.badgeView.offset.y)
    }
    
    /// 显示Badge
    func showBadge() {
        base.badgeView.isHidden = false
    }
    
    /// 隐藏Badge
    func hiddenBadge() {
        base.badgeView.isHidden = true
    }
    
    // MARK: - 数字增加/减少, 注意:以下方法只适用于Badge内容为纯数字的情况
    // MARK: - Digital increase /decrease, note: the following method applies only to cases where the Badge content is purely numeric
    /// badge数字加1
    func increase() {
        increaseBy(number: 1)
    }
    
    /// badge数字加number
    func increaseBy(number: Int) {
        let label = base.badgeView
        let result = (Int(label.text ?? "0") ?? 0) + number
        if result > 0 {
            showBadge()
        }
        label.text = "\(result)"
    }
    
    /// badge数字加1
    func decrease() {
        decreaseBy(number: 1)
    }
    
    /// badge数字减number
    func decreaseBy(number: Int) {
        let label = base.badgeView
        let result = (Int(label.text ?? "0") ?? 0) - number
        if (result <= 0) {
            hiddenBadge()
            label.text = "0"
            return
        }
        label.text = "\(result)"
    }
}

extension UIView {
    
    private func addBadgeViewLayoutConstraint() {
        badgeView.translatesAutoresizingMaskIntoConstraints = false
        let centerXConstraint = NSLayoutConstraint(item: badgeView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: 0)
        let centerYConstraint = NSLayoutConstraint(item: badgeView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 0)
        let widthConstraint = NSLayoutConstraint(item: badgeView, attribute: .width, relatedBy: .greaterThanOrEqual, toItem: badgeView, attribute: .height, multiplier: 1.0, constant: 0)
        let heightConstraint = NSLayoutConstraint(item: badgeView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 18)
        addConstraints([centerXConstraint, centerYConstraint])
        badgeView.addConstraints([widthConstraint, heightConstraint])
    }
}

// MARK: - getter/setter
extension UIView {

    public var badgeView: PPBadgeControl {
        get {
            if let aValue = objc_getAssociatedObject(self, &kBadgeView) as? PPBadgeControl {
                return aValue
            }
            else {
                let badgeControl = PPBadgeControl.default()
                self.addSubview(badgeControl)
                self.bringSubviewToFront(badgeControl)
                self.badgeView = badgeControl
                self.addBadgeViewLayoutConstraint()
                return badgeControl
            }
        }
        set {
            objc_setAssociatedObject(self, &kBadgeView, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    internal func topConstraint(with item: AnyObject?) -> NSLayoutConstraint? {
        return constraint(with: item, attribute: .top)
    }
    
    internal func leadingConstraint(with item: AnyObject?) -> NSLayoutConstraint? {
        return constraint(with: item, attribute: .leading)
    }
    
    internal func bottomConstraint(with item: AnyObject?) -> NSLayoutConstraint? {
        return constraint(with: item, attribute: .bottom)
    }

    internal func trailingConstraint(with item: AnyObject?) -> NSLayoutConstraint? {
        return constraint(with: item, attribute: .trailing)
    }
    
    internal func widthConstraint() -> NSLayoutConstraint? {
        return constraint(with: self, attribute: .width)
    }
    
    internal func heightConstraint() -> NSLayoutConstraint? {
        return constraint(with: self, attribute: .height)
    }

    internal func centerXConstraint(with item: AnyObject?) -> NSLayoutConstraint? {
        return constraint(with: item, attribute: .centerX)
    }
    
    internal func centerYConstraint(with item: AnyObject?) -> NSLayoutConstraint? {
        return constraint(with: item, attribute: .centerY)
    }
    
    private func constraint(with item: AnyObject?, attribute: NSLayoutConstraint.Attribute) -> NSLayoutConstraint? {
        for constraint in constraints {
            if let isSame = constraint.firstItem?.isEqual(item), isSame, constraint.firstAttribute == attribute {
                return constraint
            }
        }
        return nil
    }
}
