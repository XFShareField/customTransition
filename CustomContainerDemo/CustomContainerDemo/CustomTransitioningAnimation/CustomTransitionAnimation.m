//
//  CustomTransitionAnimation.m
//  CustomContainerDemo
//
//  Created by 谢飞 on 2018/9/13.
//  Copyright © 2018年 谢飞. All rights reserved.
//

#import "CustomTransitionAnimation.h"

@implementation CustomTransitionAnimation

- (instancetype)initWithPresenting:(BOOL)isPresenting{
    if (self = [super init]) {
        self.isPresenting = isPresenting;
    }
    return self;
}
// This is used for percent driven interactive transitions, as well as for
// container controllers that have companion animations that might need to
// synchronize with the main animation.
- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext{
    return 3;
}
// This method can only  be a nop if the transition is interactive and not a percentDriven interactive transition.
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
    //从transitionContext中获取动画相关对象
    UIView *container = [transitionContext containerView];
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    
    //设置动画的初始状态
    CGRect containerFrame = container.frame;
    CGRect toViewStartFrame = [transitionContext initialFrameForViewController:toVC];
    CGRect toViewFinalFrame = [transitionContext finalFrameForViewController:toVC];
    CGRect fromViewFinalFrame = [transitionContext finalFrameForViewController:fromVC];

    if (self.isPresenting) {
        //presention 动画
        //设置Presented ViewController的初始状态 位于容器的右下角
        toViewStartFrame.origin.x = containerFrame.size.width;
        toViewStartFrame.origin.y = containerFrame.size.height;
    }else{
        //dismiss 动画
        fromViewFinalFrame = CGRectMake(containerFrame.size.width, containerFrame.size.height, toView.frame.size.width, toView.frame.size.height);
    }
    
    //将 toView 添加到容器视图
    [container addSubview:toView];
    toView.frame = toViewStartFrame;
    NSLog(@"toView === %@,fromView===%@",toView,fromView);
    NSLog(@"toVC.view===%@,fromVC.view===%@",toVC.view,fromVC.view);
    
    //开始动画
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        NSLog(@"toView === %@,fromView===%@",toView,fromView);
        if (self.isPresenting) {
            //presention 动画
            [toView setFrame:toViewFinalFrame];
        }else{
            [fromView setFrame:fromViewFinalFrame];
        }
    } completion:^(BOOL finished) {
        NSLog(@"toView === %@,fromView===%@",toView,fromView);
        //成功执行
        BOOL success = ![transitionContext transitionWasCancelled];
        if ((self.isPresenting && !success)||(!self.isPresenting && success)) {
            //转场失败 或者 非presention animation,remove toView from superView
            [toView removeFromSuperview];
        }
        //转场成功 必须调用[transitionContext completeTranision:success];通知UIKit 转场完成，可以调用presentionViewController:animation:completion: 方法的completion block
        [transitionContext completeTransition:success];
    }];
}


/// A conforming object implements this method if the transition it creates can
/// be interrupted. For example, it could return an instance of a
/// UIViewPropertyAnimator. It is expected that this method will return the same
/// instance for the life of a transition.
- (id <UIViewImplicitlyAnimating>) interruptibleAnimatorForTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
    return  nil;
}

// This is a convenience and if implemented will be invoked by the system when the transition context's completeTransition: method is invoked.
- (void)animationEnded:(BOOL) transitionCompleted{

}
@end
