//
//  XFSTitlesView.h
//  CustomContainerDemo
//
//  Created by 谢飞 on 2018/9/12.
//  Copyright © 2018年 谢飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XFSTitleViewDelegate
@required
- (void)XFSTtitleViewSelectIndex:(NSInteger)index;
@end

@interface XFSTitlesView : UIView

@property(nonatomic,strong)UIColor *normalTextColor;
@property(nonatomic,strong)UIColor *selectTextColor;
@property(nonatomic,assign)CGFloat textSize;
@property(nonatomic,strong)UIColor *indicatorColor;
@property(nonatomic , assign)NSInteger currentIndex;
@property(nonatomic,assign)BOOL showIndicator;
@property(nonatomic,weak)id<XFSTitleViewDelegate> delegate;
//- (instancetype)init NS_UNAVAILABLE;
//- (instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;
- (instancetype)initWithFrame:(CGRect)frame TitleArr:(NSArray<NSString *>*)titles ;
@end
