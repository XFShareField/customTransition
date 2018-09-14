//
//  CustomPercentDrivenTransition.m
//  CustomContainerDemo
//
//  Created by 谢飞 on 2018/9/14.
//  Copyright © 2018年 谢飞. All rights reserved.
//

#import "CustomPercentDrivenTransition.h"

@interface CustomPercentDrivenTransition ()
@property(nonatomic,strong)id contextData;
@property(nonatomic,strong)UIPanGestureRecognizer *panG;

@end

@implementation CustomPercentDrivenTransition

- (void)startInteractiveTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    [super startInteractiveTransition:transitionContext];
    
    self.contextData = transitionContext;
    
    //添加手势
    self.panG = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeUpdate:)];
    self.panG.maximumNumberOfTouches = 1;
    
    UIView *container = [transitionContext containerView];
    [container addGestureRecognizer:self.panG];
}
-(void)handleSwipeUpdate:(UIGestureRecognizer *)gestureRecognizer {
    UIView* container = [self.contextData containerView];
    
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        // Reset the translation value at the beginning of the gesture.
        [self.panG setTranslation:CGPointMake(0, 0) inView:container];
    }
    else if (gestureRecognizer.state == UIGestureRecognizerStateChanged) {
        // Get the current translation value.
        CGPoint translation = [self.panG translationInView:container];
        
        // Compute how far the gesture has travelled vertically,
        //  relative to the height of the container view.
        CGFloat percentage = fabs(translation.y / CGRectGetHeight(container.bounds));
        
        // Use the translation value to update the interactive animator.
        [self updateInteractiveTransition:percentage];
    }
    else if (gestureRecognizer.state >= UIGestureRecognizerStateEnded) {
        // Finish the transition and remove the gesture recognizer.
        [self finishInteractiveTransition];
        [[self.contextData containerView] removeGestureRecognizer:self.panG];
    }
}
@end
