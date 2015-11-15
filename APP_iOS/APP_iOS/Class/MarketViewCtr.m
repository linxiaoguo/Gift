//
//  MarketViewCtr.m
//  APP_iOS
//
//  Created by 林小果 on 15/11/10.
//  Copyright © 2015年 Li. All rights reserved.
//

#import "MarketViewCtr.h"
#import "TestHttpViewCtr.h"
#import "GoodsTableViewCell.h"

@interface MarketViewCtr ()
@property (nonatomic, copy) NSString *stat;     //1-已推荐 0-未推荐

@property (nonatomic, assign) NSInteger page;
@property (nonatomic, assign) NSInteger pageSize;
@end

@implementation MarketViewCtr

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"营销管理"];
    
    _stat = @"1";
    _page = 1;
    _pageSize = 20;
    
    UIView *headerView = [UIView new];
    headerView.frame = CGRectMake(0, 0, kScreenWidth, 20);
    headerView.backgroundColor = [UIColor clearColor];
    _tableView.tableHeaderView = headerView;
    
    kWEAKSELF;
    [self.tableView addLegendHeaderWithRefreshingBlock:^{
        _pageSize = 1;
        [weakSelf getData];
    }];
    //    [self.tableView addLegendFooterWithRefreshingBlock:^{
    //        [weakSelf goodsListRequest:NO];
    //    }];
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


- (IBAction)testHttp:(id)sender {
    TestHttpViewCtr *vc = [[TestHttpViewCtr alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)addRecommandAction:(id)sender {

}


- (void)getData {
    [[Http instance] goodsList:[ShareValue instance].shopModel.shopid.integerValue stat:_stat.integerValue count:1000 page:1 recommend:YES completion:^(NSError *error, NSArray *dataArray) {
        if (error.code == 0) {
            if (self.page == 1) {
                [self.dataSource removeAllObjects];
            }
            [self.dataSource addObjectsFromArray:dataArray];
            
            [self.tableView reloadData];
            [self.tableView.header endRefreshing];
        }
    }];

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
    
    cell.goodModel = [self.dataSource objectAtIndex:indexPath.row];
    return cell;
}
@end
