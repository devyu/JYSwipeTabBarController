//
//  JYTransitionController.m
//  CCSildeTabBarController
//
//  Created by JY on 2020/8/25.
//  Copyright © 2020 cyd. All rights reserved.
//

#import "JYTransitionController.h"

@interface JYTransitionController ()

@property (nonatomic, weak) id<UIViewControllerContextTransitioning> transitionContext;
@property (nonatomic, strong, readonly) UIPanGestureRecognizer *gesture;
@property (nonatomic, readwrite) CGPoint transslationPoint;

@end

@implementation JYTransitionController

// MARK: - init
- (instancetype)initWithGestureRecongnizer:(UIPanGestureRecognizer *)gesture
{
  self = [super init];
  if (self) {
    _gesture = gesture;
    [_gesture addTarget:self action:@selector(gestureUpdate:)];
  }
  return self;
}

- (instancetype)init
{
  @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"Use -initWithGestureRecongnizer:" userInfo:nil];
}

// MARK: -
- (void)startInteractiveTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
  self.transitionContext = transitionContext;
  self.transslationPoint = [self.gesture translationInView:transitionContext.containerView];
  [super startInteractiveTransition:transitionContext];
}

- (void)dealloc
{
  [self.gesture removeTarget:self action:@selector(gestureUpdate:)];
}

// MARK: -
- (void)gestureUpdate:(UIPanGestureRecognizer *)panGesture
{
  switch (panGesture.state) {
    case UIGestureRecognizerStateBegan:
      break;
    case UIGestureRecognizerStateChanged:
      if ([self percentForGesture:panGesture] < 0.f) {
        [self cancelInteractiveTransition];
        [self.gesture removeTarget:self action:@selector(gestureUpdate:)];
      } else {
        [self updateInteractiveTransition:[self percentForGesture:panGesture]];
      }
      break;
    case UIGestureRecognizerStateEnded:
      if ([self percentForGesture:panGesture] >= 0.4f) {
        [self finishInteractiveTransition];
      } else {
        [self cancelInteractiveTransition];
      }
      break;
    default:
      [self cancelInteractiveTransition];
      break;
  }
}

- (CGFloat)percentForGesture:(UIPanGestureRecognizer *)gesture
{
  UIView *containerView = self.transitionContext.containerView;
  CGPoint translation = [gesture translationInView:gesture.view.superview];
  if ((translation.x > 0.f && self.transslationPoint.x < 0.f) ||
      (translation.x < 0.f && self.transslationPoint.x > 0.f)) {
    return -1.f;
  }
  return fabs(translation.x) / CGRectGetWidth(containerView.bounds);
}


@end
