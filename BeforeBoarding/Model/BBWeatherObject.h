//
//  BBWeatherObject.h
//  BeforeBoarding
//
//  Created by 王顺 on 16/3/7.
//  Copyright © 2016年 wangshun. All rights reserved.
//

#import "BBObject.h"

@interface BBWeatherObject : BBObject

@property (nonatomic, strong) NSString *airportCode;
@property (nonatomic, strong) NSString *cloudHeight;
@property (nonatomic, strong) NSString *cloudType;
@property (nonatomic, strong) NSString *date;
@property (nonatomic, strong) NSString *time;
@property (nonatomic, strong) NSString *visibility;
@property (nonatomic, strong) NSString *weather;
@property (nonatomic, strong) NSString *windDirection;
@property (nonatomic, strong) NSString *windSpeed;
@property (nonatomic, strong) NSString *windSpeedUnit;


@end
