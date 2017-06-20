//
//  PPBadgeLabel.swift
//  PPBadgeViewSwift
//
//  Created by AndyPang on 2017/6/19.
//  Copyright © 2017年 AndyPang. All rights reserved.
//

import UIKit

open class PPBadgeLabel: UILabel {
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        setupUI();
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
    public class func defaultBadgeLabel() -> PPBadgeLabel {
        return PPBadgeLabel.init(frame: CGRect(x: 0, y: 0, width: 18, height: 18))
    }
    
    private func setupUI() {
        self.textColor = UIColor.white
        self.font = UIFont.systemFont(ofSize: 13)
        self.textAlignment = NSTextAlignment.center
        self.layer.cornerRadius = self.p_height * 0.5
        self.layer.masksToBounds = true
        self.backgroundColor = UIColor.init(red: 1.00, green: 0.17, blue: 0.15, alpha: 1.0)
    }
    
    // 重写UILabel的text属性方法
    override open var text: String? {
        didSet {
            // 根据内容长度调整Label宽
            let stringWidth = widthForString(string: self.text!, font: self.font, height: self.p_height)
            if self.p_height > stringWidth + self.p_height*10/18 {
                self.p_width = self.p_height
                return
            }
            self.p_width = self.p_height*5/18/*left*/ + stringWidth + self.p_height*5/18/*right*/;
        }
    }
    
    private func widthForString(string: String, font:UIFont, height: CGFloat) -> CGFloat {
        let attributes : [String: AnyObject] = [NSFontAttributeName: font]
        let options = NSStringDrawingOptions.usesLineFragmentOrigin.rawValue | NSStringDrawingOptions.usesFontLeading.rawValue
        let size = CGSize(width: CGFloat.greatestFiniteMagnitude, height: height)
        let rect = (string as NSString).boundingRect(with: size, options: NSStringDrawingOptions(rawValue: options), attributes: attributes, context: nil)
        return rect.size.width
    }
}
