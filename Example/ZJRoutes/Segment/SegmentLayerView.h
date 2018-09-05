//
//  SegmentLayerView.h
//  ZJRoutes_Example
//
//  Created by ZZJ on 2018/9/3.
//  Copyright © 2018年 873391579@qq.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SegmentLayerView : UIView
@property (nonatomic, strong) NSArray <NSString *>*titles;
//默认：[UIColor blackColor]
@property (nonatomic, strong) UIColor *titleColor;
//默认：[UIColor redColor]
@property (nonatomic, strong) UIColor *titleSelectedColor;
//默认：[UIFont systemFontOfSize:15]
@property (nonatomic, strong) UIFont *titleFont;
//cell之间的间距，默认20
@property (nonatomic, assign) CGFloat cellSpacing;

@end
