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
#import "AddGoodsViewController.h"

@interface MarketViewCtr ()
@property (nonatomic, copy) NSString *stat;     //1-已推荐 0-未推荐

@property (nonatomic, assign) NSInteger page;
@property (nonatomic, assign) NSInteger pageSize;

@property (nonatomic, strong) NSMutableDictionary *selectDic;
@property (nonatomic, assign) NSInteger selectRow;

@property (nonatomic, strong) IBOutlet UIView *viewAdd;
@end

@implementation MarketViewCtr

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"营销管理"];
    
    _stat = @"1";
    _page = 1;
    _pageSize = 20;
    _selectRow = -1;
    
    UIView *headerView = [UIView new];
    headerView.frame = CGRectMake(0, 0, kScreenWidth, 20);
    headerView.backgroundColor = [UIColor clearColor];
    _tableView.tableHeaderView = headerView;
    
    kWEAKSELF;
    [self.tableView addLegendHeaderWithRefreshingBlock:^{
        _pageSize = 1;
        [weakSelf getData];
    }];

    _selectDic = [NSMutableDictionary dictionary];
    self.tableView.footer.stateHidden = YES;
    self.tableView.header.updatedTimeHidden = YES;
    self.tableView.tableFooterView = [UIView new];
    [self.tableView.header beginRefreshing];
    _viewAdd.hidden = YES;
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

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 190.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([_stat isEqualToString:@"0"]) {
        _selectRow = indexPath.row;
    } else {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        [self.tableView reloadData];
    }
    
    
//    AddGoodsViewController *vc = [[AddGoodsViewController alloc] initWithNibName:@"AddGoodsViewController" bundle:nil];
//    vc.addNewGoods = NO;
//    vc.goodModel = [self.dataSource objectAtIndex:indexPath.row];
//    [self.navigationController pushViewController:vc animated:YES];
//    NSString *rowString = [NSString stringWithFormat:@"row-%ld", (long)indexPath.row];
//    BOOL isSelect = [[_selectDic objectForKey:rowString] boolValue];
//    if (isSelect) {
//        [_selectDic setObject:[NSNumber numberWithBool:NO] forKey:rowString];
//    } else {
//        [_selectDic setObject:[NSNumber numberWithBool:YES] forKey:rowString];
//    }
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
    
    cell.accessImageView.hidden = NO;
    cell.goodModel = [self.dataSource objectAtIndex:indexPath.row];
    
//    if ([_stat isEqualToString:@"0"]) {
//        NSString *rowString = [NSString stringWithFormat:@"row-%ld", (long)indexPath.row];
//        BOOL isSelect = [[_selectDic objectForKey:rowString] boolValue];
//        if (isSelect) {
//            cell.accessoryType = UITableViewCellAccessoryCheckmark;
//        } else {
//            cell.accessoryType = UITableViewCellAccessoryNone;
//        }
//        cell.accessImageView.hidden = YES;
//    }
    return cell;
}


#pragma mark - 切换UISegmentedControl
- (IBAction)stateAction:(UISegmentedControl *)sender {
    if (sender.selectedSegmentIndex == 0) {
        _stat = @"1";
        _viewAdd.hidden = YES;
        _tableView.tableFooterView = nil;
    }
    else {
        _stat = @"0";
        _viewAdd.hidden = NO;
        
        UIView *aView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _tableView.frame.size.width, 50)];
        _tableView.tableFooterView = aView;
    }
    [self.tableView.header beginRefreshing];
}

#pragma mark - 按钮事件
- (IBAction)addRecommandAction:(id)sender {
    kWEAKSELF;
    NSInteger shopId = [ShareValue instance].shopModel.shopid.integerValue;
    if (_selectRow < self.dataSource.count && _selectRow >= 0) {
        GoodModel *goods = [self.dataSource objectAtIndex:_selectRow];
        [[Http instance] recommendGoods:YES shopId:shopId goodsId:goods.id completion:^(NSError *error) {
            if (error.code == 0) {
                [SVProgressHUD showSuccessWithStatus:@"添加成功"];
                [weakSelf.tableView.header beginRefreshing];
            }
            
        }];
    }
}

#pragma mark - 获取数据
- (void)getData {
    [[Http instance] goodsList:[ShareValue instance].shopModel.shopid.integerValue stat:1 count:1000 page:1 recommend:[_stat boolValue] completion:^(NSError *error, NSArray *dataArray) {
        if (error.code == 0) {
            if (self.page == 1) {
                [self.dataSource removeAllObjects];
            }
            [self.dataSource addObjectsFromArray:dataArray];
            
            [self.tableView reloadData];
        }
        [self.tableView.header endRefreshing];
    }];
}
@end
