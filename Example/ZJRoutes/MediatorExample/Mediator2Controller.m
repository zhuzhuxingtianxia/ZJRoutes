//
//  Mediator2Controller.m
//  ZJRoutes_Example
//
//  Created by ZZJ on 2018/9/5.
//  Copyright © 2018年 873391579@qq.com. All rights reserved.
//

#import "Mediator2Controller.h"

@interface Mediator2Controller ()

@end

@implementation Mediator2Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"Mediator2";
    
    switch (self.myEnum) {
        case MyEnumValueA:
            NSLog(@"MyEnumValueA");
            break;
        case MyEnumValueB:
            NSLog(@"MyEnumValueB");
            break;
        case MyEnumValueC:
            NSLog(@"MyEnumValueC");
            break;
            
        default:
            NSLog(@"MyEnumValueUnkomn");
            break;
    }
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(10, 240, 200, 40);
    [button setTitle:@"下一页" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(nextAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
}

-(void)nextAction:(UIButton*)sender {
    NSDictionary *dict = @{
                           };
    [self routeTargetController:@"Mediator3Controller" withParams:dict byRouteStyle:ZJRoute_Push];
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
