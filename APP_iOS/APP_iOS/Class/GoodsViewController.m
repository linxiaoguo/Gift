//
//  GoodsViewController.m
//  APP_iOS
//
//  Created by Li on 15/10/13.
//  Copyright © 2015年 Li. All rights reserved.
//

#import "GoodsViewController.h"
#import "GoodsTableViewCell.h"
#import "AddGoodsViewController.h"
#import "GoodModel.h"

@interface GoodsViewController ()

@end

@implementation GoodsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"商品管理";
    
    [self setRightBarButtonWithImage:[UIImage imageNamed:@"search-icon"] withHighlightedImage:nil withBlock:^(NSInteger tag) {
    }];
    
    kWEAKSELF;
    [self.tableView addLegendHeaderWithRefreshingBlock:^{
        [weakSelf goodsListRequest:YES];
    }];
    [self.tableView addLegendFooterWithRefreshingBlock:^{
        [weakSelf goodsListRequest:NO];
    }];
    self.tableView.footer.stateHidden = YES;
    self.tableView.header.updatedTimeHidden = YES;
    self.tableView.tableFooterView = [UIView new];

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

- (IBAction)stateAction:(UISegmentedControl *)sender {
    
}

- (IBAction)addGoodsAction:(id)sender {
    AddGoodsViewController *vc = [[AddGoodsViewController alloc] initWithNibName:@"AddGoodsViewController" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 190.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"GoodsTableViewCell";
    
    GoodsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        [tableView registerNib:[UINib nibWithNibName:@"GoodsTableViewCell" bundle:nil] forCellReuseIdentifier:identifier];
        cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    }
    
    return cell;
}

#pragma mark - Request

- (void)goodsListRequest:(BOOL)reload {
    
    GoodsListRequest *request = [[GoodsListRequest alloc] init];
    request.shopid = @"32769";
    request.stat = @"1";
    if (reload) {
        request.page = @"1";
    }
    
    [LHttpRequest getHttpRequest:@"goodsList.htm" parameters:request.keyValues success:^(NSDictionary *responseDic) {

        GoodsListResponse *goodsListModel = [GoodsListResponse objectWithKeyValues:responseDic];
        NSArray *list = goodsListModel.data;

        if (reload) {
            [self.dataSource removeAllObjects];
        }
        [self.dataSource addObjectsFromArray:list];
        [self.tableView reloadData];
        
        if (self.tableView.header.isRefreshing) {
            [self.tableView.header endRefreshing];
        }
        if (self.tableView.footer.isRefreshing) {
            [self.tableView.footer endRefreshing];
        }
//        
//        if (newsListModel.retData.lastPage.intValue == 1) {
//            self.tableView.footer.hidden = YES;
//        }
//        else {
//            self.offset += self.max;
//            self.tableView.footer.hidden = NO;
//        }
        
    } failure:^(NSString *descript) {
        [SVProgressHUD showErrorWithStatus:descript];
        if (self.tableView.header.isRefreshing) {
            [self.tableView.header endRefreshing];
        }
        if (self.tableView.footer.isRefreshing) {
            [self.tableView.footer endRefreshing];
        }
    }];

}

@end
