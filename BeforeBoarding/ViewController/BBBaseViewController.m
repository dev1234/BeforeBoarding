//
//  BBBaseViewController.m
//  BeforeBoarding
//
//  Created by 王顺 on 16/3/7.
//  Copyright © 2016年 wangshun. All rights reserved.
//

#import "BBBaseViewController.h"

@interface BBBaseViewController ()

@end

@implementation BBBaseViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self initDataSource];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self refreshUI];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self.view endEditing:YES];
    if (self.hudVisible) {
        [self dismissProgressHud];
    }
}


@end
