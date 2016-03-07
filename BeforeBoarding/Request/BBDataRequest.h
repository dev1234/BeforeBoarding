//
//  BBDataRequest.h
//  BeforeBoarding
//
//  Created by 王顺 on 16/3/7.
//  Copyright © 2016年 wangshun. All rights reserved.
//

#import <WSDataRequest/WSDataRequest.h>

@interface BBDataRequest : WSDataRequest

+ (NSError *)errorWithReason:(NSString *)reason;

@end
