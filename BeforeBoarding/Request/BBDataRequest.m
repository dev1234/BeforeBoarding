//
//  BBDataRequest.m
//  BeforeBoarding
//
//  Created by 王顺 on 16/3/7.
//  Copyright © 2016年 wangshun. All rights reserved.
//

#import "BBDataRequest.h"

@implementation BBDataRequest


- (id)init
{
    self = [super init];
    if (self) {
        self.type = WSDataRequestTypeGet;
        self.requestURL = @"http://10.77.80.20/api";
    }
    return self;
}


@end
