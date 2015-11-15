//
//  NoticeViewController.m
//  APP_iOS
//
//  Created by Li on 15/10/22.
//  Copyright © 2015年 Li. All rights reserved.
//

#import "NoticeViewController.h"
#import "MessageModel.h"

@interface NoticeViewController ()

@end

@implementation NoticeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"系统公告";
    
    kWEAKSELF;
    [self.tableView addLegendHeaderWithRefreshingBlock:^{
//        _pageSize = 1;
        [weakSelf requestNotice];
    }];
    self.tableView.footer.stateHidden = YES;
    self.tableView.header.updatedTimeHidden = YES;
    self.tableView.tableFooterView = [UIView new];
    [self.tableView.header beginRefreshing];

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

- (void)requestNotice {
    [[Http instance] messageList:[ShareValue instance].shopModel.shopid.integerValue count:1000 page:1 completion:^(NSError *error, NSArray *dataArray) {
        NSLog(@"消息列表：%ld", (long)dataArray.count);
        if (error.code == 0) {
            [self.dataSource removeAllObjects];
            [self.dataSource addObjectsFromArray:dataArray];
            [self.tableView reloadData];
        }
        else {
            [SVProgressHUD showErrorWithStatus:error.domain];
        }
        [self.tableView.header endRefreshing];
    }];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"NoticeViewController";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:13];
    }
    
    MessageModel *model = [self.dataSource objectAtIndex:indexPath.row];
    cell.textLabel.text = model.msgtitle;
    cell.detailTextLabel.text = [ShareFunction stringWithTimestamp:model.msgtime];
    
    return cell;
}

@end
