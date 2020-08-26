//
//  JYTabBarController.h
//  CCSildeTabBarController
//
//  Created by JY on 2020/8/22.
//  Copyright © 2020 cyd. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, SwipeTabBarType) {
  All = 0,
  OnlyTabBar,
  None,
};

NS_ASSUME_NONNULL_BEGIN

@interface JYTabBarController : UITabBarController

@property (nonatomic, assign) SwipeTabBarType swipType;
@property (nonatomic, assign) BOOL switchAnimation;

@end

NS_ASSUME_NONNULL_END
