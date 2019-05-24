//
//  AppDelegate.m
//  AutomaticModel
//
//  Created by 刘梓轩 on 2018/11/27.
//  Copyright © 2018年 刘梓轩. All rights reserved.
//


#import <Foundation/Foundation.h>

@interface BaseNetManager : NSObject

+ (id)get:(NSString *)path completionHandler:(void(^)(id obj, NSError *error))completionHandler;

@end
























