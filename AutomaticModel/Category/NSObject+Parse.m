//
//  AppDelegate.m
//  AutomaticModel
//
//  Created by 刘梓轩 on 2018/11/27.
//  Copyright © 2018年 刘梓轩. All rights reserved.
//

#import "NSObject+Parse.h"

@implementation NSObject (Parse)

+(id)parse:(id)JSON {
    if([JSON isKindOfClass:[NSArray class]]) {
        return [NSArray yy_modelArrayWithClass:[self class] json:JSON];
    }
    if([JSON isKindOfClass:[NSDictionary class]]) {
        return [self yy_modelWithJSON:JSON];
    }
    return JSON;
}

@end
