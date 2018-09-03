//
//  ZJRouteModel.h
//  Pods-ZJRoutes_Example
//
//  Created by ZZJ on 2018/8/31.
//

#import <Foundation/Foundation.h>

@interface ZJRouteModel : NSObject
@property (nonatomic, strong) NSString *scheme;
@property (nonatomic, strong) NSString *pattern;
@property (nonatomic, strong) BOOL (^handlerBlock)(NSDictionary *parameters);

@property (nonatomic, strong, readonly) NSArray *patternComponents;

@end
