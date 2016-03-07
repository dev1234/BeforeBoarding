//
//  UIColor+Hex.h
//
//  Created by sgl on 13-7-26.
//  Copyright (c) 2013年 sgl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Hex)

/**
 *  Create color withe hex format
 *
 *  @param hex   hex format color eg.#333333
 *  @param alpha color alpha 0.0~1.0
 *
 *  @return UIColor
 */
+ (UIColor *)colorWithHex:(NSString *)hex alpha:(CGFloat)alpha;


/**
 *  Create color withe hex format
 *
 *  @param hex   hex format color eg.#333333
 *  @param alpha color alpha 0.0~1.0
 *
 *  @return UIColor
 */
+ (UIColor *)colorWithHex:(NSString *)hex;

/**
 *  Create color with RGB format
 *
 *  @param RGB   hex format color eg. 255.255.255
 *  @param alpha color alpha 0.0~1.0
 *
 *  @return UIColor
 */
+ (UIColor *)colorWithRGB:(NSString *)rgb alpha:(CGFloat)alpha;

/**
 *  Create color with RGB format
 *
 *  @param RGB   hex format color eg. 255.255.255
 *
 *  @return UIColor
 */
+ (UIColor *)colorWithRGB:(NSString *)rgb;

@end
