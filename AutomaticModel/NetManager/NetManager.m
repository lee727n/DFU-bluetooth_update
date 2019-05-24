//
//  AppDelegate.m
//  AutomaticModel
//
//  Created by 刘梓轩 on 2018/11/27.
//  Copyright © 2018年 刘梓轩. All rights reserved.
//


#import "NetManager.h"


@implementation NetManager
+ (id)getTopNews:(NSInteger)page completionHandler:(void (^)(MJRootClass *, NSError *))completionHandler{
    NSString *path = [NSString stringWithFormat:@"http://box.dwstatic.com/apiNewsList.php?action=l&newsTag=headlineNews&p=%ld&v=202&OSType=iOS10.0.1&versionName=3.4.0", page];
    return [self get:path completionHandler:^(id obj, NSError *error) {
        NSLog(@"%@",obj);
        //使用YYModel自动化解析，需要区分数组，字典，写一个parse的分类
        //!completionHandler ?: completionHandler([ESRootClass parse:obj], error);
        //MJextension 通过Pod配置 对于首层是数组的情况 也可以仿照上面写一个parse类。基本用不上后台返回数据首层肯定是字典
        !completionHandler ?: completionHandler([MJRootClass mj_objectWithKeyValues:obj], error);
    }];
}
@end











