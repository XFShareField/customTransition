//
//  CustomPresention.m
//  CustomContainerDemo
//
//  Created by 谢飞 on 2018/9/13.
//  Copyright © 2018年 谢飞. All rights reserved.
//

#import "CustomPresention.h"
#import "CustomTransitionAnimation.h"



@implementation CustomPresention

/**
 返回自定义转场动画，通过此方法返回我们自定义的动画

 @param presented 即将要显示的Controller
 @param presenting 要Present新Controller的controller
 @param source 要执行PresentViewController：animated: completion:方法controller
 @return 返回我们自定义的动画作为转场动画，
 *该方法执行后 如果返回一个有效的遵守UIViewControllerAnimatedTransitioning协议的对象 接着
 *调用interactionControllerForPresention：方法确定是否有有效的可交互动画
 */
- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    CustomTransitionAnimation *trans = [[CustomTransitionAnimation alloc]initWithPresenting:YES];
    return trans;
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    
    CustomTransitionAnimation *transs = [[CustomTransitionAnimation alloc]initWithPresenting:NO];
    return transs;
}

- (nullable id <UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id <UIViewControllerAnimatedTransitioning>)animator{
    return  nil;
}

- (nullable id <UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id <UIViewControllerAnimatedTransitioning>)animator{
    return nil;
}

- (nullable UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(nullable UIViewController *)presenting sourceViewController:(UIViewController *)source{
    return nil;
}
@end
