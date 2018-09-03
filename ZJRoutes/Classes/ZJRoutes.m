//
//  ZJRoutes.m
//  ZJRoutes
//
//  Created by ZZJ on 2018/8/28.
//

#import "ZJRoutes.h"
#import "ZJRouteModel.h"

NSString *const ZJRoutesDefaultRoutesScheme = @"ZJRoutesDefaultRoutesScheme";

static NSMutableDictionary *routesMap = nil;

//get中url字符串参数转字典
@implementation NSString (ZJParam)

- (NSDictionary *)ZJ_ParamDictionary{
    NSRange range = [self rangeOfString:@"?"];
    NSString *getParam;
    if (range.location == NSNotFound) {
        getParam = self;
    }else{
        getParam = [self substringFromIndex:range.location+1];
    }
    
    NSMutableDictionary *result = [NSMutableDictionary dictionary];
    NSArray *array;
    if ([getParam rangeOfString:@"&"].location != NSNotFound) {
        array = [getParam componentsSeparatedByString:@"&"];
    }else{
        array = @[getParam];
    }
    
    for (NSString *obj in array) {
        NSArray *subArray = [obj componentsSeparatedByString:@"="];
        if (subArray.count>1) {
            [result setValue:subArray[1] forKey:subArray[0]];
        }else{
            [result setValue:@"" forKey:subArray[0]];
        }
    }
    
    return result;

}

@end

@implementation NSDictionary (ZJParam)
- (NSString *)ZJ_DecodedString{
    NSString *string = @"?";
    NSMutableArray *array = [NSMutableArray array];
    for (NSString *key in self.allKeys) {
        NSString *value = self[key];
        [array addObject:[NSString stringWithFormat:@"%@=%@",key,value]];
    }
    
    string = [string stringByAppendingString:[array componentsJoinedByString:@"&"]];
    
    if (string.length > 1) {
        return string;
    }
    return @"";
}

@end

@interface ZJRoutes ()

@property (nonatomic, strong) NSMutableArray *routes;
@property (nonatomic, strong) NSString *scheme;

@end
@implementation ZJRoutes

- (instancetype)init
{
    if ((self = [super init])) {
        self.routes = [NSMutableArray array];
    }
    return self;
}

- (NSString *)description
{
    return [self.routes description];
}

+ (NSString *)allRoutes
{
    NSMutableString *descriptionString = [NSMutableString stringWithString:@"\n"];
    
    for (NSString *routesNamespace in routesMap) {
        ZJRoutes *routesController = routesMap[routesNamespace];
        [descriptionString appendFormat:@"\"%@\":\n%@\n\n", routesController.scheme, routesController.routes];
    }
    
    return descriptionString;
}

#pragma mark - Routing Schemes

+ (instancetype)globalRoutes
{
    return [self routesForScheme:ZJRoutesDefaultRoutesScheme];
}

+ (instancetype)routesForScheme:(NSString *)scheme
{
    ZJRoutes *routesController = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        routesMap = [[NSMutableDictionary alloc] init];
    });
    
    if (!routesMap[scheme]) {
        routesController = [[self alloc] init];
        routesController.scheme = scheme;
        routesMap[scheme] = routesController;
    }
    
    routesController = routesMap[scheme];
    
    return routesController;
}

+ (void)unregisterRouteScheme:(NSString *)scheme
{
    [routesMap removeObjectForKey:scheme];
}

+ (void)unregisterAllRouteSchemes
{
    [routesMap removeAllObjects];
}

#pragma mark - Registering Routes

- (void)addRoute:(NSString *)routePattern handler:(BOOL (^)(NSDictionary<NSString *, id> *parameters))handlerBlock
{
    [self _registerRoute:routePattern handler:handlerBlock];
}

- (void)removeRoute:(NSString *)routePattern {
    
}

- (void)removeAllRoutes
{
    [self.routes removeAllObjects];
}

#pragma mark - Routing URLs
+ (BOOL)canRouteURL:(NSURL *)URL
{
    return [[self _routesControllerForURL:URL] canRouteURL:URL];
}

- (BOOL)canRouteURL:(NSURL *)URL
{
    return [self _routeURL:URL withParameters:nil];
}

+ (BOOL)routeURL:(NSURL *)URL
{
    return [[self _routesControllerForURL:URL] routeURL:URL];
}

- (BOOL)routeURL:(NSURL *)URL
{
    return [self _routeURL:URL withParameters:nil];
    
}

#pragma mark - Private

+ (instancetype)_routesControllerForURL:(NSURL *)URL
{
    if (URL == nil) {
        return nil;
    }
    
    return routesMap[URL.scheme] ?: [ZJRoutes globalRoutes];
}

- (void)_registerRoute:(NSString *)routePattern handler:(BOOL (^)(NSDictionary *parameters))handlerBlock {
    ZJRouteModel *routeModel = [ZJRouteModel new];
    routeModel.scheme = self.scheme;
    routeModel.pattern = routePattern;
    routeModel.handlerBlock = handlerBlock;
    
    [self.routes addObject:routeModel];
}

- (BOOL)_routeURL:(NSURL *)URL withParameters:(NSDictionary *)parameters {
    if (!URL) {
        return NO;
    }
    //URL路径
    NSString *urlPath = URL.path;
    if (urlPath.length > 0 && [urlPath characterAtIndex:0] == '/') {
        urlPath = [urlPath substringFromIndex:1];
    }
    NSMutableArray *pathComponents = [NSMutableArray arrayWithArray:[urlPath componentsSeparatedByString:@"/"]];
    if (URL.host) {
        [pathComponents insertObject:URL.host atIndex:0];
    }
    
    BOOL didRoute = NO;
    
    for (ZJRouteModel *routeModel in [self.routes copy]) {
        NSLog(@"%@",routeModel);
        //加上host
        
        if (pathComponents.count == routeModel.patternComponents.count) {
            
            NSMutableDictionary *routeParams = [NSMutableDictionary dictionary];
            
            for (NSInteger index = 0; index< routeModel.patternComponents.count; index++) {
                NSString *patternComponent = routeModel.patternComponents[index];
                NSString *URLComponent = nil;
                
                if (index < pathComponents.count) {
                    URLComponent = pathComponents[index];
                }
                
                if ([patternComponent hasPrefix:@":"]) {
                    NSString *varName = [self variableNameForValue:patternComponent];
                    
                    NSString *varValue = [self variableValueForValue:URLComponent];
                    if (varName&&varValue) {
                        routeParams[varName] = varValue;
                    }
                }
            }
            
            NSMutableDictionary *params = [NSMutableDictionary dictionary];
            [params addEntriesFromDictionary:[URL.query ZJ_ParamDictionary]];
            [params addEntriesFromDictionary:routeParams];
            
            if (routeModel.handlerBlock == nil) {
                return YES;
            }else{
                didRoute = routeModel.handlerBlock(params);
            }
            
            if (didRoute) {
                // if it was routed successfully, we're done
                break;
            }
        }
    }
    
    if (!didRoute && ![self _isGlobalRoutesController]) {
        didRoute = [[ZJRoutes globalRoutes] _routeURL:URL withParameters:parameters];
    }
    
    return didRoute;
}

- (BOOL)_isGlobalRoutesController
{
    return [self.scheme isEqualToString:ZJRoutesDefaultRoutesScheme];
}

- (NSString *)variableNameForValue:(NSString *)value
{
    NSString *name = [value substringFromIndex:1];
    
    if (name.length > 1 && [name characterAtIndex:0] == ':') {
        name = [name substringFromIndex:1];
    }
    
    if (name.length > 1 && [name characterAtIndex:name.length - 1] == '#') {
        name = [name substringToIndex:name.length - 1];
    }
    
    return name;
}
- (NSString *)variableValueForValue:(NSString *)value
{
    NSString *var = [value stringByRemovingPercentEncoding];
    
    if (var.length > 1 && [var characterAtIndex:var.length - 1] == '#') {
        var = [var substringToIndex:var.length - 1];
    }
    
    return var;
}

@end
