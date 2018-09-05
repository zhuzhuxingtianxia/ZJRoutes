//
//  UIViewController+ZJMediator.h
//  Pods-ZJRoutes_Example
//
//  Created by ZZJ on 2018/9/4.
//

#import <UIKit/UIKit.h>
/**
 * Router 的 跳转方式
 */
typedef NS_ENUM(NSUInteger, ZJRouteStyle) {
    ZJRoute_Push,  //有动画
    ZJRoute_PushNo, //无动画
    ZJRoute_Pop,
    ZJRoute_Present,
    ZJRoute_PresentNo,
    ZJRoute_Dismiss,
    ZJRoute_Tab,
    ZJRoute_Special,
};

@interface UIViewController (ZJMediator)

/**
 默认跳转类型ZJRoute_Push

 */
-(UIViewController*)routeTargetController:(NSString*)aClass withParams:(NSDictionary *)dict;

/**
 用于跳转

 @param aClass 一个Controller类的字符串名称
 @param dict 参数：对应Target控制器的属性
 @param routeStyle 跳转方式
 @return aClass的控制器的实例
 */
-(UIViewController*)routeTargetController:(NSString*)aClass withParams:(NSDictionary *)dict byRouteStyle:(ZJRouteStyle)routeStyle;

/*
 Storyboard中identifier为对应的类名称时
 或identifier不为类名但在Main.storyboard中
 
 @param identifier Storyboard中Controller对应的唯一标示
 */
-(UIViewController*)routeTargetIdentifier:(NSString*)identifier withParams:(NSDictionary *)dict byRouteStyle:(ZJRouteStyle)routeStyle;

/*
 Storyboard中identifier不为对应的类名称时
 
 @param identifier Storyboard中Controller对应的标示
 @param storyboard 所在的Storyboard的名称
 */
-(UIViewController*)routeTargetIdentifier:(NSString*)identifier inStoryboard:(NSString*)storyboard withParams:(NSDictionary *)dict byRouteStyle:(ZJRouteStyle)routeStyle;

@end
