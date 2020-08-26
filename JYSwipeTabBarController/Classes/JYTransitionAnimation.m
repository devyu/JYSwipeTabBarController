//
//  JYTransitionAnimation.m
//  CCSildeTabBarController
//
//  Created by JY on 2020/8/25.
//  Copyright © 2020 cyd. All rights reserved.
//

#import "JYTransitionAnimation.h"

@interface JYTransitionAnimation ()
<
UIViewControllerAnimatedTransitioning
>

@end

@implementation JYTransitionAnimation

- (instancetype)initWithTargetEdge:(UIRectEdge)targetEdge
{
  self = [super init];
  if (self) {
    _targetEdge = targetEdge;
  }
  return self;
}

// MARK: - UIViewControllerAnimatedTransitioning
- (NSTimeInterval)transitionDuration:(nullable id<UIViewControllerContextTransitioning>)transitionContext {
  return 0.35;
}

- (void)animateTransition:(nonnull id<UIViewControllerContextTransitioning>)transitionContext {
  UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
  UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
  
  UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
  UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
  
  CGRect fromFrame = [transitionContext initialFrameForViewController:fromVC];
  CGRect toFrame = [transitionContext finalFrameForViewController:toVC];
  
  CGVector offset;
  if (self.targetEdge == UIRectEdgeLeft) {
    offset = CGVectorMake(-1.f, 0.f);
  } else if (self.targetEdge == UIRectEdgeRight) {
    offset = CGVectorMake(1.f, 0.f);
  } else if (self.targetEdge == UIRectEdgeBottom) {
    offset = CGVectorMake(0.f, 1.f);
  } else if (self.targetEdge == UIRectEdgeTop) {
    offset = CGVectorMake(0.f, -1.f);
  } else {
    NSAssert(NO, @"targetEdge must be one of UIRectEdgeLeft、 UIRectEdgeRight、UIRectEdgeBottom or UIRectEdgeTop");
  }
  
  fromView.frame = fromFrame;
  toView.frame = CGRectOffset(toFrame,
                              toFrame.size.width * offset.dx * -1,
                              toFrame.size.height * offset.dy * -1);
  [transitionContext.containerView addSubview:toView];
  NSTimeInterval transitionDuration = [self transitionDuration:transitionContext];
  [UIView animateWithDuration:transitionDuration animations:^{
    fromView.frame = CGRectOffset(fromFrame,
                                  fromFrame.size.width * offset.dx,
                                  fromFrame.size.height * offset.dy);
    toView.frame = toFrame;
  } completion:^(BOOL finished) {
    [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
  }];
}


@end
