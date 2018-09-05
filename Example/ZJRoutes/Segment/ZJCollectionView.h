//
//  ZJCollectionView.h
//  ZJRoutes_Example
//
//  Created by ZZJ on 2018/9/3.
//  Copyright © 2018年 873391579@qq.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZJCollectionView : UICollectionView
@property (nonatomic, strong) NSArray <UIView *> *indicators;
@end

@interface ZJCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *maskTitleLabel;

@end
