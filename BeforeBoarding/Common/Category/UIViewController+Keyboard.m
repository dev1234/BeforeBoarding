//
//  UIViewController+Keyboard.m
//  vps
//
//  Created by sunguanglei on 14/12/8.
//  Copyright (c) 2014年 xdfucan. All rights reserved.
//

#import "UIViewController+Keyboard.h"
#import <objc/runtime.h>

#define kOPKeyboardAssociatedClassKeyTargetView @"kOPKeyboardAssociatedClassKeyTargetView"
#define kOPKeyboardAssociatedClassKeyOriginCenter @"kOPKeyboardAssociatedClassKeyOriginCenter"
#define kOPKeyboardAssociatedClassKeyBottomMargin @"kOPKeyboardAssociatedClassKeyBottomMargin"

@implementation UIViewController (Keyboard)

@dynamic targetView;
@dynamic originCenter;
@dynamic bottomMargin;

- (void)setTargetView:(UIView *)targetView
{
    objc_setAssociatedObject(self, kOPKeyboardAssociatedClassKeyTargetView, targetView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *) targetView
{
    return objc_getAssociatedObject(self, kOPKeyboardAssociatedClassKeyTargetView);
}

- (void)setOriginCenter:(NSString *)originCenter
{
    objc_setAssociatedObject(self, kOPKeyboardAssociatedClassKeyOriginCenter, originCenter, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)originCenter
{
    return objc_getAssociatedObject(self, kOPKeyboardAssociatedClassKeyOriginCenter);
}

- (void)setBottomMargin:(CGFloat)offset
{
    objc_setAssociatedObject(self, kOPKeyboardAssociatedClassKeyBottomMargin, @(offset), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)bottomMargin
{
    id o = objc_getAssociatedObject(self, kOPKeyboardAssociatedClassKeyBottomMargin);
    return [o floatValue];
}

- (void)addKeyboarObserverForView:(UIView *)view
{
    if (self.bottomMargin < 10.0) {
        self.bottomMargin = 10.0;
    }
    self.targetView = view;
    self.originCenter = NSStringFromCGPoint(self.targetView.center);
    [self setupKeyboardNotification];
}

- (void)removeKeyboardObserverForView:(UIView *)view
{
    self.targetView = nil;
    [self removeKeyboardNotification];
}

- (id)findFirstResponder
{
    if ([self.targetView isFirstResponder]) {
        return self.targetView;
    }
    for (UIView *subView in self.targetView.subviews) {
        if ([subView isFirstResponder]) {
            return subView;
        }
    }
    return nil;
}

- (IBAction)tapAction:(id)sender
{
    [self.targetView endEditing:YES];
}

- (void)setupKeyboardNotification
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    
    [self.view addGestureRecognizer:tap];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidShow:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidHide:)
                                                 name:UIKeyboardDidHideNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardFrameChanged:)
                                                 name:UIKeyboardDidChangeFrameNotification
                                               object:nil];
}

- (void)removeKeyboardNotification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardDidShowNotification
                                                  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardDidHideNotification
                                                  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardDidChangeFrameNotification
                                                  object:nil];
}

- (void)enableKeyBoardNotification:(BOOL)enable
{
    if (enable) {
        [self setupKeyboardNotification];
    }
    else {
        [self removeKeyboardNotification];
    }
}

- (void)keyboardWillShow:(NSNotification*)notification
{
    /*
     NSString *const UIKeyboardFrameBeginUserInfoKey;
     NSString *const UIKeyboardFrameEndUserInfoKey;
     NSString *const UIKeyboardAnimationDurationUserInfoKey;
     NSString *const UIKeyboardAnimationCurveUserInfoKey;
     */
    
    CGRect keyboardFrame = [[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGRect keyboardStartFrame = [[notification.userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    
    if (keyboardStartFrame.origin.y != [UIScreen mainScreen].bounds.size.height) {
        return;
    }
    double duration = [[notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    UIViewAnimationOptions curve = [[notification.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] unsignedIntegerValue];
    
    UIView *v = [self findFirstResponder];
    CGPoint center = v.center;//[v convertPoint:v.center toView:self.targetView];
    
    CGFloat delta = self.bottomMargin;
    if (center.y + v.frame.size.height / 2.0 + delta < keyboardFrame.origin.y) {
        return;
    }
    
    CGFloat offset = center.y + v.frame.size.height / 2.0 + delta - keyboardFrame.origin.y;
    
    CGPoint originCenter = CGPointFromString(self.originCenter);
    CGPoint destCenter = CGPointMake(originCenter.x, originCenter.y - offset);
    
    [UIView animateWithDuration:duration delay:0.0 options:curve animations:^{
        self.targetView.center = destCenter;
    } completion:^(BOOL finished) {
        if (finished) {

        }
    }];
}

- (void)keyboardWillHide:(NSNotification*)notification
{
    CGPoint center = CGPointFromString(self.originCenter);
    double duration = [[notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    UIViewAnimationOptions curve = [[notification.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] unsignedIntegerValue];
    [UIView animateWithDuration:duration delay:0.0 options:curve animations:^{
        self.targetView.center = center;
    } completion:^(BOOL finished) {
        if (finished) {
            
        }
    }];
}

- (void)keyboardDidShow:(NSNotification*)notification
{
    
}

- (void)keyboardDidHide:(NSNotification*)notification
{
    
}

- (void)keyboardFrameChanged:(NSNotification*)notification
{
    CGRect keyboardFrame = [[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    CGRect keyboardStartFrame = [[notification.userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    
    if (keyboardStartFrame.origin.y == [UIScreen mainScreen].bounds.size.height
        || keyboardFrame.origin.y == [UIScreen mainScreen].bounds.size.height) {
        return;
    }
    
    
    double duration = [[notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    UIViewAnimationOptions curve = [[notification.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] unsignedIntegerValue];
    
    CGFloat offset = keyboardStartFrame.origin.y - keyboardFrame.origin.y;
    
    CGPoint currentCenter = self.targetView.center;
    CGPoint destCenter = CGPointMake(currentCenter.x, currentCenter.y - offset);
    
    [UIView animateWithDuration:duration delay:0.0 options:curve animations:^{
        self.targetView.center = destCenter;
    } completion:^(BOOL finished) {
        if (finished) {
            //
        }
    }];
}

@end
