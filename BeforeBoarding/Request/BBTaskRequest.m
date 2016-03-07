//
//  BBTaskRequest.m
//  BeforeBoarding
//
//  Created by 王顺 on 16/3/7.
//  Copyright © 2016年 wangshun. All rights reserved.
//

#import "BBTaskRequest.h"
#import "BBTaskObject.h"

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
    if ([data[@"status"] integerValue] == 1) {
        NSMutableArray *tasks = [NSMutableArray new];
        for (NSDictionary *dict in data[@"items"]) {
            BBTaskObject *task = [BBTaskObject yy_modelWithJSON:dict];
            [tasks addObject:task];
        }
        return tasks;
    }else {
        NSError *err = [BBDataRequest errorWithReason:data[@"message"]];
        return err;
    }
    return nil;
    
}

@end
