//
//  HHPicLayout.m
//  HHCustomLayoutDemo
//
//  Created by 倪辉辉 on 2016/10/25.
//  Copyright © 2016年 倪辉辉. All rights reserved.
//

#import "HHPicLayout.h"

@interface HHPicLayout()
@property (nonatomic,assign)NSInteger itemsNum;
@property (nonatomic,strong)NSMutableArray *layoutAttributes;
@end


@implementation HHPicLayout

- (void)prepareLayout{
    [super prepareLayout];
    NSLog(@"%@",self.collectionView);
    _layoutAttributes = [NSMutableArray new];
    _itemsNum = [self.collectionView numberOfItemsInSection:0];
}

- (nullable NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    for (NSInteger i=0; i<_itemsNum; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        [self layoutAttributesForItemAtIndexPath:indexPath];

    }
      return _layoutAttributes;
}
- (nullable UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    //设置cell的大小
    attributes.size = CGSizeMake(60.0, 60.0);
    //当前cell的角度
    //注意类型的转换
    CGFloat centerX = self.collectionView.center.x;
    CGFloat centerY = self.collectionView.center.y;
    CGFloat _r = 80.0;
    CGFloat angle = 2 * (CGFloat )(M_PI) * (CGFloat)indexPath.row/_itemsNum;
    attributes.center = CGPointMake(centerX + _r * cos(angle), centerY + _r * sin(angle));
    [_layoutAttributes addObject:attributes];
    return attributes;
}
/**
  *   用来布局cell最终的落点
  */
- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity {
    return proposedContentOffset;
    
}

//- (CGSize)collectionViewContentSize{
//    return CGSizeMake(self.collectionView.frame.size.width, self.collectionView.frame.size.height);
//}

@end
