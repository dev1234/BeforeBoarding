//
//  BBSession.h
//  BeforeBoarding
//
//  Created by 王顺 on 16/3/7.
//  Copyright © 2016年 wangshun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BBUserObject.h"

typedef enum : NSUInteger {
    BBUserStatusDefault = 0,    // 默认值
    BBUserStatusNewVersion,     //  新版本
    BBUserStatusAutoConnecting,     // 登录中
    BBUserStatusSignIn,         // 已登录
    BBUserStatusAutoSignInError,    // 自动登录出错
    BBUserStatusSignOut,        // 已登出
} OPUserStatus;

@interface BBSession : NSObject

@property (nonatomic, strong, readonly) BBUserObject *user;
@property (nonatomic, assign) BOOL userLogined;
@property (nonatomic, assign, readonly) OPUserStatus userStatus;
@property (nonatomic, strong) NSString *preUsername;



+ (instancetype)session;

- (void)signIn:(NSString *)username pwd:(NSString *)pwd result:(void(^)(NSError *error))result;
- (void)signUp:(BBUserObject *)user result:(void(^)(NSError *error))result;
- (void)autoSignIn:(void(^)(NSError *error))result;
- (void)endIntro;
- (BOOL)canAutoSignIn;
- (void)signOut;
- (BOOL)isSignIn;

- (void)setPushInfo:(NSDictionary *)pushInfo launch:(BOOL)launch;
- (void)requstTeacherIntro;
@end
