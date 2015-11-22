//
//  ShipViewCtr.m
//  APP_iOS
//
//  Created by 林小果 on 15/11/21.
//  Copyright © 2015年 Li. All rights reserved.
//

#import "ShipViewCtr.h"
#import "UIPopoverListView.h"
#import "UIView+Toast.h"

@interface ShipViewCtr () <UIPopoverListViewDataSource, UIPopoverListViewDelegate>
@property (nonatomic, strong)IBOutlet UITableView *tableView;
@property (nonatomic, strong)IBOutlet UIView *headerView;
@property (nonatomic, strong)IBOutlet UIView *footerView;
@property (nonatomic, strong)IBOutlet UIButton *btnLogistics;
@property (nonatomic, strong)IBOutlet UIButton *btnConfirm;
@property (nonatomic, strong)IBOutlet UITextField *tfSipCode;

@property (nonatomic, strong)NSString *sipCode;
@property (nonatomic, strong)NSMutableArray *logArray;
@property (nonatomic, assign)NSInteger logIndex;
@end

@implementation ShipViewCtr

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    _btnConfirm.layer.cornerRadius = 5.0;
    _btnConfirm.layer.borderColor = kRGBCOLOR(232, 88, 40).CGColor;
    _btnConfirm.layer.borderWidth = 1;
    [_btnConfirm setTitleColor:kRGBCOLOR(232, 88, 40) forState:UIControlStateNormal];
    _tableView.tableHeaderView = _headerView;
    _tableView.tableFooterView = _footerView;
    
    _logIndex = -1;
    [self getLogList];
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

- (IBAction)confirmAction:(id)sender {
    NSString *sipCode = _tfSipCode.text;
    if (_logIndex == -1) {
        [self.view makeToast:@"请选择物流公司"];
        return;
    }
    if (sipCode.length == 0) {
        [self.view makeToast:@"请选输入物流编号"];
        return;
    }

    kWEAKSELF;
    NSInteger orderId = _order.id;
    logisticsModel *logistics = [_logArray objectAtIndex:_logIndex];
    [[Http instance] ship:orderId logId:logistics.logid shipCode:sipCode desc:@"" completion:^(NSError * error) {
        if (error.code == 0) {
            [weakSelf.view makeToast:@"发货成功"];
            [weakSelf.navigationController popViewControllerAnimated:YES];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"ShipSuccess" object:nil];
        }
    }];
}

- (IBAction)logAction:(id)sender {
    CGFloat xWidth = self.view.bounds.size.width - 20.0f;
    
    CGRect rect = self.view.frame;
    CGFloat yHeight = rect.size.height - 100;
    CGFloat yOffset = (self.view.bounds.size.height - yHeight)/2.0f;
    UIPopoverListView *poplistview = [[UIPopoverListView alloc] initWithFrame:CGRectMake(10, yOffset, xWidth, yHeight)];
    poplistview.delegate = self;
    poplistview.datasource = self;
    poplistview.listView.scrollEnabled = YES;
    [poplistview setTitle:@"选择物流"];
    [poplistview show];
}

- (void)getLogList {
    kWEAKSELF;
    [[Http instance] logisticsList:^(NSError *error, NSArray *dataArray) {
        weakSelf.logArray = [NSMutableArray arrayWithArray:dataArray];
        [weakSelf.tableView reloadData];
    }];
}

#pragma mark - UIPopoverListViewDataSource
- (UITableViewCell *)popoverListView:(UIPopoverListView *)popoverListView
                    cellForIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                   reuseIdentifier:identifier];
    
    NSInteger row = indexPath.row;
    logisticsModel *logistics = [_logArray objectAtIndex:row];
    cell.textLabel.text = logistics.name;
    return cell;
}

- (NSInteger)popoverListView:(UIPopoverListView *)popoverListView
       numberOfRowsInSection:(NSInteger)section {
    return _logArray.count;
}

#pragma mark - UIPopoverListViewDelegate
- (void)popoverListView:(UIPopoverListView *)popoverListView
     didSelectIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.row;
    _logIndex = row;
    
    logisticsModel *logistics = [_logArray objectAtIndex:row];
    [_btnLogistics setTitle:logistics.name forState:UIControlStateNormal];
}

- (CGFloat)popoverListView:(UIPopoverListView *)popoverListView
   heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.0f;
}
@end
