//
//  JYTabBarController.m
//  CCSildeTabBarController
//
//  Created by JY on 2020/8/22.
//  Copyright © 2020 cyd. All rights reserved.
//

#import "JYTabBarController.h"
#import "JYTransitionAnimation.h"
#import "JYTransitionController.h"


@interface JYTabBarController ()
<
UITabBarControllerDelegate
>

@property (nonatomic, strong) UIPanGestureRecognizer *panGesture;

@end


@implementation JYTabBarController


- (void)viewDidLoad
{
  [super viewDidLoad];
  
  self.selectedIndex = 0;
  self.delegate = self;
}

- (void)setSwipType:(SwipeTabBarType)swipType
{
  if (swipType != _swipType) {
    [self.view removeGestureRecognizer:self.panGesture];
    [self.tabBar removeGestureRecognizer:self.panGesture];
  }
  if (swipType == All) {
    [self.view addGestureRecognizer:self.panGesture];
  } else if (swipType == OnlyTabBar) {
    [self.tabBar addGestureRecognizer:self.panGesture];
  }
}

// MARK: - init
- (instancetype)init
{
  self = [super init];
  if (self) {
    _switchAnimation = YES;
  }
  return self;
}


// MARK: - UITabBarControllerDelegate
- (id<UIViewControllerAnimatedTransitioning>)tabBarController:(UITabBarController *)tabBarController
           animationControllerForTransitionFromViewController:(UIViewController *)fromVC
                                             toViewController:(UIViewController *)toVC
{
  if (!_switchAnimation) {
    return nil;
  }
  if (self.panGesture.state == UIGestureRecognizerStateBegan ||
      self.panGesture.state == UIGestureRecognizerStateChanged) {
    NSArray *viewControllers = tabBarController.viewControllers;
    if ([viewControllers indexOfObject:toVC] > [viewControllers indexOfObject:fromVC]) {
      // 左侧转场
      return [[JYTransitionAnimation alloc] initWithTargetEdge:UIRectEdgeLeft];
    } else {
      return [[JYTransitionAnimation alloc] initWithTargetEdge:UIRectEdgeRight];
    }
  } else {
    return nil;
  }
}

- (id<UIViewControllerInteractiveTransitioning>)tabBarController:(UITabBarController *)tabBarController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController
{
  if (self.panGesture.state == UIGestureRecognizerStateBegan ||
      self.panGesture.state == UIGestureRecognizerStateChanged) {
    return [[JYTransitionController alloc] initWithGestureRecongnizer:self.panGesture];
  }
  
  return nil;
}

// MARK: - Gesture Recognizer
- (UIPanGestureRecognizer *)panGesture
{
  if (!_panGesture) {
    _panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureAction:)];
  }
  return _panGesture;
}

- (void)panGestureAction:(UIPanGestureRecognizer *)gesture
{
  if (self.transitionCoordinator) {
    return;
  }
  if (gesture.state == UIGestureRecognizerStateBegan ||
      gesture.state == UIGestureRecognizerStateChanged) {
    [self computeTransition:gesture];
  }
}

- (void)computeTransition:(UIPanGestureRecognizer *)sender;
{
  CGPoint point = [sender translationInView:self.view];
  if (point.x > 0.f && self.selectedIndex > 0) {
    self.selectedIndex --;
  } else if (point.x < 0.f && self.selectedIndex + 1 < self.viewControllers.count) {
    self.selectedIndex ++;
  }
}

@end
