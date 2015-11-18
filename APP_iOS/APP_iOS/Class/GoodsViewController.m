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

@interface GoodsViewController () {
    UILabel *_countLabel;
}

@property (nonatomic, copy) NSString *stat;     //1-出售中 0-已下架

@property (nonatomic, assign) NSInteger page;
@property (nonatomic, assign) NSInteger pageSize;

@end

@implementation GoodsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"商品管理";
    
//    [self setRightBarButtonWithImage:[UIImage imageNamed:@"search-icon"] withHighlightedImage:nil withBlock:^(NSInteger tag) {
//    }];
    
    _stat = @"1";
    _page = 1;
    _pageSize = 20;
    
    UIView *headerView = [UIView new];
    headerView.frame = CGRectMake(0, 0, kScreenWidth, 20);
    headerView.backgroundColor = [UIColor clearColor];
    _countLabel = [UILabel new];
    _countLabel.frame = CGRectMake(0, 0, kScreenWidth, 12);
    _countLabel.textAlignment = NSTextAlignmentCenter;
    _countLabel.textColor = [UIColor darkGrayColor];
    _countLabel.font = [UIFont systemFontOfSize:12];
    [headerView addSubview:_countLabel];
    _tableView.tableHeaderView = headerView;
    
    kWEAKSELF;
    [self.tableView addLegendHeaderWithRefreshingBlock:^{
        _pageSize = 1;
        [weakSelf goodsListRequest:YES];
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

- (IBAction)stateAction:(UISegmentedControl *)sender {
    if (sender.selectedSegmentIndex == 0) {
        _stat = @"1";
    }
    else {
        _stat = @"0";
    }
    [self.tableView.header beginRefreshing];
}

- (IBAction)addGoodsAction:(id)sender {
    AddGoodsViewController *vc = [[AddGoodsViewController alloc] initWithNibName:@"AddGoodsViewController" bundle:nil];
    vc.addNewGoods = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 190.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    AddGoodsViewController *vc = [[AddGoodsViewController alloc] initWithNibName:@"AddGoodsViewController" bundle:nil];
    vc.addNewGoods = NO;
    vc.goodModel = [self.dataSource objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
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
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.goodModel = [self.dataSource objectAtIndex:indexPath.row];
    
    return cell;
}

#pragma mark - Request

- (void)goodsListRequest:(BOOL)reload {
    [[Http instance] goodsList:[ShareValue instance].shopModel.shopid.integerValue stat:_stat.integerValue count:1000 page:1 recommend:YES completion:^(NSError *error, NSArray *dataArray) {
        if (error.code == 0) {
            if (self.page == 1) {
                [self.dataSource removeAllObjects];
            }
            [self.dataSource addObjectsFromArray:dataArray];
            _countLabel.text = [NSString stringWithFormat:@"共%d个产品", self.dataSource.count];
            
            [self.tableView reloadData];
            [self.tableView.header endRefreshing];

        }
    }];
}

@end
