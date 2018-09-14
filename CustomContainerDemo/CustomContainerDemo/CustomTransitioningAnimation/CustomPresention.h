//
//  CustomPresention.h
//  CustomContainerDemo
//
//  Created by 谢飞 on 2018/9/13.
//  Copyright © 2018年 谢飞. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
/**
 *Transitioning Delegate对象是自定义专场动画的起始点，为自定义专场动画提供一下专场动画相关的对象
 *1、Animator 对象：提供presention和dismiss动画，可以是自定义动画和UIView动画
 *  该对象需要遵守UIViewControllerAnimatedTransitioning协议
 *2、Interactive animator object对象 该对象操作点击事件和手势事件驱动的动画 遵守UIViewControllerInteractiveTransitioning协议
 *3、PresentionController对象 该对象管理controller呈现在窗口的外观
 */

@interface CustomPresention : NSObject <UIViewControllerTransitioningDelegate>


@end
