//
//  UIViewController+CaptureView.m
//  NewsHD
//
//  Created by sgl on 12-10-18.
//  Copyright (c) 2012年 Sina. All rights reserved.
//

#import "UIViewController+CaptureView.h"
#import <QuartzCore/QuartzCore.h>
#import "UIImage+ImageScale.h"

@implementation UIViewController (CaptureView)

- (UIImage *)captureView:(CGSize)imageSize
{
    UIGraphicsBeginImageContext(self.view.bounds.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self.view.layer renderInContext:context];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return [image scaleToSize:imageSize];
}

@end
