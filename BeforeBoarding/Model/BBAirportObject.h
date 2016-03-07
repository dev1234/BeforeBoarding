//
//  BBAirportObject.h
//  BeforeBoarding
//
//  Created by 王顺 on 16/3/7.
//  Copyright © 2016年 wangshun. All rights reserved.
//

#import "BBObject.h"

@interface BBAirportObject : BBObject

@property (nonatomic , strong) NSString *airportName;
@property (nonatomic , strong) NSString *ID;
@property (nonatomic , strong) NSString *latitude;
@property (nonatomic , strong) NSString *longitude;

@end
