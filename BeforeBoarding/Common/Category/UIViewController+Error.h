//
//  UIViewController+Error.h
//  pocket
//
//  Created by sunguanglei on 14-9-5.
//  Copyright (c) 2014年 xdf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Error)

- (void)showError:(NSError *)error;
- (void)showErrorOnMainThread:(NSError *)error;

@end
