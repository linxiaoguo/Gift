//
//  GoodsListViewController.m
//  APP_iOS
//
//  Created by Li on 15/11/17.
//  Copyright © 2015年 Li. All rights reserved.
//

#import "GoodsListViewController.h"
#import "GoodTypeModel.h"
#import "GoodsTopicModel.h"

@interface GoodsListViewController ()

@end

@implementation GoodsListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self getData];
    
    _tableView.tableFooterView = [UIView new];
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

- (void)getData {
    if (_type == 1) {
        self.title = @"商品分类";
        
        [[Http instance] goodsTypeList:^(NSError *error, NSArray *dataArray) {
            NSLog(@"商品类型：%lu", (unsigned long)dataArray.count);
            if (error.code == 0) {
                [self.dataSource addObjectsFromArray:dataArray];
                [_tableView reloadData];
            }
        }];
    }
    else {
        self.title = @"商品主题";

        [[Http instance] goodsTopicList:^(NSError *error, NSArray *dataArray) {
            NSLog(@"商品主题：%lu", (unsigned long)dataArray.count);
            if (error.code == 0) {
                [self.dataSource addObjectsFromArray:dataArray];
                [_tableView reloadData];
            }
        }];
    }
    
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (self.block) {
        self.block([self.dataSource objectAtIndex:indexPath.row]);
        [super backAction];
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    if (_type == 1) {
        GoodTypeModel *model = [self.dataSource objectAtIndex:indexPath.row];
        cell.textLabel.text = model.name;
    }
    else {
        GoodsTopicModel *model = [self.dataSource objectAtIndex:indexPath.row];
        cell.textLabel.text = model.name;
    }
    
    
    return cell;
}

@end
