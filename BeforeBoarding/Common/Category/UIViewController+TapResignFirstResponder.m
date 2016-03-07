//
//  UIViewController+TapResignFirstResponder.m
//  pocket
//
//  Created by sunguanglei on 14/10/27.
//  Copyright (c) 2014年 xdf. All rights reserved.
//

#import "UIViewController+TapResignFirstResponder.h"

@implementation UIViewController (TapResignFirstResponder)

- (void)addTapGesture
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    [self.view addGestureRecognizer:tap];
}

- (void)handleTap:(UITapGestureRecognizer *)sender
{
    if (sender.state == UIGestureRecognizerStateEnded)
    {
        // handling code
        [self.view endEditing:YES];
    }
}

@end
