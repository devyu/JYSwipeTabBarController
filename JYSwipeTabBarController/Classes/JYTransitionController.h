//
//  JYTransitionController.h
//  CCSildeTabBarController
//
//  Created by JY on 2020/8/25.
//  Copyright © 2020 cyd. All rights reserved.
//

#import <Foundation/Foundation.h>

@import UIKit;

NS_ASSUME_NONNULL_BEGIN

@interface JYTransitionController : UIPercentDrivenInteractiveTransition

- (instancetype)initWithGestureRecongnizer:(UIPanGestureRecognizer *)gesture NS_DESIGNATED_INITIALIZER;

- (instancetype)init NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
