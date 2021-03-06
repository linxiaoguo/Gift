//
//  SettingViewController.m
//  APP_iOS
//
//  Created by Li on 15/10/21.
//  Copyright © 2015年 Li. All rights reserved.
//

#import "SettingViewController.h"
#import "UITableView+Separator.h"

#import "NoticeViewController.h"
#import "ModifyPwdViewController.h"
#import "AppDelegate.h"
#import "AboutViewController.h"

@interface SettingViewController ()

@property (nonatomic, copy) NSArray *dataArr;
@property (nonatomic, copy) NSString *url;

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"系统设置";
    
    _dataArr = [[NSArray alloc] initWithObjects:
                @{@"image": @"xiconfont-mimaxiugai", @"title": @"密码修改"},
                @{@"image": @"xiconfont-gonggao", @"title": @"系统公告"},
                @{@"image": @"xiconfont-guanyu", @"title": @"关于"},
//                @{@"image": @"xiconfont-ruanjiangengxin", @"title": @"当前版本"},
                nil];
    _tableView.tableFooterView = _logoutView;
}

- (void)viewDidLayoutSubviews {
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
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

- (IBAction)logoutAction:(id)sender {
    [ShareValue instance].shopModel = nil;
    [(AppDelegate *)[[UIApplication sharedApplication] delegate] showLoginViewController];
}


#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0) {
        ModifyPwdViewController *vc = [[ModifyPwdViewController alloc] initWithNibName:@"ModifyPwdViewController" bundle:nil];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (indexPath.row == 1) {
        NoticeViewController *vc = [[NoticeViewController alloc] initWithNibName:@"NoticeViewController" bundle:nil];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (indexPath.row == 2) {
        AboutViewController *vc = [[AboutViewController alloc] initWithNibName:@"AboutViewController" bundle:nil];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (indexPath.row == 3) {
//        [[Http instance] queryVersion:1 completion:^(NSError *error, VersionModel *version) {
//            NSLog(@"版本更新：%@", version.versionname);
//            if (error.code == 0) {
//                if (version.status == 0) {
//                    [SVProgressHUD showSuccessWithStatus:@"已经是最新版本"];
//                    return ;
//                }
//                NSString *iosVersion = version.version;
//                NSString *localVersion = kAppVersion;
//                
//                NSComparisonResult result = [iosVersion compare:localVersion];
//                if (result == NSOrderedDescending) {
//                    _url = version.downurl;
//                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:version.info delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"更新", nil];
//                    [alertView show];
//                }
//            }
//            else {
//                [SVProgressHUD showErrorWithStatus:@"已经是最新版本"];
//            }
//        }];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        NSURL *url = [NSURL URLWithString:_url];
        [[UIApplication sharedApplication] openURL:url];
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"SettingViewControllerCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.font = [UIFont systemFontOfSize:14];
    }
    if (indexPath.row == 3) {
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
        version = [NSString stringWithFormat:@"V%@", version];
        cell.detailTextLabel.text = version;
        cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
    }
    
    cell.textLabel.text = [[_dataArr objectAtIndex:indexPath.row] objectForKey:@"title"];
    cell.imageView.image = [UIImage imageNamed:[[_dataArr objectAtIndex:indexPath.row] objectForKey:@"image"]];
    
    return cell;
}

@end
