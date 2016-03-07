//
//  BBUserRequest.m
//  BeforeBoarding
//
//  Created by 王顺 on 16/3/7.
//  Copyright © 2016年 wangshun. All rights reserved.
//

#import "BBUserRequest.h"
#import "BBUserObject.h"

@implementation BBUserRequest

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.path = @"/User";
    }
    return self;
}

- (id)responseParse:(id)data {
    BBUserObject *user = nil;
    if ([data[@"status"] integerValue] == 1) {
        user = [BBUserObject yy_modelWithJSON:data];
        return user;
    }else {
        NSError *err = [BBDataRequest errorWithReason:data[@"message"]];
        return err;
    }

}

@end
