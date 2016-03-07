//
//  BBDataRequest.m
//  BeforeBoarding
//
//  Created by 王顺 on 16/3/7.
//  Copyright © 2016年 wangshun. All rights reserved.
//

#import "BBDataRequest.h"
#import "GlobalPrefix.h"

@implementation BBDataRequest


- (id)init
{
    self = [super init];
    if (self) {
        self.type = WSDataRequestTypeGet;
//        self.requestURL = @"http://10.77.80.20/api";
        self.requestURL = @"http://172.20.10.5/api";

    }
    return self;
}

+ (NSError *)errorWithReason:(NSString *)reason {
    if (reason.length == 0) {
        reason = @"未知错误";
    }
    NSInteger code = 0;
    if ([reason isEqualToString:@"账号或密码错误"]) {
        code = OPErrorCodePasswordWrong;
    }
    return [NSError errorWithDomain:OPErrorDomain code:code userInfo:@{NSLocalizedFailureReasonErrorKey: reason, NSLocalizedDescriptionKey: reason}];
}


@end
