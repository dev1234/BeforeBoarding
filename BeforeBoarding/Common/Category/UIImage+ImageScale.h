//
//  UIImage+ImageScale.h
//  SinaEntertainment
//
//  Created by Sun Guanglei on 12-8-7.
//  Copyright (c) 2012年 SwordsMobile. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ImageScale)

- (UIImage *)subImage:(CGRect)rect;
- (UIImage *)scaleToSize:(CGSize)imgSize;
- (UIImage *)addSpaceToSize:(CGSize)imgSize;
- (UIImage *)addSpaceToSize:(CGSize)imgSize backgroundColor:(UIColor *)color;

@end