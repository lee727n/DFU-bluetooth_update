//
//  AppDelegate.m
//  AutomaticModel
//
//  Created by 刘梓轩 on 2018/11/27.
//  Copyright © 2018年 刘梓轩. All rights reserved.
//


#import "BaseNetManager.h"

@implementation BaseNetManager
+ (id)get:(NSString *)path completionHandler:(void (^)(id, NSError *))completionHandler{
    NSOperationQueue *queue = [NSOperationQueue currentQueue];
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithURL:path.yx_URL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        [queue addOperationWithBlock:^{
            if (error) {
                !completionHandler ?: completionHandler(nil, error);
            }else{
                NSError *err = nil;
                id obj = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableContainers|NSJSONReadingMutableLeaves|NSJSONReadingAllowFragments) error:&err];
                if (err) {
                   !completionHandler ?: completionHandler(nil, err);
                }else{
                   !completionHandler ?: completionHandler(obj, nil);
                }
            }
        }];
    }];
    [task resume];
    return task;
}
@end













