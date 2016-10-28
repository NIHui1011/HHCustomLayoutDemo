//
//  HHPicCollectionViewCell.h
//  HHCustomLayoutDemo
//
//  Created by 倪辉辉 on 2016/10/28.
//  Copyright © 2016年 倪辉辉. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HHPicCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIView *detialView;
@property (nonatomic,assign)BOOL isShowDetial;
@end
