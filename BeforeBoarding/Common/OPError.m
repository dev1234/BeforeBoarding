//
//  OPRunOnce.m
//  Run action only at current version first run.
//  It is very easy to use.
//  Just Call runOnce:action, specify the only key to
//  the action and target.
//

#import "OPError.h"

NSString *const OPErrorDomain = @"wangshun.com";

const NSInteger OPErrorCodePasswordWrong = 1001;
const NSInteger OPErrorCodeUserNotExist  = 1002;
const NSInteger OPErrorCodeDataParse     = 1003;
const NSInteger OPErrorCodeTimeOut       = -1001;
const NSInteger OPErrorCodeNetWorkFaild  = -1009;



NSError * commonDataParseError()
{
    return [NSError errorWithDomain:OPErrorDomain code:OPErrorCodeDataParse userInfo:@{NSLocalizedDescriptionKey: @"解析数据错误", NSLocalizedFailureReasonErrorKey: @"解析数据错误" }];
}
