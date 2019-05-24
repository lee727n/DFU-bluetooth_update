//
//  AppDelegate.m
//  AutomaticModel
//
//  Created by 刘梓轩 on 2018/11/27.
//  Copyright © 2018年 刘梓轩. All rights reserved.
//

#import "BaseNetManager.h"
#import "ESRootClass.h"
#import "MJRootClass.h"


@interface NetManager : BaseNetManager
+ (id)getTopNews:(NSInteger)page completionHandler:(void(^)(MJRootClass *model, NSError *error))completionHandler;

@end













