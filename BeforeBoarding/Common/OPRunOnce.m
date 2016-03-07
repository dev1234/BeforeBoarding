//
//  OPRunOnce.m
//  Run action only at current version first run.
//  It is very easy to use.
//  Just Call runOnce:action, specify the only key to
//  the action and target.
//

#import "OPRunOnce.h"

#define kOPRunOnceKey       @"OPRunOnceKey"
#define kOPRunOnceVersion   @"OPRunOnceVersion"

@interface OPRunOnce ()
@property (nonatomic, strong) NSString *version;
@end

@implementation OPRunOnce

- (id)init
{
    self = [super init];
    if (self != nil) {
        self.version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        id runOnceData = [userDefaults objectForKey:kOPRunOnceKey];
        if (runOnceData == nil) {
            [userDefaults setObject:@{kOPRunOnceVersion: _version} forKey:kOPRunOnceKey];
        }
        else {
            if (![_version isEqualToString:[runOnceData objectForKey:kOPRunOnceVersion]]) {
                [userDefaults setObject:@{kOPRunOnceVersion: _version} forKey:kOPRunOnceKey];
            }
        }
        [userDefaults synchronize];
    }
    return self;
}

- (BOOL)actionAlreadyRun:(NSString *)key
{
    BOOL ret = NO;
    @synchronized(self) {
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        id runOnceData = [userDefaults objectForKey:kOPRunOnceKey];
        
        if ([runOnceData objectForKey:key] == nil)
            ret = NO;
        else
            ret = YES;
    }
    return ret;
}

- (void)saveActionState:(NSString *)key
{
    @synchronized(self) {
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        id runOnceData = [userDefaults objectForKey:kOPRunOnceKey];
        NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:runOnceData];
        [dict setObject:[NSNumber numberWithBool:YES] forKey:key];
        [userDefaults setObject:dict forKey:kOPRunOnceKey];
        [userDefaults synchronize];
    }
}

- (void)run:(NSString *)key action:(BOOL (^)(NSString *version))action
{
    if ([self actionAlreadyRun:key]) {
        return;
    }
    
    if (action(_version)) {
        [self saveActionState:key];
    }
}

+ (id)sharedInstance {
    static OPRunOnce *sharedInstance = nil;
    static dispatch_once_t onceToken = 0;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[OPRunOnce alloc] init];
    });
    return sharedInstance;
}

+ (void)runOnce:(NSString *)key action:(BOOL (^)(NSString *version))action
{
    OPRunOnce *run = [OPRunOnce sharedInstance];
    [run run:key action:action];
}

+ (void)runOnceAsync:(NSString *)key action:(BOOL (^)(NSString *version))action
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        OPRunOnce *run = [OPRunOnce sharedInstance];
        [run run:key action:action];
    });
}

+ (void)tryToSuccessWithMaxTimes:(NSInteger)count action:(BOOL (^)(void))action
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        if (action) {
            for (NSInteger i = 0; i < count; i++) {
                if (action()) {
                    break;
                }
            }
        }
    });
}

@end
