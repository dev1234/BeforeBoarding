//
//  BBTaskObject.h
//  BeforeBoarding
//
//  Created by 王顺 on 16/3/7.
//  Copyright © 2016年 wangshun. All rights reserved.
//

#import "BBObject.h"
#import "BBAirportObject.h"

@interface BBTaskObject : BBObject

@property (nonatomic , strong) NSString *depatureTime;
@property (nonatomic , strong) NSString *arrivalTime;
@property (nonatomic , strong) NSString *taskName;
@property (nonatomic , strong) BBAirportObject *departure;
@property (nonatomic , strong) BBAirportObject *arrival;

@end
