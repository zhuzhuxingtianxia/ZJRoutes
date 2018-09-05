//
//  TabbarController.m
//  ComponentRoutes
//
//  Created by Jion on 2017/3/1.
//  Copyright © 2017年 Youjuke. All rights reserved.
//

#import "TabbarController.h"
#import "NavigationController.h"
#import <objc/runtime.h>
#import <ZJRoutes/ZJRoutes.h>
@interface TabbarController ()

@end

@implementation TabbarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self addRoutes];
}
-(void)addRoutes{
    //异步设置路由，否则启动很慢
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0),^{
    
        NSString *customURL = @"ZJRoutes://Tabbar/HomeViewController/SettingViewController";
        
        if ([[[UIDevice currentDevice] systemVersion] floatValue]<10.0){
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:customURL]];
        }else{
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:customURL] options:@{} completionHandler:nil];
            });
            
        }

    });
    
    [[ZJRoutes globalRoutes] addRoute:@"/Tabbar/:HomeVC/:SettingVC" handler:^BOOL(NSDictionary<NSString *,id> * _Nonnull parameters) {
        
        UIViewController *homeVC = [[NSClassFromString(parameters[@"HomeVC"]) alloc] init];
        homeVC.tabBarItem.image = [[UIImage imageNamed:@"btn_sy_1"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        homeVC.tabBarItem.selectedImage = [[UIImage imageNamed:@"btn_sy_2"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        homeVC.title = @"首页";
        homeVC.tabBarItem.title = @"首页";
        NavigationController *navHome = [[NavigationController alloc] initWithRootViewController:homeVC];
        
        UIViewController *settingVC = [[NSClassFromString(parameters[@"SettingVC"]) alloc] init];
        settingVC.tabBarItem.image = [[UIImage imageNamed:@"btn_grzl_1"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        settingVC.tabBarItem.selectedImage = [[UIImage imageNamed:@"btn_grzl_2"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        settingVC.title = @"个人中心";
        settingVC.tabBarItem.title = @"设置";
        NavigationController *navSeting = [[NavigationController alloc] initWithRootViewController:settingVC];
        
        self.viewControllers = @[navHome,navSeting];
        
        return YES;
    }];
    
    [[ZJRoutes globalRoutes] addRoute:@"/NaviPush/:controller" handler:^BOOL(NSDictionary<NSString *,id> * _Nonnull parameters) {
        UIViewController *currentVc = [self currentViewController];
        UIViewController *v = [[NSClassFromString(parameters[@"controller"]) alloc] init];
        [self paramToVc:v param:parameters];
        [currentVc.navigationController pushViewController:v animated:YES];
        
        return YES;
    }];
    
    [[ZJRoutes globalRoutes] addRoute:@"/StoryBoardPush" handler:^BOOL(NSDictionary<NSString *,id> * _Nonnull parameters) {
        UIViewController *currentVc = [self currentViewController];
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:parameters[@"sbname"] bundle:nil];
        UIViewController *v  = [storyboard instantiateViewControllerWithIdentifier:parameters[@"bundleid"]];
        [self paramToVc:v param:parameters];
        [currentVc.navigationController pushViewController:v animated:YES];
        
        return YES;
    }];
    
    [[ZJRoutes globalRoutes] addRoute:@"/NaviPop/:controller" handler:^BOOL(NSDictionary<NSString *,id> * _Nonnull parameters) {
        
        Class aclass = NSClassFromString(parameters[@"controller"]);
        if (aclass) {
            UIViewController *currentVc = [self currentViewController];
            if (currentVc.navigationController) {
                for (UIViewController *vc in currentVc.navigationController.childViewControllers) {
                    if ([vc isKindOfClass:[aclass class]]) {
                        [self paramToVc:vc param:parameters];
                        [currentVc.navigationController popToViewController:vc animated:YES];
                    }
                }
            }else{
                [currentVc dismissViewControllerAnimated:YES completion:^{
                    
                }];
            }
        }
        
        return YES;
    }];

}
-(void)paramToVc:(UIViewController *) v param:(NSDictionary<NSString *,NSString *> *)parameters{
    //runtime将参数传递至需要跳转的控制器
    unsigned int outCount = 0;
    objc_property_t * properties = class_copyPropertyList(v.class , &outCount);
    for (int i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        NSString *key = [NSString stringWithUTF8String:property_getName(property)];
        NSString *param = parameters[key];
        if (param != nil) {
            [v setValue:param forKey:key];
        }
    }
}

- (UIViewController *)currentViewController{
    
    UIViewController * currVC = nil;
    UIViewController * Rootvc = [[UIApplication sharedApplication] keyWindow].rootViewController ;
    do {
        if ([Rootvc isKindOfClass:[UINavigationController class]]) {
            UINavigationController * nav = (UINavigationController *)Rootvc;
            UIViewController * v = [nav.viewControllers lastObject];
            currVC = v;
            Rootvc = v.presentedViewController;
            continue;
        }else if([Rootvc isKindOfClass:[UITabBarController class]]){
            UITabBarController * tabVC = (UITabBarController *)Rootvc;
            currVC = tabVC;
            Rootvc = [tabVC.viewControllers objectAtIndex:tabVC.selectedIndex];
            continue;
        }
    } while (Rootvc!=nil);
    
    return currVC;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
