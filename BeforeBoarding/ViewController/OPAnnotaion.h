//
//  OPAnnotaion.h
//  teacherapp
//
//  Created by coder_H on 15/5/12.
//  Copyright (c) 2015年 xdf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface OPAnnotaion : NSObject <MKAnnotation>

@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;

@end
