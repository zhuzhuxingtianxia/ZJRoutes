//
//  ZJRouteModel.m
//  Pods-ZJRoutes_Example
//
//  Created by ZZJ on 2018/8/31.
//

#import "ZJRouteModel.h"
@interface ZJRouteModel()
@property (nonatomic, strong) NSArray *patternComponents;
@end
@implementation ZJRouteModel

-(void)setPattern:(NSString *)pattern {
    _pattern = pattern;
    if ([pattern characterAtIndex:0] == '/') {
        pattern = [pattern substringFromIndex:1];
    }
    
    self.patternComponents = [pattern componentsSeparatedByString:@"/"];
}
- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@ %p> - %@", NSStringFromClass([self class]), self, self.pattern];
}
@end
