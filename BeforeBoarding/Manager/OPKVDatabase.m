//
//  OPKVDatabase.m
//  vps
//
//  Created by sunguanglei on 14/12/10.
//  Copyright (c) 2014年 xdfucan. All rights reserved.
//

#import "OPKVDatabase.h"
@interface OPKVDatabase()

@property (atomic, strong) NSUserDefaults *userDefaults;

@end

@implementation OPKVDatabase

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.userDefaults = [NSUserDefaults standardUserDefaults];
    }
    return self;
}

+ (instancetype)defaultDatabase
{
    static id database = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        database = [[OPKVDatabase alloc] init];
    });
    return database;
}


- (id)loadObjectForKey:(NSString *)key
{
    return [self.userDefaults objectForKey:key];
}

- (int)loadIntForKey:(NSString *)key defaultValue:(int)val
{
    id v = [self.userDefaults objectForKey:key];
    if (v) {
        return [v intValue];
    }
    return val;
}

- (BOOL)loadBoolForKey:(NSString *)key defaultValue:(BOOL)val
{
    id v = [self.userDefaults objectForKey:key];
    if (v) {
        return [v boolValue];
    }
    return val;
}

- (NSString *)loadStringForKey:(NSString *)key defaultValue:(NSString *)val
{
    id v = [self.userDefaults objectForKey:key];
    if (v) {
        return v;
    }
    return val;
}


- (void)saveObject:(id)val forKey:(NSString *)key
{
    [self.userDefaults setObject:val forKey:key];
    [self.userDefaults synchronize];
}

- (void)saveInt:(int)val forKey:(NSString *)key
{
    [self.userDefaults setObject:@(val) forKey:key];
    [self.userDefaults synchronize];
}

- (void)saveBool:(BOOL)val forKey:(NSString *)key
{
    [self.userDefaults setObject:@(val) forKey:key];
    [self.userDefaults synchronize];
}

- (void)saveString:(NSString *)val forKey:(NSString *)key
{
    [self.userDefaults setObject:val forKey:key];
    [self.userDefaults synchronize];
}

- (void)removeObjectForKey:(NSString *)key
{
    [self.userDefaults removeObjectForKey:key];
}

@end
