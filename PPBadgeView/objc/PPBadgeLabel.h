//
//  PPBadgeLabel.h
//  PPBadgeViewObjc
//
//  Created by AndyPang on 2017/6/17.
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

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSUInteger, PPBadgeViewFlexMode) {
    PPBadgeViewFlexModeHead,    // 左伸缩 Head Flex    : <==●
    PPBadgeViewFlexModeTail,    // 右伸缩 Tail Flex    : ●==>
    PPBadgeViewFlexModeMiddle   // 左右伸缩 Middle Flex : <=●=>
};

@interface PPBadgeLabel : UILabel

+ (instancetype)defaultBadgeLabel;

/** Badge伸缩的方向, Default is PPBadgeViewFlexModeTail */
@property (nonatomic, assign) PPBadgeViewFlexMode flexMode;

/** 记录Badge的偏移量 Record the offset of Badge */
@property (nonatomic, assign) CGPoint offset;
@end
