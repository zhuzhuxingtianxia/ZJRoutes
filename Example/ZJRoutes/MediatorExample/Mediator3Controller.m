//
//  Mediator3Controller.m
//  ZJRoutes_Example
//
//  Created by ZZJ on 2018/9/5.
//  Copyright © 2018年 873391579@qq.com. All rights reserved.
//

#import "Mediator3Controller.h"

@interface Mediator3Controller ()

@end

@implementation Mediator3Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"Mediator3";
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame = CGRectMake(10, 140, 200, 40);
    [btn setTitle:@"present" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(presentAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(10, 240, 200, 40);
    [button setTitle:@"最后页" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(nextAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
}

-(void)nextAction:(UIButton*)sender {
    NSDictionary *dict = @{
                           };
    [self routeTargetController:@"Mediator1Controller" withParams:dict byRouteStyle:ZJRoute_Pop];
}

-(void)presentAction{
    NSDictionary *dict = @{@"baseTitle":@"present",
                           @"userName":@"presentAction"
                           };
  [self routeTargetController:@"Mediator1Controller" withParams:dict byRouteStyle:ZJRoute_Present];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
