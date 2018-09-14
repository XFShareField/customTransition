//
//  CustomDismissAnimation.m
//  CustomContainerDemo
//
//  Created by 谢飞 on 2018/9/14.
//  Copyright © 2018年 谢飞. All rights reserved.
//

#import "CustomDismissAnimation.h"

@implementation CustomDismissAnimation

- (CGFloat)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return 3;
}
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    UIView *container = [transitionContext containerView];
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    CGRect toViewFinalFrame = [transitionContext finalFrameForViewController:toVC];
    [container addSubview:toView];
    
    CGRect fromViewFinalFrame = [transitionContext finalFrameForViewController:fromVC];
    fromViewFinalFrame = CGRectMake(container.frame.size.width, container.frame.size.height, fromView.frame.size.width, fromView.frame.size.height);
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        [fromView setFrame:fromViewFinalFrame];
        [toView setFrame:toViewFinalFrame];
    } completion:^(BOOL finished) {
        
        [transitionContext completeTransition:YES];
    }];
}
@end
