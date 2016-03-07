//
//  BBTaskTableViewCell.m
//  BeforeBoarding
//
//  Created by 王顺 on 16/3/7.
//  Copyright © 2016年 wangshun. All rights reserved.
//

#import "BBTaskTableViewCell.h"
#import "BBTaskObject.h"

@implementation BBTaskTableViewCell

- (void)setupUIWithObject:(id)object indexPath:(NSIndexPath *)indexPath {
    BBTaskObject *task = object;
    self.dateLabel.text = [task.depatureTime substringWithRange:NSMakeRange(5, 5)];
    self.departTimeLabel.text = [task.depatureTime substringWithRange:NSMakeRange(11, 5)];
    self.arrivalTimeLabel.text = [task.arrivalTime substringWithRange:NSMakeRange(11, 5)];
    self.departAirportLabel.text = task.departure.airportName;
    self.arrivalAirportLabel.text = task.arrival.airportName;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
