//
//  OPError.h
//  vps
//
//  Created by sgl on 14-6-22.
//  Copyright (c) 2014年 xdf. All rights reserved.
//

#ifndef vps_OPError_h
#define vps_OPError_h
#import <Foundation/Foundation.h>

extern NSString  *const OPErrorDomain;
extern const NSInteger OPErrorCodePasswordWrong;
extern const NSInteger OPErrorCodeUserNotExist;
extern const NSInteger OPErrorCodeNetWorkFaild;
extern const NSInteger OPErrorCodeTimeOut;

NSError * commonDataParseError();

#endif
