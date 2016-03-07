//
//  BBWeatherRequest.m
//  BeforeBoarding
//
//  Created by 王顺 on 16/3/7.
//  Copyright © 2016年 wangshun. All rights reserved.
//

#import "BBWeatherRequest.h"
#import "BBWeatherObject.h"

@implementation BBWeatherRequest

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.path = @"/Weather";
    }
    return self;
}

- (id)responseParse:(id)data {
    if ([data[@"status"] integerValue] == 1) {
        BBWeatherObject *weather = [BBWeatherObject yy_modelWithJSON:data[@"item"]];
        return weather;
    }else {
        NSError *err = [BBDataRequest errorWithReason:data[@"message"]];
        return err;
    }
    return nil;
}

@end
