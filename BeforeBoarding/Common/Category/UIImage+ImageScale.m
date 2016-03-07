//
//  UIImage+ImageScale.m
//  SinaEntertainment
//
//  Created by Sun Guanglei on 12-8-7.
//  Copyright (c) 2012年 SwordsMobile. All rights reserved.
//

#import "UIImage+ImageScale.h"

@implementation UIImage (ImageScale)

- (UIImage *)subImage:(CGRect)rect;
{
    CGImageRef subImageRef = CGImageCreateWithImageInRect(self.CGImage, rect);  
    CGRect smallBounds = CGRectMake(0, 0, CGImageGetWidth(subImageRef), CGImageGetHeight(subImageRef));  
    
    UIGraphicsBeginImageContext(smallBounds.size);  
    CGContextRef context = UIGraphicsGetCurrentContext();  
    CGContextDrawImage(context, smallBounds, subImageRef);  
    UIImage* smallImage = [UIImage imageWithCGImage:subImageRef];
    CFRelease(subImageRef);
    UIGraphicsEndImageContext();  
    
    return smallImage;  
}

- (UIImage *)scaleToSize:(CGSize)imgSize
{
    if (self.size.height <= imgSize.height || self.size.width <= imgSize.width) {
        return self;
    }
    UIGraphicsBeginImageContext(imgSize);
    [self drawInRect:CGRectMake(0.0, 0.0, imgSize.width, imgSize.height)];
    UIImage *imageCopy = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return imageCopy;
}

- (UIImage *)addSpaceToSize:(CGSize)imgSize
{
    return [self addSpaceToSize:imgSize backgroundColor:[UIColor whiteColor]];
}

- (UIImage *)addSpaceToSize:(CGSize)imgSize backgroundColor:(UIColor *)color
{
    CGSize srcSize = self.size;
    if (srcSize.width > imgSize.width || srcSize.height > imgSize.height) {
        return self;
    }
    CGFloat x = (imgSize.width - srcSize.width) / 2.0;
    CGFloat y = (imgSize.height - srcSize.height) / 2.0;
    UIGraphicsBeginImageContext(imgSize);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, CGRectMake(0, 0, imgSize.width, imgSize.height));
    [self drawInRect:CGRectMake(x, y, srcSize.width, srcSize.height)];
    UIImage *imageCopy = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return imageCopy;
}

@end
