//
//  ViewController.m
//  CustomContainerDemo
//
//  Created by 谢飞 on 2018/9/11.
//  Copyright © 2018年 谢飞. All rights reserved.
//

#import "ViewController.h"
#import "ScrollTitileView.h"
#import "XFSTitlesView.h"


@interface ViewController ()<UIScrollViewDelegate,ScrollTitleDelegate,XFSTitleViewDelegate>
@property (nonatomic , strong)ScrollTitileView *titleView;
@property(nonatomic , strong)UIScrollView *contentScroll;
@property(nonatomic,strong)XFSTitlesView *XFSTitles;
@property(nonatomic,assign)CGFloat topOffSet;
/**
 子Controller 数组
 */
@property (nonatomic , strong)NSMutableArray<UIViewController *> *VCArr;

/**
 子Controller标题数组
 */
@property (nonatomic , strong)NSMutableArray<NSString *> *titleArr;
@end

@implementation ViewController
- (instancetype)initWithVCArr:(NSArray<UIViewController *>*)viewControllers titles:(NSArray<NSString *>*)titles{
    if (self = [super init]) {
        self.VCArr = viewControllers.mutableCopy;
        self.titleArr = titles.mutableCopy;
       
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    if ([self.parentViewController isKindOfClass: [UINavigationController class]]) {
        self.topOffSet = 64;
    }else{
        _topOffSet = 0;
    }
    [self.view addSubview:self.titleView];
    //        [self.view addSubview:self.XFSTitles];
    [self.view addSubview:self.contentScroll];
    [self addControllers];
    self.title = @"容器";
}
- (BOOL) shouldAutomaticallyForwardAppearanceMethods {
    return NO;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    for (UIViewController* v in self.VCArr) {
        [v beginAppearanceTransition:YES animated:animated];
    }
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    for (UIViewController* v in self.VCArr) {
        [v endAppearanceTransition];
    }
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    for (UIViewController* v in self.VCArr) {
        [v beginAppearanceTransition:YES animated:animated];
    }
}
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    for (UIViewController* v in self.VCArr) {
        [v endAppearanceTransition];
    }

}
#pragma mark - Private Method

- (UIColor *)randomColor{
    return [UIColor colorWithRed:(arc4random()%255)/255.0 green:(arc4random()%255)/255.0 blue:(arc4random()%255)/255.0 alpha:1];
}
- (void)addControllers{
    for (UIViewController *vc in self.VCArr) {
        [self displayViewController:vc];
    }
}
- (void)displayViewController:(UIViewController *)VC{
    NSInteger index = [self.VCArr indexOfObject:VC];
    CGFloat width = self.view.frame.size.width;
    CGFloat height = self.view.frame.size.height;
    //1.将vc作为子vc添加到容器
    [self addChildViewController:VC];
    //2.设置子VC的view的位置和大小
    VC.view.frame = CGRectMake(index*width, 0, width, height-self.topOffSet-34);
    //3.将子VC的view添加到容器
    [self.contentScroll addSubview:VC.view];
    //4.调用子VC的didMoveToParentViewController：方法
    [VC didMoveToParentViewController:self];
}
#pragma mark - Lazy method

- (ScrollTitileView *)titleView{
    if (!_titleView) {
        _titleView = [[ScrollTitileView alloc]initWithFrame:CGRectMake(0, self.topOffSet, self.view.bounds.size.width, 34) TitleArr:self.titleArr];
        _titleView.normalTextColor = [UIColor blackColor];
        _titleView.selectTextColor = [UIColor orangeColor];
        _titleView.textSize = 15;
        _titleView.delegate = self;
    }
    return _titleView;
}
- (XFSTitlesView *)XFSTitles{
    if (!_XFSTitles) {
        _XFSTitles = [[XFSTitlesView alloc]initWithFrame:CGRectMake(0, self.topOffSet, self.view.bounds.size.width, 34) TitleArr:self.titleArr];
        _XFSTitles.normalTextColor = [UIColor blackColor];
        _XFSTitles.selectTextColor = [UIColor blueColor];
        _XFSTitles.textSize = 17;
        _XFSTitles.delegate = self;
    }
    return _XFSTitles;
}
- (UIScrollView *)contentScroll{
    if (!_contentScroll) {
        _contentScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, self.topOffSet+34, self.view.frame.size.width, self.view.frame.size.height-self.topOffSet-34)];
        _contentScroll.pagingEnabled = YES;
        _contentScroll.bounces = NO;
        _contentScroll.delegate = self;
        _contentScroll.showsVerticalScrollIndicator = NO;
        _contentScroll.showsHorizontalScrollIndicator = NO;
        _contentScroll.contentSize = CGSizeMake(self.VCArr.count*self.view.frame.size.width, self.view.frame.size.height-self.topOffSet-34);
    }
    return _contentScroll;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    CGFloat width = self.view.frame.size.width;
//    NSLog(@"Scroll class is ====%@",NSStringFromClass([scrollView class]));
//    NSInteger index = ceil(scrollView.contentOffset.x/width);
//    if (fabs(scrollView.contentOffset.x-index*width) <= width/2) {
//        self.titleView.currentIndex = index;
//        self.XFSTitles.currentIndex = index;
//    }

}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    CGFloat width = self.view.frame.size.width;
    NSLog(@"Scroll class is ====%@",NSStringFromClass([scrollView class]));
    NSInteger index = ceil(scrollView.contentOffset.x/width);
    if (fabs(scrollView.contentOffset.x-index*width) <= width/2) {
        self.titleView.currentIndex = index;
        self.XFSTitles.currentIndex = index;
    }
}
#pragma mark - ScrollTitleDelegate

- (void)scrollTitleSelectIndex:(NSInteger)index{
    CGFloat width = self.view.frame.size.width;
    [self.contentScroll setContentOffset:CGPointMake(width*index, 0)];
}

#pragma mark - XFSTitlesDelegate

- (void)XFSTtitleViewSelectIndex:(NSInteger)index{
    CGFloat width = self.view.frame.size.width;
    [self.contentScroll setContentOffset:CGPointMake(width*index, 0)];
}
@end
