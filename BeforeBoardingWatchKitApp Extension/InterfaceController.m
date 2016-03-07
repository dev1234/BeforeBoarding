//
//  InterfaceController.m
//  BeforeBoardingWatchKitApp Extension
//
//  Created by 白 云鹏 on 16/3/7.
//  Copyright © 2016年 wangshun. All rights reserved.
//

#import "InterfaceController.h"


@interface InterfaceController()

@end


@implementation InterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];

    // Configure interface objects here.
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

- (IBAction)updateAction {
    


    NSURL *URL = [NSURL URLWithString:@"http://10.77.80.20/api/task/h12001"];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                            completionHandler:
                                  ^(NSData *data, NSURLResponse *response, NSError *error) {
                                      // ...
                                  }];
    
    NSMutableDictionary *allData = [ NSJSONSerialization JSONObjectWithData:task options:NSJSONReadingMutableContainers error:nil]; //data in serialized view
    NSString* currentTask = nil;
    
    NSArray* tempTask = allData[@"items"];
    
    for (NSDictionary* taskDictionary in tempTask)
    {
        currentTask = taskDictionary[@"taskName"];
    }
    
    
    [task resume];
}

@end



