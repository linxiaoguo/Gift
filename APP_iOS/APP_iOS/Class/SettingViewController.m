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
                @{@"image": @"xiconfont-ruanjiangengxin", @"title": @"检查更新"},
                nil];
    _tableView.tableFooterView = [UIView new];
    [_tableView setFullWidthSeparator];
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
    else if (indexPath.row == 3) {
        [[Http instance] queryVersion:1 completion:^(NSError *error, VersionModel *version) {
            NSLog(@"版本更新：%@", version.versionname);
            if (error.code == 0) {
                if (version.status == 0) {
                    [SVProgressHUD showSuccessWithStatus:@"已经是最新版本"];
                    return ;
                }
                NSString *iosVersion = version.version;
                NSString *localVersion = kAppVersion;
                
                NSComparisonResult result = [iosVersion compare:localVersion];
                if (result == NSOrderedDescending) {
                    _url = version.downurl;
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:version.info delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"更新", nil];
                    [alertView show];
                }
            }
            else {
                [SVProgressHUD showErrorWithStatus:error.domain];
            }
        }];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        
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
        cell.textLabel.font = [UIFont systemFontOfSize:15];
    }
    
    cell.textLabel.text = [[_dataArr objectAtIndex:indexPath.row] objectForKey:@"title"];
    cell.imageView.image = [UIImage imageNamed:[[_dataArr objectAtIndex:indexPath.row] objectForKey:@"image"]];
    
    return cell;
}

@end
