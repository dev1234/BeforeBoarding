//
//  UIView+Selected.m
//  NewsHD
//
//  Created by sgl on 12-11-5.
//  Copyright (c) 2012年 Sina. All rights reserved.
//

#import "UIView+Selected.h"
#import <QuartzCore/QuartzCore.h>

@implementation UIView (Selected)

- (void)setViewSelected:(BOOL)selected
{
    if (selected) {
        UIColor *color = [UIColor colorWithRed:0.0 green:48.0 / 255.0 blue:121.0 / 255.0 alpha:1.0];
        self.layer.borderColor = color.CGColor;
        self.layer.borderWidth = 3.0;
    }
    else {
        self.layer.borderWidth = 0.0;
    }
}

@end
