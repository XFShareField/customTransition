//
//  ScrollTitileView.m
//  CustomContainerDemo
//
//  Created by 谢飞 on 2018/9/11.
//  Copyright © 2018年 谢飞. All rights reserved.
//

#import "ScrollTitileView.h"
#define NORMALCOLOR   [UIColor lightGrayColor]
#define SELECTCOLOR   [UIColor blueColor]

@interface ScrollTitileView()<UIScrollViewDelegate>
@property(nonatomic,strong)UIScrollView *container;
@property (nonatomic , strong)NSArray <NSString *> *titleArr;
@property (nonatomic , strong)NSMutableArray *btnArr;
@property (nonatomic , strong)UIView *currentIndicator;
@end

@implementation ScrollTitileView

- (instancetype)initWithFrame:(CGRect)frame TitleArr:(NSArray<NSString *>*)titles{
    if (self = [super initWithFrame:frame]) {
        self.titleArr = titles;
        self.backgroundColor = [UIColor cyanColor];
        self.currentIndex = 0;
        [self setUpUI];
        self.showIndicator = NO;
//        self.currentIndicator.hidden = YES;
    }
    return self;
}
- (void)setCurrentIndex:(NSInteger)currentIndex{
    if (_currentIndex == currentIndex) {
        return;
    }
    CGFloat height = self.frame.size.height;
    UIButton *oldBtn = self.btnArr[self.currentIndex];
    oldBtn.titleLabel.font = [UIFont systemFontOfSize:self.textSize?self.textSize:15];
    oldBtn.selected = NO;
    _currentIndex = currentIndex;
    UIButton *nowBtn = self.btnArr[_currentIndex];
    nowBtn.titleLabel.font = [UIFont systemFontOfSize:self.textSize?self.textSize+5:20];
    nowBtn.selected = YES;
    
    [UIView animateWithDuration:0.25 animations:^{
        self->_currentIndicator.frame = CGRectMake(nowBtn.frame.origin.x, height-2, nowBtn.frame.size.width, 2);
    }];
    [self.container scrollRectToVisible:nowBtn.frame animated:YES];
}
- (void)setIndicatorColor:(UIColor *)indicatorColor{
    self.currentIndicator.backgroundColor = indicatorColor;
}
- (void)setTextSize:(CGFloat)textSize{
    _textSize = textSize;
    [self addTitles];
}
- (void)setNormalTextColor:(UIColor *)normalTextColor{
    _normalTextColor = normalTextColor;
    [self addTitles];
}
- (void)setSelectTextColor:(UIColor *)selectTextColor{
    _selectTextColor = selectTextColor;
    [self addTitles];
}
- (void)setShowIndicator:(BOOL)showIndicator{
    _showIndicator = showIndicator;
    if (showIndicator) {
        self.currentIndicator.hidden = NO;
    }else{
        self.currentIndicator.hidden = YES;
    }
}
#pragma mark - private method

- (void)setUpUI{
    [self addTitles];
    [self addSubview:self.container];
}
- (void)addTitles{
    for (UIButton *button in self.btnArr) {
        [button removeFromSuperview];
    }
    [self.currentIndicator removeFromSuperview];
    [self.btnArr removeAllObjects];
    NSString *titles = [self.titleArr componentsJoinedByString:@""];
    CGFloat titlesWidth = [titles boundingRectWithSize:CGSizeMake(MAXFLOAT, self.textSize?self.textSize+5:15) options:NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:self.textSize?self.textSize+5:15]} context:nil].size.width;
    CGFloat origin;
    if (titlesWidth > self.frame.size.width) {
        origin = 4;
    }else{
        origin = (self.frame.size.width - titlesWidth)/2;
    }
    CGFloat height = self.frame.size.height;
    for (NSString *title in self.titleArr) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:title forState:UIControlStateNormal];
        [btn setTitleColor:self.normalTextColor?self.normalTextColor:NORMALCOLOR forState:UIControlStateNormal];
        [btn setTitleColor:self.selectTextColor?self.selectTextColor:SELECTCOLOR forState:UIControlStateSelected];
        btn.titleLabel.font = [UIFont systemFontOfSize:self.textSize?self.textSize+5:15];
        CGSize btnSize = btn.intrinsicContentSize;
        btn.frame = CGRectMake(origin, (height - btnSize.height)/2, btnSize.width, btnSize.height);
        [btn addTarget:self action:@selector(selectBtn:) forControlEvents:UIControlEventTouchUpInside];
        origin += btn.frame.size.width;
        btn.titleLabel.font = [UIFont systemFontOfSize:self.textSize?self.textSize:15];
        [self.container addSubview:btn];
        [self.btnArr addObject:btn];
    }
    UIButton *select = self.btnArr[self.currentIndex];
    select.selected = YES;
    select.titleLabel.font = [UIFont systemFontOfSize:self.textSize?self.textSize+5:15];
    self.currentIndicator.frame = CGRectMake(select.frame.origin.x, height-2, select.frame.size.width, 2);
    [self.container addSubview:self.currentIndicator];
    _container.contentSize = CGSizeMake(origin+8, height);
}

- (void)selectBtn:(UIButton *)btn{
    NSInteger index = [self.btnArr indexOfObject:btn];
    self.currentIndex = index;
    if (self.delegate) {
        [self.delegate scrollTitleSelectIndex:index];
    }
}
#pragma mark - lazy

- (UIScrollView *)container{
    if (!_container) {
        _container = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        _container.showsHorizontalScrollIndicator = NO;
        _container.bounces = NO;
        _container.delegate = self;
    }
    return _container;
}
- (NSMutableArray*)btnArr{
    if (!_btnArr) {
        _btnArr = [[NSMutableArray alloc]init];
    }
    return _btnArr;
}
- (UIView *)currentIndicator{
    if (!_currentIndicator) {
        _currentIndicator = [[UIView alloc]init];
        _currentIndicator.clipsToBounds = YES;
        _currentIndicator.layer.cornerRadius = 1;
        _currentIndicator.backgroundColor = [UIColor orangeColor];
    }
    return _currentIndicator;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{

}

@end
