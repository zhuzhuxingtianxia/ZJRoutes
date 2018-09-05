//
//  ZJCollectionView.m
//  ZJRoutes_Example
//
//  Created by ZZJ on 2018/9/3.
//  Copyright © 2018年 873391579@qq.com. All rights reserved.
//

#import "ZJCollectionView.h"

@implementation ZJCollectionView

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    for (UIView *view in self.indicators) {
        [self sendSubviewToBack:view];
    }
}

@end


@interface ZJCollectionViewCell()
@property (nonatomic, strong) CALayer *maskLayer;
@end

@implementation ZJCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initializeViews];
    }
    return self;
}

- (void)initializeViews
{
    _titleLabel = [[UILabel alloc] init];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.titleLabel];
    
    _maskTitleLabel = [[UILabel alloc] init];
    _maskTitleLabel.hidden = YES;
    self.maskTitleLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.maskTitleLabel];
    
    _maskLayer = [CALayer layer];
    self.maskLayer.backgroundColor = [UIColor redColor].CGColor;
    self.maskTitleLabel.layer.mask = self.maskLayer;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.titleLabel.center = self.contentView.center;
    self.maskTitleLabel.center = self.contentView.center;
}

@end
