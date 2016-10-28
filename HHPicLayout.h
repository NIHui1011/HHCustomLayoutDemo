//
//  HHPicLayout.h
//  HHCustomLayoutDemo
//
//  Created by 倪辉辉 on 2016/10/25.
//  Copyright © 2016年 倪辉辉. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol  HHPicLayoutDelegate<NSObject>
- (CGSize )collectionView:(UICollectionView *)collectionView sizeforcellWithIndexPath:(NSIndexPath *)indexPath;
@end

@interface HHPicLayout : UICollectionViewLayout
@property (nonatomic,assign)CGSize size;

@end
