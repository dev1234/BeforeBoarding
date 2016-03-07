//
//  BBRootViewController.m
//  BeforeBoarding
//
//  Created by 王顺 on 16/3/7.
//  Copyright © 2016年 wangshun. All rights reserved.
//

#import "BBRootViewController.h"
#import <KVOController/FBKVOController.h>
#import "BBSession.h"
#import <WSControl/WSControl.h>
#import "BBTaskRequest.h"

@interface BBRootViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation BBRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self observeUserSignInStatus];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:YES];
}

- (void)observeUserSignInStatus {
    __weak typeof (self) weakSelf = self;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self.KVOController observe:[BBSession session] keyPath:@"userStatus" options:NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionNew block:^(id observer, id object, NSDictionary *change) {
            [weakSelf userStatusChaged:[change[NSKeyValueChangeNewKey] intValue]];
        }];
    });
}

- (void)userStatusChaged:(OPUserStatus)status
{
    // TODO: 需要显示引导页的状态
    if (BBUserStatusNewVersion == status) {
    }
    else if (BBUserStatusDefault == status) {
        // 未登录，需要提示用户登录
        [self autoSignIn];
    }
    else if (BBUserStatusAutoConnecting == status) {
        // 自动登录进行中未做处理
    }
    else if (BBUserStatusSignIn == status) {
        // 用户登录成功
        [self dismissViewControllerAnimated:YES completion:nil];
        [self dismissProgressHud];
        [self requestForTasks];
    }
    else if (BBUserStatusSignOut == status) {
        // 用户登出
        [self cleanUserData];
        [self showSininWithAnimate:YES];
    }
}

- (void)requestForTasks {
    [self showProgressHudWithMessage:@"loading..."];
    BBTaskRequest *request = [BBTaskRequest request];
    request.path = [request.path stringByAppendingPathComponent:[BBSession session].user.pilotID];
    [request sendRequest:^(id data, NSError *error) {
        [self dismissProgressHud];
        if (error) {
            [self showErrorInHudWithError:error];
        }else {
            [BBSession session].user.tasks = data;
            [self refreshUI];
        }
    }];
}

- (void)prepareDataSource {
    self.dataSource = [BBSession session].user.tasks;
}

- (void)reloadUI {
    [self.tableView reloadData];
}

- (void)autoSignIn
{
    __weak typeof (self) weakSelf = self;
    if ([[BBSession session] canAutoSignIn]) {
        [[BBSession session] autoSignIn:^(NSError *error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf dismissProgressHud];
                if (error) {
                    UIAlertView *alert = nil;
//                    if (OPErrorCodePasswordWrong == error.code) {
//                        alert = [[UIAlertView alloc] initWithTitle:@"错误" message:@"用户名或密码错误，请重新登录！" delegate:nil cancelButtonTitle:@"重新登录" otherButtonTitles:nil];
//                        [alert setAction:^(NSInteger buttonIndex) {
//                            [weakSelf showSinin];
//                        }];
//                    }
                    //                    else {
                    //                        alert = [[UIAlertView alloc] initWithTitle:@"错误" message:@"网络错误，请检查网络并重试！" delegate:nil cancelButtonTitle:@"重试" otherButtonTitles:@"重新登录", nil];
                    //                        [alert setAction:^(NSInteger buttonIndex) {
                    //                            if (buttonIndex == 0) {
                    //                                [weakSelf autoSignIn];
                    //                            }
                    //                            else {
                    //                                [weakSelf showSinin];
                    //                            }
                    //                        }];
                    //                    }
                    [alert show];
                }
            });
        }];
    }else {
        [self showSininWithAnimate:YES];
    }
}

- (void)cleanUserData {
    [self.navigationController popToRootViewControllerAnimated:NO];
    [self dismissViewControllerAnimated:NO completion:nil];
    self.dataSource = nil;
    [self.tableView reloadData];
}

- (void)showSininWithAnimate:(BOOL)animate {
    if (animate) {
        [self performSegueWithIdentifier:@"showSignIn" sender:self];
    }else {
        [self performSegueWithIdentifier:@"showSignInBefore" sender:self];

    }
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
