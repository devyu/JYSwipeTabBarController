//
//  JYTransitionAnimation.h
//  CCSildeTabBarController
//
//  Created by JY on 2020/8/25.
//  Copyright © 2020 cyd. All rights reserved.
//

#import <Foundation/Foundation.h>

@import UIKit;

NS_ASSUME_NONNULL_BEGIN

@interface JYTransitionAnimation : NSObject <UIViewControllerAnimatedTransitioning>

- (instancetype)initWithTargetEdge:(UIRectEdge)targetEdge;

@property (nonatomic, readwrite) UIRectEdge targetEdge;

@end

NS_ASSUME_NONNULL_END
