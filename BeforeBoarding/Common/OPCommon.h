//
//  OPCommon.h
//
//  Created by Sun Guanglei on 12-3-12.
//  Copyright (c) 2012年 Sina. All rights reserved.
//

#ifndef OPCommon_h
#define OPCommon_h

#ifdef DEBUG
    #define OPLog(xx, ...)          NSLog(@"(%s)(line=%d): " xx, __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
    #define OPLogMethodName()       NSLog(@"(%s)(line=%d): ", __PRETTY_FUNCTION__, __LINE__)
    #define OPSimpleLog(xx, ...)    NSLog(@xx, ##__VA_ARGS__)
#else
    #define OPLog(xx, ...)          ((void)0)
    #define OPLogMethodName()       ((void)0)
    #define OPSimpleLog(xx, ...)    ((void)0)
#endif

#define OPLogErr(xx, ...)      NSLog(@"[%s](line=%d)(%s): " xx, __FILE__, __LINE__, __PRETTY_FUNCTION__, ##__VA_ARGS__)


#define OPAsync(...) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{ __VA_ARGS__ })
#define OPAsyncMain(...) dispatch_async(dispatch_get_main_queue(), ^{ __VA_ARGS__ })

#define IsPortait(direction) (direction == UIInterfaceOrientationPortrait || direction == UIInterfaceOrientationPortraitUpsideDown)


#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

/******************************** Frame ******************************/
#define SCREEN_FRAME ([[UIScreen mainScreen] bounds])

#define SCREEN_WIDTH (([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) ? [[UIScreen mainScreen] bounds].size.width : 1024)

#define SCREEN_HEIGHT (([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) ? ([[UIScreen mainScreen] bounds].size.height) : 748)

#define SCREEN_WIDTH_IS_320 (SCREEN_WIDTH == 320.0 ? YES : NO)

#define DOCUMENT_DIRECTORY_PATH [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]

#define BUNDLE_IDENTIFIER [[NSBundle mainBundle] bundleIdentifier]
/********************************************************************/
#define APP_DELEGATE ((AppDelegate *)[[UIApplication sharedApplication] delegate])


#import "NSArray+Safe.h"
#import "NSDictionary+Safe.h"
#import "UIColor+Hex.h"
#import "NSString+Additions.h"

#endif
