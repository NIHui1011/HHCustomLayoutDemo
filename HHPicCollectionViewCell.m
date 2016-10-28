//
//  HHPicCollectionViewCell.m
//  HHCustomLayoutDemo
//
//  Created by 倪辉辉 on 2016/10/28.
//  Copyright © 2016年 倪辉辉. All rights reserved.
//

#import "HHPicCollectionViewCell.h"

@implementation HHPicCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self layoutSubviews];
    // Initialization code
}
- (void)layoutSubviews{
    [super layoutSubviews];
    [self layoutIfNeeded];
    [self configUI];
}
- (void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    }

- (void)configUI{
    self.layer.shadowRadius = 20;
    self.layer.shadowColor = [UIColor yellowColor].CGColor;
    self.layer.shadowOpacity = 0.8;
    self.layer.shadowOffset = CGSizeMake( 0, 0);
    self.layer.masksToBounds = false;

    
}

- (void)setIsShowDetial:(BOOL)isShowDetial{
    _isShowDetial = isShowDetial;
    if (_isShowDetial) {
        for (NSLayoutConstraint *c in _detialView.constraints) {
            if (c.firstAttribute == NSLayoutAttributeLeft) {
                c.constant  = -50;
            }
            if (c.firstAttribute == NSLayoutAttributeRight) {
                c.constant  = -50;
            }
            if (c.firstAttribute == NSLayoutAttributeBottom) {
                c.constant = -100;
            }
        }
        [self updateConstraintsIfNeeded];
        [UIView animateWithDuration:1 animations:^{
            _detialView.bounds = CGRectMake(0, 0, _detialView.frame.size.width + 100, 10+100);
            [self layoutIfNeeded];
        }];
        
    }else{
        for (NSLayoutConstraint *c in _detialView.constraints) {
            if (c.firstAttribute == NSLayoutAttributeLeft) {
                c.constant  = -0;
            }
            if (c.firstAttribute == NSLayoutAttributeRight) {
                c.constant  = -0;
            }
            if (c.firstAttribute == NSLayoutAttributeBottom) {
                c.constant = -0;
            }
        }
        [self updateConstraintsIfNeeded];
        [UIView animateWithDuration:1 animations:^{
            _detialView.bounds = CGRectMake(0, 0, _detialView.frame.size.width, 10);
            [self layoutIfNeeded];
        }];
        

    }
}

@end
