//
//  HHLineLayout.m
//  HHCustomLayoutDemo
//
//  Created by 倪辉辉 on 2016/10/28.
//  Copyright © 2016年 倪辉辉. All rights reserved.
//

#import "HHLineLayout.h"

@interface HHLineLayout()
{
    NSInteger _itemNum;
    NSMutableArray *_attrsArray;
    CGFloat _cWidth;
    CGFloat _cHeight;
}

@end

@implementation HHLineLayout

- (void)prepareLayout{
    [super prepareLayout];
    _cWidth = self.collectionView.frame.size.width;
    _cHeight = self.collectionView.frame.size.height;
    _attrsArray = [NSMutableArray new];
    self.itemSize = CGSizeMake(_cWidth - 70,_cHeight-200);
    _itemNum = [self.collectionView numberOfItemsInSection:0 ];
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.minimumLineSpacing = 30;//||间距
    self.minimumInteritemSpacing = 500;// =间距
    
    //设置内边距
//    CGFloat insert = 30;
    self.sectionInset =UIEdgeInsetsMake(0, 35, 0, 0);
}

- (CGSize)collectionViewContentSize{
    return CGSizeMake((_cWidth - 70) * _itemNum + (_itemNum - 1)*30 +100, self.collectionView.frame.size.height);
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    for (NSInteger i=0; i<_itemNum; i++) {
        NSIndexPath *indexpath = [NSIndexPath indexPathForRow:i inSection:0];
        UICollectionViewLayoutAttributes *attrs = [self layoutAttributesForItemAtIndexPath:indexpath];
        [_attrsArray addObject:attrs];
    }
    return _attrsArray;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewLayoutAttributes *attrs = [super layoutAttributesForItemAtIndexPath:indexPath];
   
    CGFloat centerX = self.collectionView.contentOffset.x + self.collectionView.frame.size.width * 0.5;
//    attrs.size = CGSizeMake(_cWidth - 70,_cHeight);
    CGFloat dist = ABS(attrs.center.x - centerX);
    CGFloat scale = 1 - dist/self.collectionView.frame.size.width/2.0;
    attrs.transform = CGAffineTransformMakeScale(scale, scale);
    
    return attrs;
}

/**
 *  只要手一松开就会调用
 *  这个方法的返回值，就决定了CollectionView停止滚动时的偏移量
 *  proposedContentOffset这个是最终的 偏移量的值 但是实际的情况还是要根据返回值来定
 *  velocity  是滚动速率  有个x和y 如果x有值 说明x上有速度
 *  如果y有值 说明y上又速度 还可以通过x或者y的正负来判断是左还是右（上还是下滑动）  有时候会有用
 */
-(CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
{
    //计算出 最终显示的矩形框
    CGRect rect;
    rect.origin.x =proposedContentOffset.x;
    rect.origin.y=0;
    rect.size=self.collectionView.frame.size;
    
    NSArray * array = [super layoutAttributesForElementsInRect:rect];
    
    // 计算CollectionView最中心点的x值 这里要求 最终的 要考虑惯性
    CGFloat centerX = self.collectionView.frame.size.width /2+ proposedContentOffset.x;
    //存放的最小间距
    CGFloat minDelta = MAXFLOAT;
    for (UICollectionViewLayoutAttributes * attrs in array) {
        if (ABS(minDelta)>ABS(attrs.center.x-centerX)) {
            minDelta=attrs.center.x-centerX;
        }
    }
    // 修改原有的偏移量
    proposedContentOffset.x+=minDelta;
    //如果返回的时zero 那个滑动停止后 就会立刻回到原地
    return proposedContentOffset;
}

/*!
 *  多次调用 只要滑出范围就会 调用
 *  当CollectionView的显示范围发生改变的时候，是否重新发生布局
 *  一旦重新刷新 布局，就会重新调用
 *  1.layoutAttributesForElementsInRect：方法
 *  2.preparelayout方法
 */
-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}







@end
