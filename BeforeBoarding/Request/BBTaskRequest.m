//
//  BBTaskRequest.m
//  BeforeBoarding
//
//  Created by 王顺 on 16/3/7.
//  Copyright © 2016年 wangshun. All rights reserved.
//

#import "BBTaskRequest.h"

@implementation BBTaskRequest
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.path = @"/Task";
    }
    return self;
}

- (id)responseParse:(id)data {
    return nil;
    
}

@end
