//
//  OPRunOnce.h
//  Run action only at current version first run.
//  It is very easy to use.
//  Just Call runOnce:action, specify the only key to
//  the action and target.
//

#import <Foundation/Foundation.h>

@interface OPRunOnce : NSObject

+ (void)runOnce:(NSString *)key action:(BOOL (^)(NSString *version))action;
+ (void)runOnceAsync:(NSString *)key action:(BOOL (^)(NSString *version))action;
+ (void)tryToSuccessWithMaxTimes:(NSInteger)count action:(BOOL (^)(void))action;

@end