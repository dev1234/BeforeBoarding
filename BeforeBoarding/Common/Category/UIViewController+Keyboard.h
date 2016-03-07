//
//  UIViewController+Keyboard.h
//  vps
//
//  Created by sunguanglei on 14/12/8.
//  Copyright (c) 2014年 xdfucan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Keyboard)

@property (nonatomic, weak) UIView *targetView;
@property (nonatomic, strong) NSString *originCenter;
@property (nonatomic, assign) CGFloat bottomMargin;

- (void)addKeyboarObserverForView:(UIView *)view;
- (void)removeKeyboardObserverForView:(UIView *)view;

@end
