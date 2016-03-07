//
//  NSString+Additions.h
//  pocket
//
//  Created by sgl on 14-7-22.
//  Copyright (c) 2014年 xdf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Additions)

+ (NSString *)base64StringFromData: (NSData *)data length: (int)length;

- (NSArray *)componentsSeparatedToArray;

@end
