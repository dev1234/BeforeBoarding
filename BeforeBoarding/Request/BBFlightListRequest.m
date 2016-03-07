//
//  BBFlightListRequest.m
//  BeforeBoarding
//
//  Created by 白 云鹏 on 16/3/7.
//  Copyright © 2016年 wangshun. All rights reserved.
//

#import "BBFlightListRequest.h"

@implementation BBFlightListRequest

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.path = @"/FightList";
    }
    return self;
}


@end
