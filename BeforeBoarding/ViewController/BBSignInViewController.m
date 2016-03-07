//
//  BBSignInViewController.m
//  BeforeBoarding
//
//  Created by 王顺 on 16/3/7.
//  Copyright © 2016年 wangshun. All rights reserved.
//

#import "BBSignInViewController.h"
#import "BBSession.h"
#import "GlobalPrefix.h"

@interface BBSignInViewController ()

@property (weak, nonatomic) IBOutlet UITextField *userTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@end

@implementation BBSignInViewController

- (IBAction)signInAction:(UIButton *)sender {
    
    NSString *warnMessage = nil;
    if (0 == self.userTextField.text.length) {
        warnMessage = @"Please input username!";
    }else if (0 == self.passwordTextField.text.length) {
        warnMessage = @"Please input password!";
    }
    
    if (warnMessage.length) {
        NSError *error = [NSError errorWithDomain:OPErrorDomain code:-1 userInfo:@{NSLocalizedFailureReasonErrorKey: warnMessage, NSLocalizedDescriptionKey: warnMessage}];
        [self showErrorInHudWithError:error];
        return;
    }
    
    __weak typeof(self) weakself = self;
    [self showProgressHudWithMessage:@"loading..."];
    [[BBSession session] signIn:self.userTextField.text pwd:self.passwordTextField.text result:^(NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakself dismissProgressHud];
            if (error) {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    if ([error.domain isEqualToString:NSURLErrorDomain]) {
                        [weakself showErrorMessageInHud:@"bad net work!"];
                    }
                    else {
                        [weakself showErrorInHudWithError:error];
                    }
                });
            }else {
                [self.view endEditing:YES];
            }
        });
    }];


}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
