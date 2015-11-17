//
//  AddGoodsViewController.m
//  APP_iOS
//
//  Created by Li on 15/10/14.
//  Copyright © 2015年 Li. All rights reserved.
//

#import "AddGoodsViewController.h"
#import "AddGoodsTableViewCell.h"
#import "GoodsListViewController.h"
#import "UITextView+PlaceHolder.h"

@interface AddGoodsViewController ()

@property (nonatomic, strong) GoodTypeModel *goodTypeModel;
@property (nonatomic, strong) GoodsTopicModel *goodsTopicModel;
@property (nonatomic, assign) BOOL isRecommand;

@end

@implementation AddGoodsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"商品管理";
    
    _isRecommand = NO;

    [self.dataSource addObject:[NSDictionary dictionary]];
    [self.dataSource addObject:[NSDictionary dictionary]];
    
    _tableView.tableHeaderView = _headerView;
    _tableView.tableFooterView = _footerView;
    
    [_goodsIntroTextView addPlaceHolder:@"请输入商品简介"];
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

- (IBAction)typeAction:(UIButton *)sender {
    kWEAKSELF;
    
    GoodsListViewController *vc = [[GoodsListViewController alloc] initWithNibName:@"GoodsListViewController" bundle:nil];
    vc.type = 1;
    [vc setBlock:^(NSObject *model) {
        weakSelf.goodTypeModel = (GoodTypeModel *)model;
        [sender setTitle:weakSelf.goodTypeModel.name forState:UIControlStateNormal];
    }];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)topicAction:(UIButton *)sender {
    kWEAKSELF;

    GoodsListViewController *vc = [[GoodsListViewController alloc] initWithNibName:@"GoodsListViewController" bundle:nil];
    vc.type = 2;
    [vc setBlock:^(NSObject *model) {
        weakSelf.goodsTopicModel = (GoodsTopicModel *)model;
        [sender setTitle:weakSelf.goodsTopicModel.name forState:UIControlStateNormal];
    }];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)isRecommandSwitch:(UISwitch *)sender {
    _isRecommand = sender.on;
}

- (IBAction)addGoodsAction:(id)sender {
    [self.dataSource addObject:[NSDictionary dictionary]];
    
    [_tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 140.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"AddGoodsTableViewCell";
    
    AddGoodsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        [tableView registerNib:[UINib nibWithNibName:@"AddGoodsTableViewCell" bundle:nil] forCellReuseIdentifier:identifier];
        cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    }
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    kWEAKSELF;
    [cell.delButton addActionHandler:^(NSInteger tag) {
        [weakSelf.dataSource removeObjectAtIndex:indexPath.row];
        [weakSelf.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section]] withRowAnimation:UITableViewRowAnimationAutomatic];
    }];
    
    
    return cell;
}


@end
