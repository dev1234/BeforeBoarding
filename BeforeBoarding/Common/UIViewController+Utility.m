//
//  UIViewController+Utility.m
//  teacherapp
//
//  Created by sunguanglei on 15/5/14.
//  Copyright (c) 2015年 xdf. All rights reserved.
//

#import "UIViewController+Utility.h"
#import <objc/message.h>
#import <SVProgressHUD.h>
#import "OPStyleFactory.h"
#import "GlobalPrefix.h"


static void *HudVisibleKey = &HudVisibleKey;
@implementation UIViewController (Utility)

- (BOOL)hudVisible
{
    id hudVisible = objc_getAssociatedObject(self, HudVisibleKey);
    if (hudVisible) {
        return [hudVisible boolValue];
    }
    return NO;
}

- (void)setHudVisible:(BOOL)hudVisible
{
    objc_setAssociatedObject(self, HudVisibleKey, @(hudVisible), OBJC_ASSOCIATION_RETAIN);
}

- (UIViewController *)controllerFromClass:(Class)aClass
{
    NSString *identifier = NSStringFromClass(aClass);
    return [self.storyboard instantiateViewControllerWithIdentifier:identifier];
}

- (void)showAlert:(NSString *)title message:(NSString *)message
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
}

- (void)showError:(NSError *)error
{
    if (error.localizedDescription) {
        [self showAlert:@"错误" message:error.localizedDescription];
    }
    else {
        [self showAlert:@"错误" message:error.localizedFailureReason];
    }
}

- (void)showErrorInHudWithError:(NSError *)error {
    // TODO: 专门处理网络错误
    NSLog(@"%@", error.localizedDescription);
    if ([error.domain isEqualToString:NSURLErrorDomain]) {
        if (error.code == OPErrorCodeNetWorkFaild) {
            [SVProgressHUD showErrorWithStatus:@"网络连接失败，检查您的网络" maskType:SVProgressHUDMaskTypeBlack];
        }
        if (error.code == OPErrorCodeTimeOut) {
            [SVProgressHUD showErrorWithStatus:@"请求超时，请您稍后再试" maskType:SVProgressHUDMaskTypeBlack];
        }        return;
    }
    if ([error.domain isEqualToString:OPErrorDomain]) {
        if (error.localizedDescription) {
            [SVProgressHUD showErrorWithStatus:error.localizedDescription maskType:SVProgressHUDMaskTypeBlack];
        }
        else {
            [SVProgressHUD showErrorWithStatus:error.localizedFailureReason maskType:SVProgressHUDMaskTypeBlack];
        }
        return;
    }
    
    [SVProgressHUD showErrorWithStatus:@"bad network!" maskType:SVProgressHUDMaskTypeBlack];
}

- (void)showErrorMessageInHud:(NSString *)error {
    [SVProgressHUD showErrorWithStatus:error maskType:SVProgressHUDMaskTypeBlack];
}

- (void)showSuccessWithMessage:(NSString *)message {
    [SVProgressHUD showSuccessWithStatus:message maskType:SVProgressHUDMaskTypeBlack];
}

- (void)showInfoWithMessage:(NSString *)message {
    [SVProgressHUD showInfoWithStatus:message maskType:SVProgressHUDMaskTypeBlack];
}

- (void)showProgressHud
{
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    self.hudVisible = YES;
}

- (void)showProgressHudWithMessage:(NSString *)message {
    [SVProgressHUD showWithStatus:message maskType:SVProgressHUDMaskTypeBlack];
    self.hudVisible = YES;
}

- (void)dismissProgressHud
{
    [SVProgressHUD dismiss];
    self.hudVisible = NO;
}

- (void)tapToResignFirstResponse
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    [self.view addGestureRecognizer:tap];
}

- (void)handleTap:(UITapGestureRecognizer *)tap
{
    if (tap.state == UIGestureRecognizerStateEnded) {
        [self.view endEditing:YES];
    }
}

- (BOOL)isFieldEmpty:(UITextField *)field message:(NSString *)message
{
    if (field.text.length == 0) {
        [self showAlert:nil message:message];
        return YES;
    }
    return NO;
}

- (void)changeBackItem
{
    if (self.navigationController
        && [self.navigationController.viewControllers count] > 1) {
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btn_back"] style:UIBarButtonItemStylePlain target:self action:@selector(backAction:)];
        self.navigationItem.leftBarButtonItem = backItem;
    }
    
}

- (void)setUpRefreshwithScrollView:(UIScrollView *)scrollView WithRefreshingBlock:(MJRefreshComponentRefreshingBlock)refreshingBlock {
    // 下拉刷新
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:refreshingBlock];
    
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    header.automaticallyChangeAlpha = YES;
    
    // 隐藏时间
    header.lastUpdatedTimeLabel.hidden = YES;
    
    // 隐藏状态
    header.stateLabel.hidden = YES;
    scrollView.mj_header = header;
}

- (IBAction)backAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)initDataSource {
    
}

- (void)prepareDataSource {
    
}

- (void)reloadUI {
    
}

- (void)refreshUIWithNotification:(NSNotification *)sender {
    [self refreshUI];
}

- (void)refreshUI {
    [self prepareDataSource];
    [self reloadUI];
}


+ (UIImage *)imageForString:(NSString *)str size:(CGSize)size {
    UIGraphicsBeginImageContext(size);
    CGContextRef content = UIGraphicsGetCurrentContext();
    CGFloat margin = roundf(size.height * 0.04);
    CGContextSetFillColorWithColor(content, [OPStyleFactory green38].CGColor);
    CGContextFillRect(content, CGRectMake(0.0, 0.0, size.width, size.height));
    //  画边框
//    CGContextAddArc(content, size.width / 2.0, size.height / 2.0, MIN(size.width, size.height)/2.0, 0, 2 * M_PI, 0);
//    [[UIColor redColor] setStroke];
    CGContextDrawPath(content, kCGPathStroke);
    CGFloat fontSize = roundf((MIN(size.width, size.height) * .45));
    UIFont *font = [UIFont systemFontOfSize:fontSize];
    NSAttributedString *s = [[NSAttributedString alloc] initWithString:str attributes:@{NSFontAttributeName:font, NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    CGRect frame = [s boundingRectWithSize:CGSizeMake(20.0, 20.0) options:0 context:nil];
    
    [s drawInRect:CGRectMake((size.width - margin * 2 - frame.size.width) / 2.0 + margin, (size.height - margin * 2 - frame.size.height) / 2.0 + margin, frame.size.width, frame.size.height)];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (UIImage *)imageFromView: (UIView *) view
{
    
    UIGraphicsBeginImageContextWithOptions(view.frame.size, YES, 0.0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [view.layer renderInContext:context];
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

- (void)shareByImage:(UIImage *) image
{

}

- (void) initGuideView:(UIView *)view
{
    
//    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    UIView *theView = self.navigationController.view;
    [view removeFromSuperview];
    [theView addSubview:view];
    NSLayoutConstraint *width = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:theView.bounds.size.width];
    [view addConstraint:width];
    NSLayoutConstraint *height = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:theView.bounds.size.height];
    [view addConstraint:height];
    [theView addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:theView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0]];
    [theView addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:theView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.0]];
    view.hidden = NO;
}
 @end
