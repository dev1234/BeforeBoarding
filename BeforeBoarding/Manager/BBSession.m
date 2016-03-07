//
//  BBSession.m
//  BeforeBoarding
//
//  Created by 王顺 on 16/3/7.
//  Copyright © 2016年 wangshun. All rights reserved.
//
#import "BBSession.h"
#import "OPKVDatabase.h"
#import "OPRunOnce.h"
#import <SSKeychain/SSKeychain.h>
#import "BBUserRequest.h"

#define kOPXDFAppKeyChian           @"cn.xdf.teacherapp.uixdfaajfzhugdfajmhj"
#define kOPXDFUsername              @"OPUserName"


@interface BBSession ()

@property (nonatomic, strong) NSString *username;

@end

@implementation BBSession

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.username = [[OPKVDatabase defaultDatabase] loadStringForKey:kOPXDFUsername defaultValue:nil];
        self.preUsername = self.username;
        self.userLogined = NO;
        _userStatus = BBUserStatusDefault;
    }
    return self;
}

+ (instancetype)session
{
    static id _session = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _session = [[BBSession alloc] init];
    });
    
    return _session;
}

- (NSString *)loadPasswdForAccount:(NSString *)account
{
    return [SSKeychain passwordForService:kOPXDFAppKeyChian account:account];
}

- (void)saveUsername:(NSString *)username
{
    self.preUsername = username;
    [[OPKVDatabase defaultDatabase] saveString:username forKey:kOPXDFUsername];
}

- (BOOL)savePasswd:(NSString *)passwd account:(NSString *)account
{
    if (account.length == 0
        || passwd.length == 0) {
        return NO;
    }
    return [SSKeychain setPassword:passwd forService:kOPXDFAppKeyChian account:account];
}

- (BOOL)deletePasswdForAccount:(NSString *)account
{
    if (account.length == 0) {
        return NO;
    }
    return [SSKeychain deletePasswordForService:kOPXDFAppKeyChian account:account];
}

- (void)updateStatus:(OPUserStatus)status
{
    [self willChangeValueForKey:@"userStatus"];
    _userStatus = status;
    [self didChangeValueForKey:@"userStatus"];
}

- (void)autoSignIn:(void(^)(NSError *error))result
{
    if (self.username) {
        NSString *pwd = [self loadPasswdForAccount:self.username];
        if (pwd) {
            __weak typeof(self) weakself = self;
            [self updateStatus:BBUserStatusAutoConnecting];
            [self signIn:self.username pwd:pwd result:^(NSError *error) {
                if (error) {
                    [weakself updateStatus:BBUserStatusAutoSignInError];
                }
                result(error);
            }];
        }
    }
}

- (BOOL)canAutoSignIn
{
    if (self.username) {
        NSString *pwd = [self loadPasswdForAccount:self.username];
        if (pwd) {
            return YES;
        }
        return NO;
    }
    
    return NO;
}

- (void)signOut
{
//    [self unregisterToken];
    
    [self deletePasswdForAccount:self.username];
    //    [[OPKVDatabase defaultDatabase] removeObjectForKey:kOPXDFUsername];
    self.username = nil;
    _user = nil;
    [self updateStatus:BBUserStatusSignOut];
}

- (void)signInSuccess:(BBUserObject *)user
{
    _user = user;
//    [self registerToken];
    [self updateStatus:BBUserStatusSignIn];
//    [self requestTips];
//    [self requstTeacherIntro];
}


- (void)signIn:(NSString *)username pwd:(NSString *)pwd result:(void(^)(NSError *error))result
{
    BBUserRequest *request = [BBUserRequest request];
    request.path = [[request.path stringByAppendingPathComponent:username] stringByAppendingPathComponent:pwd];
    __weak typeof(self) weakself = self;
    [request sendRequest:^(id data, NSError *error) {
        if (nil == error) {
            [weakself signInSuccess:data];
            // 保存用户名用于自动登录
            [weakself saveUsername:username];
            // 登录成功将密码保存到keychain
            [weakself savePasswd:pwd account:username];
        }
        
        result(error);
        
    }];
}

@end
