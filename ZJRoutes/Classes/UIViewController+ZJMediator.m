//
//  UIViewController+ZJMediator.m
//  Pods-ZJRoutes_Example
//
//  Created by ZZJ on 2018/9/4.
//

#import "UIViewController+ZJMediator.h"
#import <objc/runtime.h>

NSString *const kMediator = @"ZJMediatorKey";
static NSMutableDictionary *routesMap = nil;

@implementation UIViewController (ZJMediator)
-(UIViewController*)routeTargetController:(NSString*)aClass withParams:(NSDictionary *)dict{
    
    return [self routeTargetController:aClass withParams:dict byRouteStyle:ZJRoute_Push];
}

-(UIViewController*)routeTargetController:(NSString*)aClass withParams:(NSDictionary *)dict byRouteStyle:(ZJRouteStyle)routeStyle{
    
    Class cl = NSClassFromString(aClass);
    if (![cl isKindOfClass:[UIViewController class]]) {
        NSString *errorString = [NSString stringWithFormat:@"<%@> a not exist Controller",aClass];
        NSAssert(YES, errorString);
        return nil;
    }
    
    UIViewController *viewController = [[cl alloc] init];
    if (dict) {
        [self paramToVc:viewController param:dict];
    }
    [self jumpToVC:viewController routeType:routeStyle];
    
    return viewController;
}

/*
 Storyboard中identifier为对应的类名称时
 或identifier不为类名但在Main.storyboard中
 */
-(UIViewController*)routeTargetIdentifier:(NSString*)identifier withParams:(NSDictionary *)dict byRouteStyle:(ZJRouteStyle)routeStyle {
    Class aClass = NSClassFromString(identifier);
    UIViewController *viewController;
    if (![aClass isKindOfClass:[UIViewController class]]) {
        viewController = [self routeTargetIdentifier:identifier inStoryboard:@"Main" withParams:dict byRouteStyle:routeStyle];
        return viewController;
    }
    NSArray *sbArray = [self storyboardArray];
    
    for (NSString *storyboard in sbArray) {
       viewController = [[UIStoryboard storyboardWithName:storyboard bundle:nil] instantiateViewControllerWithIdentifier:identifier];
        if (viewController) {
            break;
        }
    }
    
    if (!viewController) {
        NSString *errorString = [NSString stringWithFormat:@"not found identifier <%@> in all storyboard",identifier];
        NSAssert(YES, errorString);
    }
    
    if (dict) {
        [self paramToVc:viewController param:dict];
    }
    [self jumpToVC:viewController routeType:routeStyle];
    
    return viewController;
}

//Storyboard中identifier不为对应的类名称时
-(UIViewController*)routeTargetIdentifier:(NSString*)identifier inStoryboard:(NSString*)storyboard withParams:(NSDictionary *)dict byRouteStyle:(ZJRouteStyle)routeStyle {
    
    UIViewController *viewController = [[UIStoryboard storyboardWithName:storyboard bundle:nil] instantiateViewControllerWithIdentifier:identifier];
    if (!viewController) {
        NSString *errorString = [NSString stringWithFormat:@"not found identifier <%@> in storyboard<%@>",identifier,storyboard];
        NSAssert(YES, errorString);
        return nil;
    }
    
    if (dict) {
        [self paramToVc:viewController param:dict];
    }
    [self jumpToVC:viewController routeType:routeStyle];
    
    return viewController;
}

#pragma mark - Private

-(void)jumpToVC:(UIViewController*)viewController routeType:(ZJRouteStyle)routeStyle{
    switch (routeStyle) {
        case ZJRoute_Push:
            [self.navigationController pushViewController:viewController animated:YES];
            break;
        case ZJRoute_PushNo:
            [self.navigationController pushViewController:viewController animated:NO];
            break;
        case ZJRoute_Pop:
            if (viewController) {
                [self.navigationController popToViewController:viewController animated:YES];
            }else {
                [self.navigationController popViewControllerAnimated:YES];
            }
            break;
        case ZJRoute_Present:
            [self presentViewController:viewController animated:YES completion:^{
                
            }];
            break;
        case ZJRoute_PresentNo:
            [self presentViewController:viewController animated:NO completion:^{
                
            }];
            break;
        case ZJRoute_Dismiss:
            [self dismissViewControllerAnimated:YES completion:^{
                
            }];
            break;
            
        default:
            break;
    }
}

-(NSArray *)storyboardArray {
    //storyboard在Bundle里面以“*.storyboardc”文件存在
    NSArray *array = [[NSBundle mainBundle] pathsForResourcesOfType:@"storyboardc" inDirectory:nil];
    NSMutableArray * __array = [NSMutableArray array];
    for (NSString *path in array) {
        NSString *file = [path lastPathComponent];
        NSLog(@"%@",file);
        
        NSString *fileName = [file stringByDeletingPathExtension];
        
        if (![fileName isEqualToString:@"Main"] && !([fileName containsString:@"Launch"]||[fileName containsString:@"~"])) {
            //这里设置忽略加载的Storyboard
            if ([fileName rangeOfString:@"ignore"].length == 0)
                [__array addObject:[UIStoryboard storyboardWithName:fileName bundle:nil]];
        }
        
    }
    
    //延迟加载，开发过程中优先加载编辑中的storyboard
    [__array addObject:[UIStoryboard storyboardWithName:@"Main" bundle:nil]];
    
    return __array;
}

-(void)paramToVc:(UIViewController *)vc param:(NSDictionary<NSString *,NSString *> *)parameters{
    //runtime将参数传递至需要跳转的控制器
    unsigned int outCount = 0;
    objc_property_t * properties = class_copyPropertyList(vc.class , &outCount);
    for (int i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        NSString *key = [NSString stringWithUTF8String:property_getName(property)];
        NSString *param = parameters[key];
        if (param != nil) {
            [vc setValue:param forKey:key];
        }
    }
}

@end
