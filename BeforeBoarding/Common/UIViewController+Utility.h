//
//  UIViewController+Utility.h
//  teacherapp
//
//  Created by sunguanglei on 15/5/14.
//  Copyright (c) 2015年 xdf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MJRefresh/MJRefresh.h>
#import <UMengSocial/UMSocial.h>


@interface UIViewController (Utility)<UMSocialUIDelegate>

@property (atomic, assign) BOOL hudVisible;

- (UIViewController *)controllerFromClass:(Class)aClass;

- (void)showAlert:(NSString *)title message:(NSString *)message;
- (IBAction)backAction:(id)sender;
- (void)showError:(NSError *)error;
- (void)showErrorInHudWithError:(NSError *)error;
- (void)showErrorMessageInHud:(NSString *)error;
- (void)showProgressHud;
- (void)showProgressHudWithMessage:(NSString *)message;
- (void)dismissProgressHud;
- (void)setUpRefreshwithScrollView:(UIScrollView *)scrollView WithRefreshingBlock:(MJRefreshComponentRefreshingBlock)refreshingBlock;
- (void)tapToResignFirstResponse;
- (BOOL)isFieldEmpty:(UITextField *)field message:(NSString *)message;
- (void)changeBackItem;

- (void)initDataSource;
- (void)prepareDataSource;
- (void)reloadUI;
- (void)refreshUIWithNotification:(NSNotification *)sender;
- (void)refreshUI;

+ (UIImage *)imageForString:(NSString *)str size:(CGSize)size;

- (void)showSuccessWithMessage:(NSString *)message;
- (void)showInfoWithMessage:(NSString *)message;

//分享方法
- (UIImage *)imageFromView: (UIView *) view;
- (void)shareByImage:(UIImage *) image;
- (void)shareByUrl:(NSString *) url andtitle:(NSString *)title;

//初始化引导页面
- (void) initGuideView:(UIView *)view;
@end
