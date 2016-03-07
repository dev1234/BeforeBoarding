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
#import "GlobalPrefix.h"
#import "BBTaskTableViewCell.h"

@interface BBRootViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *titleButton;

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
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self requestForTasks];
        });
    }
    else if (BBUserStatusSignOut == status) {
        // 用户登出
        [self cleanUserData];
        [self showSininWithAnimate:YES];
    }
}

- (void)requestForTasks {
    if (![BBSession session].user) {
        return;
    }
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
    if (![BBSession session].user) {
        return;
    }
    [self.tableView reloadData];
    NSString *title  = [BBSession session].user.userName;
    [self.titleButton setTitle:title forState:UIControlStateNormal];
    self.tableView.tableFooterView = [UIView new];
}

- (IBAction)logOff:(UIBarButtonItem *)sender {
    [[BBSession session] signOut];
}

- (void)autoSignIn
{
    [self showProgressHudWithMessage:@"loading"];
    __weak typeof (self) weakSelf = self;
    if ([[BBSession session] canAutoSignIn]) {
        [[BBSession session] autoSignIn:^(NSError *error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf dismissProgressHud];
                if (error) {
                    UIAlertView *alert = nil;
                    if (OPErrorCodePasswordWrong == error.code) {
                        alert = [[UIAlertView alloc] initWithTitle:@"错误" message:@"用户名或密码错误，请重新登录！" delegate:nil cancelButtonTitle:@"重新登录" otherButtonTitles:nil];
                        [alert setAction:^(NSInteger buttonIndex) {
                            [weakSelf showSininWithAnimate:YES];
                        }];
                    }
                    else {
                        alert = [[UIAlertView alloc] initWithTitle:@"错误" message:@"网络错误，请检查网络并重试！" delegate:nil cancelButtonTitle:@"重试" otherButtonTitles:@"重新登录", nil];
                        [alert setAction:^(NSInteger buttonIndex) {
                            if (buttonIndex == 0) {
                                [weakSelf autoSignIn];
                            }
                            else {
                                [weakSelf showSininWithAnimate:YES];
                            }
                        }];
                    }
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

#pragma mark TableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataSource count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 94.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BBTaskTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([BBTaskTableViewCell class]) forIndexPath:indexPath];
    [cell setupUIWithObject:self.dataSource[indexPath.row] indexPath:indexPath];
    return cell;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        [segue.destinationViewController setValue:self.dataSource[indexPath.row] forKey:@"task"];
    }
}

@end
