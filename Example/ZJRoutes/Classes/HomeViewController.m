//
//  HomeViewController.m
//  ComponentRoutes
//
//  Created by Jion on 2017/3/1.
//  Copyright © 2017年 Youjuke. All rights reserved.
//

#import "HomeViewController.h"
#import <ZJRoutes/UIViewController+ZJMediator.h>

#import "SegmentLayerView.h"
@interface HomeViewController ()

@property(nonatomic,strong)NSArray   *dataArray;

@property (nonatomic, strong) SegmentLayerView *categoryView;

@end

@implementation HomeViewController
//第一模块按钮点击事件
- (void)touch{
    
    NSString *url = @"ZJRoutes://NaviPush/OneViewController";
    
    //若有中文传输需要进行转义
    url = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    if ([[[UIDevice currentDevice] systemVersion] floatValue]<10.0){
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
    }else{
       [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url] options:@{} completionHandler:nil];
    }
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self buildView];

    [self buildSegment];
}

-(void)buildSegment {
    self.categoryView = [[SegmentLayerView alloc] init];
    CGSize size =[UIScreen mainScreen].bounds.size;
    self.categoryView.frame = CGRectMake(0, 200, size.width, 30);
    
   NSArray *titles = @[@"螃蟹", @"麻辣小龙虾", @"苹果", @"营养胡萝卜", @"葡萄", @"美味西瓜", @"香蕉", @"香甜菠萝", @"鸡肉", @"鱼", @"海星"];
    self.categoryView.titles = titles;
    
    [self.view addSubview:self.categoryView];
}

-(void)buildView{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:@"首页按钮" forState:UIControlStateNormal];
    button.translatesAutoresizingMaskIntoConstraints = NO;
    [button addTarget:self action:@selector(touch) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-leading-[button(100)]" options:0 metrics:@{@"leading":[NSNumber numberWithDouble:(self.view.frame.size.width-100)/2]} views:NSDictionaryOfVariableBindings(button)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-top-[button(40)]" options:0 metrics:@{@"top":[NSNumber numberWithDouble:64]} views:NSDictionaryOfVariableBindings(button)]];
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeSystem];
    [button1 setTitle:@"Mediator" forState:UIControlStateNormal];
    button1.translatesAutoresizingMaskIntoConstraints = NO;
    [button1 addTarget:self action:@selector(touchMediator) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button1];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-leading-[button1(100)]" options:0 metrics:@{@"leading":[NSNumber numberWithDouble:(self.view.frame.size.width-100)/2]} views:NSDictionaryOfVariableBindings(button1)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-top-[button1(40)]" options:0 metrics:@{@"top":[NSNumber numberWithDouble:164]} views:NSDictionaryOfVariableBindings(button1)]];
    
}

-(void)touchMediator {
    NSDictionary *dict = @{@"baseTitle":@"标题",
                           @"userName":@"用户名"
                           };
    [self routeTargetController:@"Mediator1Controller" withParams:dict];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
