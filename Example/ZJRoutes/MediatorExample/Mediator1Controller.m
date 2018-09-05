//
//  Mediator1Controller.m
//  ZJRoutes_Example
//
//  Created by ZZJ on 2018/9/5.
//  Copyright © 2018年 873391579@qq.com. All rights reserved.
//

#import "Mediator1Controller.h"
#import "ENUM.h"

@interface Mediator1Controller ()
@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,strong)UILabel *userNameLabel;

@end

@implementation Mediator1Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"Mediator1";
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(10, 240, 200, 40);
    [button setTitle:@"下一页" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(nextAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
}

-(void)setUserName:(NSString *)userName {
    _userName = userName;
    self.userNameLabel.text = [NSString stringWithFormat:@"userName:%@",_userName];
}

-(void)setBaseTitle:(NSString *)baseTitle {
    [super setBaseTitle:baseTitle];
    self.titleLabel.text = [NSString stringWithFormat:@"baseTitle:%@",baseTitle];
}

-(void)nextAction:(UIButton*)sender {
    if (self.presentingViewController) {
        [self routeTargetController:nil withParams:nil byRouteStyle:ZJRoute_Dismiss];
    }else {
        NSDictionary *dict = @{@"baseTitle":@"标题",
                               @"myEnum":@(MyEnumValueB)
                               };
        [self routeTargetController:@"Mediator2Controller" withParams:dict byRouteStyle:ZJRoute_PushNo];
    }
    
}


#pragma mark - srtter
-(UILabel*)titleLabel {
    if (!_titleLabel) {
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 80, 200, 40)];
        [self.view addSubview:titleLabel];
        _titleLabel = titleLabel;
    }
    return _titleLabel;
}

-(UILabel*)userNameLabel {
    if (!_userNameLabel) {
        UILabel *userNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 160, 200, 40)];
        [self.view addSubview:userNameLabel];
        _userNameLabel = userNameLabel;
    }
    return _userNameLabel;
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
