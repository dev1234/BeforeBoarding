//
//  UIColor+Hex.m
//
//  Created by sgl on 13-7-26.
//  Copyright (c) 2013年 sgl. All rights reserved.
//

#import "UIColor+Hex.h"

@implementation UIColor (Hex)

+ (UIColor *)colorWithHex:(NSString *)hex alpha:(CGFloat)alpha
{
    NSAssert(7 == hex.length, @"Hex color format error!");
    
    unsigned color = 0;
    NSScanner *hexValueScanner = [NSScanner scannerWithString:[hex substringFromIndex:1]];
    [hexValueScanner scanHexInt:&color];
    
    int blue = color & 0xFF;
    int green = (color >> 8) & 0xFF;
    int red = (color >> 16) & 0xFF;
    
    return [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:alpha];
}

+ (UIColor *)colorWithHex:(NSString *)hex
{
    return [[self class] colorWithHex:hex alpha:1.0];
}

+ (UIColor *)colorWithRGB:(NSString *)rgb alpha:(CGFloat)alpha
{
    NSArray *components = [rgb componentsSeparatedByString:@","];
    NSAssert(3 == components.count, @"RGB(255,255,255) formamt error.");
    CGFloat red = [components[0] floatValue];
    CGFloat green = [components[0] floatValue];
    CGFloat blue = [components[0] floatValue];
    return [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:alpha];
}

+ (UIColor *)colorWithRGB:(NSString *)rgb
{
    return [UIColor colorWithRGB:rgb alpha:1.0];
}

@end
