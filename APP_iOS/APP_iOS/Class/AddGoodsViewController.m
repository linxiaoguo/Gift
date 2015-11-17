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

@interface AddGoodsViewController () <UITextFieldDelegate>

@property (nonatomic, strong) GoodTypeModel *goodTypeModel;
@property (nonatomic, strong) GoodsTopicModel *goodsTopicModel;
@property (nonatomic, assign) BOOL isRecommand;

@end

@implementation AddGoodsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    if (_addNewGoods) {
        self.title = @"添加商品";
        _footerView.height -= 50;
    }
    else {
        self.title = @"商品管理";
    }
    
    _isRecommand = NO;

    [self.dataSource addObject:[NSMutableDictionary dictionary]];
    [self.dataSource addObject:[NSMutableDictionary dictionary]];
    
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

- (IBAction)saveAction:(UIButton *)sender {
    [self.view resignFirstResponder];

    if (!_goodName.text) {
        [SVProgressHUD showErrorWithStatus:@"请输入商品名称"];
        return;
    }
    if (!_goodTypeModel) {
        [SVProgressHUD showErrorWithStatus:@"请选择商品分类"];
        return;
    }
    if (!_goodsTopicModel) {
        [SVProgressHUD showErrorWithStatus:@"请选择商品主题"];
        return;
    }
    NSMutableDictionary *dic = [self.dataSource objectAtIndex:0];
    if (![dic objectForKey:@"type"] || ![dic objectForKey:@"price"] || ![dic objectForKey:@"stock"]) {
        [SVProgressHUD showErrorWithStatus:@"请输入商品属性"];
        return;
    }

    if (_addNewGoods) {
        [[Http instance] addGoods:[ShareValue instance].shopModel.shopid.integerValue name:_goodName.text typeId:_goodTypeModel.id topicId:_goodsTopicModel.id isrecommand:_isRecommand price:[[dic objectForKey:@"price"] floatValue] stock:[[dic objectForKey:@"stock"] integerValue] fileids:nil completion:^(NSError *error) {
            NSLog(@"添加商品：%@", error.domain);
            if (error.code == 0) {
                [super backAction];
                [SVProgressHUD showSuccessWithStatus:@"商品添加成功"];
            }
        }];
    }
}

- (IBAction)typeAction:(UIButton *)sender {
    [self.view resignFirstResponder];

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
    [self.view resignFirstResponder];

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
    [self.view resignFirstResponder];

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
    cell.typeTextField.delegate = self;
    cell.priceTextField.delegate = self;
    cell.stockTextField.delegate = self;

    kWEAKSELF;
    [cell.delButton addActionHandler:^(NSInteger tag) {
        if (weakSelf.dataSource.count > 1) {
            [weakSelf.dataSource removeObjectAtIndex:indexPath.row];
            [weakSelf.tableView beginUpdates];
            [_tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
            [weakSelf.tableView endUpdates];
        }
    }];
    
    NSMutableDictionary *dic = [self.dataSource objectAtIndex:indexPath.row];
    cell.typeTextField.text = dic[@"type"];
    cell.priceTextField.text = dic[@"price"];
    cell.stockTextField.text = dic[@"stock"];
    
    cell.typeTextField.tag = indexPath.row*10;
    cell.priceTextField.tag = indexPath.row*10+1;
    cell.stockTextField.tag = indexPath.row*10+2;
    
    return cell;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    NSInteger tag = textField.tag;
    NSInteger tag1 = tag / 10;
    NSInteger tag2 = tag % 10;
    
    NSMutableDictionary *dic = [self.dataSource objectAtIndex:tag1];
    if (tag2 == 0) {
        [dic setValue:textField.text forKey:@"type"];
    }
    else if (tag2 == 1) {
        [dic setValue:textField.text forKey:@"price"];
    }
    else if (tag2 == 2) {
        [dic setValue:textField.text forKey:@"stock"];
    }
    [self.dataSource replaceObjectAtIndex:tag1 withObject:dic];
}

@end
