//
//  UIViewController+Error.m
//  pocket
//
//  Created by sunguanglei on 14-9-5.
//  Copyright (c) 2014年 xdf. All rights reserved.
//

#import "UIViewController+Error.h"
#import <SVProgressHUD.h>

@implementation UIViewController (Error)

- (void)showError:(NSError *)error
{
    // TODO: 完善错误处理流程
    [SVProgressHUD showErrorWithStatus:@"请求出错"];
    NSLog(@"%@", error.localizedFailureReason);
}

- (void)showErrorOnMainThread:(NSError *)error
{
    __weak typeof(self) weakself = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        [weakself showError:error];
    });
}

@end
