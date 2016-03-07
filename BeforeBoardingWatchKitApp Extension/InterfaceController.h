//
//  InterfaceController.h
//  BeforeBoardingWatchKitApp Extension
//
//  Created by 白 云鹏 on 16/3/7.
//  Copyright © 2016年 wangshun. All rights reserved.
//

#import <WatchKit/WatchKit.h>
#import <Foundation/Foundation.h>

@interface InterfaceController : WKInterfaceController
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceLabel *infoContent;
- (IBAction)updateAction;

@end
