//
//  ViewController.m
//  HHCustomLayoutDemo
//
//  Created by 倪辉辉 on 2016/10/25.
//  Copyright © 2016年 倪辉辉. All rights reserved.
//

#import "ViewController.h"
#import "HHPicLayout.h"
#import "HHLineLayout.h"
#import "HHPicCollectionViewCell.h"

@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,HHPicLayoutDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic,assign)NSInteger cellNum;
@property (nonatomic,strong)HHPicLayout *roundLayout;
@property (nonatomic,strong)HHLineLayout *lineLayout;
@property (nonatomic,strong)NSMutableArray *showDetials;
@end

@implementation ViewController
static NSString *const HHPicCollectionViewCellId = @"HHPicCollectionViewCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    _cellNum = 10;
    [self configUI];
}

- (void)configUI{
    _showDetials = [NSMutableArray new];
    for (NSInteger i=0; i<_cellNum; i++) {
        [_showDetials addObject:@(0)];
    }
    _roundLayout  = [HHPicLayout new];
    _lineLayout = [HHLineLayout new];
    
    [_collectionView setCollectionViewLayout:_roundLayout animated:YES];
    [_collectionView registerNib:[UINib nibWithNibName:HHPicCollectionViewCellId bundle:nil] forCellWithReuseIdentifier:HHPicCollectionViewCellId];
    [_collectionView reloadData];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _cellNum;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HHPicCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:HHPicCollectionViewCellId forIndexPath:indexPath];
    cell.backgroundColor = [UIColor colorWithDisplayP3Red:random()%255/255.0 green:random()%255/255.0 blue:random()%255/255.0 alpha:1];
    if ([self.collectionView.collectionViewLayout isKindOfClass:[HHPicLayout class]]) {
         cell.isShowDetial = NO;
    }else{
         cell.isShowDetial = [_showDetials[indexPath.row] integerValue];
    }
   
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([_collectionView.collectionViewLayout isKindOfClass:[HHPicLayout class]]) {
        _cellNum--;
        if (_cellNum < 0) {
            _cellNum = 0;
        }
        [_collectionView reloadData];
    }else{
        
        HHPicCollectionViewCell *cell =(HHPicCollectionViewCell *) [_collectionView cellForItemAtIndexPath:indexPath];
        if ([_showDetials[indexPath.row] integerValue]) {
            _showDetials[indexPath.row] = @(0);
        }else{
            _showDetials[indexPath.row] = @(1);
        }
        cell.isShowDetial = [_showDetials[indexPath.row] integerValue];
    }
}

- (CGSize )collectionView:(UICollectionView *)collectionView sizeforcellWithIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(100, 100);
}
- (IBAction)changeLayout:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (!sender.selected) {
        [_collectionView setCollectionViewLayout:_roundLayout animated:YES];
    }else{
        [_collectionView setCollectionViewLayout:_lineLayout animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
