//
//  BBTaskTableViewCell.h
//  BeforeBoarding
//
//  Created by 王顺 on 16/3/7.
//  Copyright © 2016年 wangshun. All rights reserved.
//

#import "OPBaseTableViewCell.h"

@interface BBTaskTableViewCell : OPBaseTableViewCell
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *departTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *departAirportLabel;
@property (weak, nonatomic) IBOutlet UILabel *arrivalTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *arrivalAirportLabel;
@property (weak, nonatomic) IBOutlet UILabel *taskNameLabel;

@end
