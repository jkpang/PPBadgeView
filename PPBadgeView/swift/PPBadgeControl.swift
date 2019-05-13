//
//  PPBadgeControl.swift
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


open class PPBadgeControl: UIControl {
    
    /// 记录Badge的偏移量 Record the offset of Badge
    public var offset: CGPoint = CGPoint(x: 0, y: 0)
    
    /// Badge伸缩的方向, Default is PPBadgeViewFlexModeTail
    public var flexMode: PPBadgeViewFlexMode = .tail
    
    private lazy var textLabel: UILabel = UILabel()
    
    private lazy var imageView: UIImageView = UIImageView()
    
    private var badgeViewColor: UIColor?
    private var badgeViewHeightConstraint: NSLayoutConstraint?
    
    public class func `default`() -> Self {
        return self.init(frame: .zero)
    }
    
    required override public init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Set Text
    open var text: String? {
        didSet {
            textLabel.text = text
        }
    }
    
    /// Set AttributedText
    open var attributedText: NSAttributedString? {
        didSet {
            textLabel.attributedText = attributedText
        }
    }
    
    /// Set Font
    open var font: UIFont? {
        didSet {
            textLabel.font = font
        }
    }
    
    /// Set background image
    open var backgroundImage: UIImage? {
        didSet {
            imageView.image = backgroundImage
            if let _ = backgroundImage {
                if let constraint = heightConstraint() {
                    badgeViewHeightConstraint = constraint
                    removeConstraint(constraint)
                }
                backgroundColor = UIColor.clear
            } else {
                if heightConstraint() == nil, let constraint = badgeViewHeightConstraint {
                    addConstraint(constraint)
                }
                backgroundColor = badgeViewColor
            }
        }
    }
    
    open override var backgroundColor: UIColor? {
        didSet {
            super.backgroundColor = backgroundColor
            if let color = backgroundColor, color != .clear {
                badgeViewColor = backgroundColor
            }
        }
    }
    
    private func setupSubviews() {
        layer.masksToBounds = true
        layer.cornerRadius = 9.0
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor.red
        textLabel.textColor = UIColor.white
        textLabel.font = UIFont.systemFont(ofSize: 13)
        textLabel.textAlignment = .center
        addSubview(textLabel)
        addSubview(imageView)
        addLayout(with: imageView, leading: 0, trailing: 0)
        addLayout(with: textLabel, leading: 5, trailing: -5)
    }
    
    private func addLayout(with view: UIView, leading: CGFloat, trailing: CGFloat) {
        view.translatesAutoresizingMaskIntoConstraints = false
        let topConstraint = NSLayoutConstraint(item: view, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 0)
        let leadingConstraint = NSLayoutConstraint(item: view, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: leading)
        let bottomConstraint = NSLayoutConstraint(item: view, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: 0)
        let trailingConstraint = NSLayoutConstraint(item: view, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: trailing)
        leadingConstraint.priority = UILayoutPriority(rawValue: 999)
        trailingConstraint.priority = UILayoutPriority(rawValue: 999)
        addConstraints([topConstraint, leadingConstraint, bottomConstraint, trailingConstraint])
    }
}
