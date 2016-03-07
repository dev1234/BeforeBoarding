//
//  InterfaceController.m
//  BeforeBoarding WatchKit App Extension
//
//  Created by 白 云鹏 on 16/3/5.
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
//    NSURLRequest* requestForWeatherData = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://api.openweathermap.org/data/2.5/weather?q=London,uk"]];
//    NSURLResponse* response = nil;
//    NSError* error = nil; //do it always
//    
//    NSData* data = [NSURLConnection sendSynchronousRequest:requestForWeatherData returningResponse:&response error:&error]; //for saving all of received data in non-serialized view
//    
//    NSMutableDictionary *allData = [ NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error]; //data in serialized view
//    NSString* currentWeather = nil;
//    
//    NSArray* weather = allData[@"weather"];
//    
//    for (NSDictionary* weatherDictionary in weather)
//    {
//        currentWeather = weatherDictionary[@"main"];
//    }
}
@end



