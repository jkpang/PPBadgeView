
Pod::Spec.new do |s|

    s.name         = "PPBadgeView"

    s.version      = "1.1.0"

    s.platform     = :ios, '8.0'

    s.summary      = "iOS Custom Badge, Support UIView, UITabBarItem, UIBarButtonItem.  iOS自定义Badge控件, 支持UIView, UITabBarItem, UIBarButtonItem"

    s.homepage     = "https://github.com/jkpang/PPBadgeView.git"
 
    s.license      = { :type => "MIT", :file => "LICENSE" }

    s.author       = { "jkpang" => "jkpang@outlook.com" }

    s.source       = { :git => "https://github.com/jkpang/PPBadgeView.git", :tag => s.version }

    s.source_files = 'PPBadgeView/objc/*.{h,m}'

    s.framework = 'UIKit'

    s.requires_arc = true

end
