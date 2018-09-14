//
//  ScrollTitileView.h
//  CustomContainerDemo
//
//  Created by 谢飞 on 2018/9/11.
//  Copyright © 2018年 谢飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ScrollTitleDelegate

@required
- (void)scrollTitleSelectIndex:(NSInteger)index;

@end

@interface ScrollTitileView : UIView
@property(nonatomic,strong)UIColor *normalTextColor;
@property(nonatomic,strong)UIColor *selectTextColor;
@property(nonatomic,assign)CGFloat textSize;
@property(nonatomic,strong)UIColor *indicatorColor;
@property(nonatomic , assign)NSInteger currentIndex;
@property(nonatomic,assign)BOOL showIndicator;
@property(nonatomic,weak)id<ScrollTitleDelegate> delegate;
- (instancetype)initWithFrame:(CGRect)frame TitleArr:(NSArray<NSString *>*)titles;
@end
