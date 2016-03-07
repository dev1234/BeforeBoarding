//
//  OPStyleFactory.m
//  teacherapp
//
//  Created by sunguanglei on 15/4/28.
//  Copyright (c) 2015年 sunix. All rights reserved.
//

#import "OPStyleFactory.h"
#import "UIColor+Hex.h"

@implementation OPStyleFactory

+ (void)applyStyle
{
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setBarTintColor:[OPStyleFactory blue]];
    [[UINavigationBar appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                          [UIColor whiteColor], NSForegroundColorAttributeName,
                                                          [UIFont boldSystemFontOfSize:18.0],
                                                          NSFontAttributeName,
                                                          nil]];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSFontAttributeName : [UIFont fontWithName:@"HelveticaNeue-Bold" size:10.0f],
                                                        NSForegroundColorAttributeName : [OPStyleFactory green]
                                                        } forState:UIControlStateSelected];
}

+ (UIColor *)black {
    return [UIColor colorWithHex:@"#111111" alpha:0.3];
}

+ (UIColor *)red
{
    return [UIColor colorWithHex:@"#FF4848"];
}

+ (UIColor *)green
{
    return [UIColor colorWithHex:@"#28c51e"];
}

+ (UIColor *)yellow {
    return [UIColor colorWithHex:@"#ffcf48"];
}

+ (UIColor *)blue {
    return [UIColor colorWithHex:@"#08a9e5"];
}

+ (UIColor *)grayE9
{
    return [UIColor colorWithHex:@"#e9e9e9"];
}

+ (UIColor *)grayD7
{
    return [UIColor colorWithHex:@"#d7d7d7"];
}

+ (UIColor *)gray7D
{
    return [UIColor colorWithHex:@"#7d7d7d"];
}

+ (UIColor *)grayF5
{
    return [UIColor colorWithHex:@"#f5f5f5"];
}

+ (UIColor *)gray53 {
    return [UIColor colorWithHex:@"#535353"];
}

+ (UIColor *)grayCB {
    return [UIColor colorWithHex:@"#cbcbcb"];
}

+ (UIColor *)grayA3 {
    return [UIColor colorWithHex:@"#a3a3a3"];
}


+ (UIColor *)lightGreen
{
    return [UIColor colorWithHex:@"#daf4ef"];
}

+ (UIColor *)grayA9
{
    return [UIColor colorWithHex:@"#a9a9a9"];
}



+ (UIColor *)grayEE
{
    return [UIColor colorWithHex:@"#eeeeee"];
}

+ (UIColor *)gray37 {
    return [UIColor colorWithHex:@"#373737"];
}

+ (UIColor *)lightBlue {
    return [UIColor colorWithHex:@"#01a5ff"];
}

+ (UIColor *)orange {
    return [UIColor colorWithHex:@"#ffae37"];
}

//tableview section 文字颜色
+ (UIColor *)green38 {
    return [UIColor colorWithHex:@"#09B394"];
}

//tablevie sectionView 背景颜色值
+ (UIColor *)green39 {
    return [UIColor colorWithHex:@"#DAF4EF"];
}

@end
