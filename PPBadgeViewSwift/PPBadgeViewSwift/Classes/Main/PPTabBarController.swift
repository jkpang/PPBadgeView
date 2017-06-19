//
//  PPTabBarController.swift
//  PPBadgeViewSwift
//
//  Created by AndyPang on 2017/6/19.
//  Copyright © 2017年 AndyPang. All rights reserved.
//

import UIKit

class PPTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let controller1 = PPViewController1.init()
        let controller2 = PPViewController2.init()
        let controller3 = PPViewController3.init()
        let controller4 = PPViewController4.init()
        
        setupChildController(controller: controller1, title: "点餐", image: "dinner", selectedImage: "dinner_1")
        setupChildController(controller: controller2, title: "订单", image: "order", selectedImage: "order_1")
        setupChildController(controller: controller3, title: "充值", image: "top_up", selectedImage: "top_up_1")
        setupChildController(controller: controller4, title: "我的", image: "my", selectedImage: "my_1")
        
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName:UIColor.darkGray], for: .selected)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+0.1) {
//            controller1.tabBarItem
        }
        
    }
    
    func setupChildController(controller: UIViewController, title: String, image: String, selectedImage: String) {
        
        controller.tabBarItem.title = title
        controller.tabBarItem.image = UIImage.init(named: image)?.withRenderingMode(.alwaysOriginal)
        controller.tabBarItem.selectedImage = UIImage.init(named: selectedImage)?.withRenderingMode(.alwaysOriginal)
        self.addChildViewController(UINavigationController.init(rootViewController: controller))
        
    }
    
}
