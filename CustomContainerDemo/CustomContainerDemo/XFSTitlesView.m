//
//  XFSTitlesView.m
//  CustomContainerDemo
//
//  Created by 谢飞 on 2018/9/12.
//  Copyright © 2018年 谢飞. All rights reserved.
//

#import "XFSTitlesView.h"
#import "XFSCollectionViewCell.h"

@interface XFSTitlesView()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property(nonatomic,strong)UICollectionView *titleCollection;
@property(nonatomic,strong)NSArray *dataArr;
@property(nonatomic,strong)XFSCollectionViewCell *selectCell;
@property(nonatomic,strong)UIView *currentIndicator;
@end

@implementation XFSTitlesView

#pragma mark - initializer Method

- (instancetype)initWithFrame:(CGRect)frame TitleArr:(NSArray<NSString *> *)titles{
    if (self = [super initWithFrame:frame]) {
        self.dataArr = titles.copy;
        self.currentIndex = 0;
        [self buildColletionView];
        self.backgroundColor = [UIColor cyanColor];
        self.showIndicator = NO;
//        _currentIndicator.hidden = YES;
    }
    return self;
}
#pragma mark - Lazy Method

- (UICollectionView *)titleCollection{
    if (!_titleCollection) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _titleCollection = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) collectionViewLayout:layout];
        _titleCollection.delegate = self;
        _titleCollection.dataSource = self;
        _titleCollection.bounces = NO;
        _titleCollection.backgroundColor = [UIColor clearColor];
    }
    return _titleCollection;
}
- (UIView *)currentIndicator{
    if (!_currentIndicator) {
        _currentIndicator = [[UIView alloc]init];
        _currentIndicator.backgroundColor = [UIColor orangeColor];
        _currentIndicator.clipsToBounds = YES;
        _currentIndicator.layer.cornerRadius = 1.5;
    }
    return _currentIndicator;
}
#pragma mark - Public Method

- (void)setCurrentIndex:(NSInteger)currentIndex{
    if (_currentIndex == currentIndex) {
        return;
    }
    _selectCell.titleLabel.textColor = self.normalTextColor?self.normalTextColor:[UIColor lightGrayColor];
    _selectCell.titleLabel.font = [UIFont systemFontOfSize:self.textSize?self.textSize:15];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:currentIndex inSection:0];
    _selectCell =(XFSCollectionViewCell*) [self.titleCollection cellForItemAtIndexPath:indexPath];
    _selectCell.titleLabel.textColor = self.selectTextColor?self.selectTextColor:[UIColor orangeColor];
    _selectCell.titleLabel.font = [UIFont systemFontOfSize:self.textSize?self.textSize+5:15];
    _currentIndex = currentIndex;
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.25 animations:^{
        weakSelf.currentIndicator.frame = CGRectMake(weakSelf.selectCell.frame.origin.x, weakSelf.frame.size.height-3, weakSelf.selectCell.frame.size.width, 3);
    }];
    [self.titleCollection scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    [self.titleCollection reloadData];
    if (self.delegate) {
        [self.delegate XFSTtitleViewSelectIndex:currentIndex];
    }
}
- (void)setNormalTextColor:(UIColor *)normalTextColor{
    _normalTextColor = normalTextColor;
    [self.titleCollection reloadData];
}
- (void)setSelectTextColor:(UIColor *)selectTextColor{
    _selectTextColor = selectTextColor;
    [self.titleCollection reloadData];
}
- (void)setTextSize:(CGFloat)textSize{
    _textSize = textSize;
    [self.titleCollection reloadData];
}
- (void)setIndicatorColor:(UIColor *)indicatorColor{
    _currentIndicator.backgroundColor = indicatorColor;
}
- (void)setShowIndicator:(BOOL)showIndicator{
    _showIndicator = showIndicator;
    if (showIndicator) {
        self.currentIndicator.hidden = NO;
    }else{
        self.currentIndicator.hidden = YES;
    }
}
#pragma mark - Method Private

- (void)buildColletionView{
    [self.titleCollection registerNib:[UINib nibWithNibName:@"XFSCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"XFSCollectionViewCell"];
//    NSString *titles = [self.dataArr componentsJoinedByString:@""];
//    CGFloat titlesWidth = [titles boundingRectWithSize:CGSizeMake(MAXFLOAT, self.textSize?self.textSize+5:15) options:NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:self.textSize?self.textSize+5:15]} context:nil].size.width;
//    CGFloat width = self.frame.size.width;
//    if (titlesWidth<width-(self.dataArr.count+1)*5) {
//        //make titleCollection center
//        self.titleCollection.frame = CGRectMake((width-titlesWidth)/2, 0, titlesWidth, self.frame.size.height);
//    }
    [self addSubview:self.titleCollection];
    [self.titleCollection addSubview:self.currentIndicator];
}

#pragma mark - UICollectionViewDelegate UIColletionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSLog(@"cells Count ==== %lu",(unsigned long)self.dataArr.count);
    return self.dataArr.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    XFSCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"XFSCollectionViewCell" forIndexPath:indexPath];
    if (self.currentIndex == indexPath.row) {
        cell.titleLabel.font = [UIFont systemFontOfSize:self.textSize?self.textSize+5:15];
        cell.titleLabel.textColor = self.selectTextColor?self.selectTextColor:[UIColor orangeColor];
        _currentIndicator.frame = CGRectMake(cell.frame.origin.x, self.frame.size.height-3, cell.frame.size.width, 3);
        self.selectCell = cell;
    }else{
        cell.titleLabel.font = [UIFont systemFontOfSize:self.textSize?self.textSize:15];
        cell.titleLabel.textColor = self.normalTextColor?self.normalTextColor:[UIColor lightGrayColor];
    }
    NSString *title = self.dataArr[indexPath.row];
    cell.titleLabel.text = title;
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.currentIndex == indexPath.row) {
        return;
    }
    self.currentIndex = indexPath.row;
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSString *title = self.dataArr[indexPath.row];
    CGSize size;
    if (self.currentIndex == indexPath.row) {
        size = [title boundingRectWithSize:CGSizeMake(MAXFLOAT, self.textSize+5) options:NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:self.textSize?self.textSize+5:15]} context:nil].size;
    }else{
        size = [title boundingRectWithSize:CGSizeMake(MAXFLOAT, self.frame.size.height) options:NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:self.textSize?self.textSize:15]} context:nil].size;
    }
    
    return size;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 4;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 5, 0, 5);
}

@end
