//
//  CustomTransitionAnimation.h
//  CustomContainerDemo
//
//  Created by 谢飞 on 2018/9/13.
//  Copyright © 2018年 谢飞. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CustomTransitionAnimation : NSObject <UIViewControllerAnimatedTransitioning>
@property(nonatomic,assign)BOOL isPresenting;
- (instancetype)initWithPresenting:(BOOL)isPresenting;
@end
