//
//  ZJRoutes.h
//  ZJRoutes
//
//  Created by ZZJ on 2018/8/28.
//

#import <Foundation/Foundation.h>
@interface NSString (ZJParam)
//把get请求的URL的参数转化成字典
- (NSDictionary *)ZJ_ParamDictionary;

@end

@interface NSDictionary (ZJParam)
//把字典转化成get请求的URL的参数
- (NSString *)ZJ_DecodedString;

@end

@interface ZJRoutes : NSObject

#pragma mark -

+ (instancetype)globalRoutes;

+ (instancetype)routesForScheme:(NSString *)scheme;

//取消注册的Scheme
+ (void)unregisterRouteScheme:(NSString *)scheme;
//取消所有的Scheme
+ (void)unregisterAllRouteSchemes;


#pragma mark -

//添加路由
- (void)addRoute:(NSString *)routePattern handler:(BOOL (^)(NSDictionary<NSString *, id> *parameters))handlerBlock;


- (void)removeRoute:(NSString *)routePattern;

- (void)removeAllRoutes;


#pragma mark -

+ (BOOL)canRouteURL:(NSURL *)URL;
- (BOOL)canRouteURL:(NSURL *)URL;


+ (BOOL)routeURL:(NSURL *)URL;
- (BOOL)routeURL:(NSURL *)URL;

@end
