//
//  OPKVDatabase.h
//  vps
//
//  Created by sunguanglei on 14/12/10.
//  Copyright (c) 2014年 xdfucan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OPKVDatabase : NSObject

+ (instancetype)defaultDatabase;

- (id)loadObjectForKey:(NSString *)key;
- (int)loadIntForKey:(NSString *)key defaultValue:(int)val;
- (BOOL)loadBoolForKey:(NSString *)key defaultValue:(BOOL)val;
- (NSString *)loadStringForKey:(NSString *)key defaultValue:(NSString *)val;

- (void)saveObject:(id)val forKey:(NSString *)key;
- (void)saveInt:(int)val forKey:(NSString *)key;
- (void)saveBool:(BOOL)val forKey:(NSString *)key;
- (void)saveString:(NSString *)val forKey:(NSString *)key;

- (void)removeObjectForKey:(NSString *)key;

@end
