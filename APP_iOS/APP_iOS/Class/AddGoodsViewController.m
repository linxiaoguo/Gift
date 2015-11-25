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
#import "MLSelectPhotoPickerViewController.h"

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
        _isRecommand = NO;
        _tableView.tableFooterView = _footerView;
    }
    else {
        self.title = @"商品管理";
        
        [[Http instance] goodsDetail:[ShareValue instance].shopModel.shopid.integerValue goodsId:_goodModel.id completion:^(NSError *error, GoodModel *goods) {
            if (error.code == 0) {
                
                _isRecommand = goods.isrecommand;
                _goodName.text = goods.name;
                _goodPrice.text = goods.price;
                _goodNum.text = [NSString stringWithFormat:@"%ld", (long)goods.stock];
                
                GoodTypeModel *goodTypeModel = [GoodTypeModel new];
                goodTypeModel.id = goods.typeid;
                goodTypeModel.name = goods.typename;
                _goodTypeModel = goodTypeModel;
                
                [_typeButton setTitle:goods.typename forState:UIControlStateNormal];

                GoodsTopicModel *goodsTopicModel = [GoodsTopicModel new];
                goodsTopicModel.id = goods.topicid;
                goodsTopicModel.name = goods.topicname;
                _goodsTopicModel = goodsTopicModel;
                
                [_topicButton setTitle:goods.topicname forState:UIControlStateNormal];
                
                _recomendSwitch.on = _isRecommand;
                
                if (goods.goods_status == 1) {
                    [_downOrUpButton setTitle:@"上架商品" forState:UIControlStateNormal];
                }
                else {
                    [_downOrUpButton setTitle:@"下架商品" forState:UIControlStateNormal];
                }
            }
        }];
        
        _tableView.tableFooterView = _footerView1;
    }
    
    _recomendSwitch.on = _isRecommand;
    _tableView.tableHeaderView = _headerView;
    
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
- (IBAction)downOrUpAction:(UIButton *)sender {
    
    [SVProgressHUD showWithStatus:@"处理中"];
    
    NSInteger status = 1;
    if ([sender.titleLabel.text isEqualToString:@"上架商品"]) {
        status = 0;
    }
    
    [[Http instance] statusGoods:status shopId:[ShareValue instance].shopModel.shopid.integerValue goodsId:_goodModel.id completion:^(NSError *error) {
        if (error.code == 0) {
            if (status == 1) {
                [SVProgressHUD showSuccessWithStatus:@"下架成功"];
                [_downOrUpButton setTitle:@"上架商品" forState:UIControlStateNormal];
            }
            else {
                [SVProgressHUD showSuccessWithStatus:@"上架成功"];
                [_downOrUpButton setTitle:@"下架商品" forState:UIControlStateNormal];
            }
        }
    }];
}

- (IBAction)saveAction:(UIButton *)sender {
    [self.view resignFirstResponder];

    if (!_goodName.text) {
        [SVProgressHUD showErrorWithStatus:@"请输入商品名称"];
        return;
    }
    if (!_goodPrice.text) {
        [SVProgressHUD showErrorWithStatus:@"请输入商品价格"];
        return;
    }
    if (!_goodNum.text) {
        [SVProgressHUD showErrorWithStatus:@"请输入商品库存"];
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

    if (_addNewGoods) {
        [[Http instance] addGoods:[ShareValue instance].shopModel.shopid.integerValue name:_goodName.text typeId:_goodTypeModel.id topicId:_goodsTopicModel.id isrecommand:_isRecommand price:_goodPrice.text.integerValue stock:_goodNum.text.integerValue fileids:nil completion:^(NSError *error) {
            NSLog(@"添加商品：%@", error.domain);
            if (error.code == 0) {
                [super backAction];
                [SVProgressHUD showSuccessWithStatus:@"添加成功"];
            }
        }];
    }
    else {
        [[Http instance] goodsModify:[ShareValue instance].shopModel.shopid.integerValue goodsId:_goodModel.id name:_goodName.text typeId:_goodTypeModel.id topicId:_goodsTopicModel.id isrecommand:_isRecommand price:_goodPrice.text.integerValue stock:_goodNum.text.integerValue fileids:nil completion:^(NSError *error) {
            NSLog(@"修改商品：%@", error.domain);
            if (error.code == 0) {
                [super backAction];
                [SVProgressHUD showSuccessWithStatus:@"修改成功"];
            }

        }];
    }
}

- (IBAction)addPhotoAction:(UIButton *)sender {
    MLSelectPhotoPickerViewController *pickerVc = [[MLSelectPhotoPickerViewController alloc] init];
    // Default Push CameraRoll
    pickerVc.status = PickerViewShowStatusCameraRoll;
    // Limit Count.
    pickerVc.minCount = 9;
    // Push
    [pickerVc show];
    __weak typeof(self) weakSelf = self;
    pickerVc.callBack = ^(NSArray *assets){
        // CallBack or Delegate
        
    };
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

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 140.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"AddGoodsTableViewCell";
    
    AddGoodsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        [tableView registerNib:[UINib nibWithNibName:@"AddGoodsTableViewCell" bundle:nil] forCellReuseIdentifier:identifier];
        cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    }
//    cell.backgroundColor = [UIColor clearColor];
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    cell.typeTextField.delegate = self;
//    cell.priceTextField.delegate = self;
//    cell.stockTextField.delegate = self;
//
//    kWEAKSELF;
//    [cell.delButton addActionHandler:^(NSInteger tag) {
//        if (weakSelf.dataSource.count > 1) {
//            [weakSelf.dataSource removeObjectAtIndex:indexPath.row];
//            [weakSelf.tableView beginUpdates];
//            [_tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
//            [weakSelf.tableView endUpdates];
//        }
//    }];
//    
//    NSMutableDictionary *dic = [self.dataSource objectAtIndex:indexPath.row];
//    cell.typeTextField.text = dic[@"type"];
//    cell.priceTextField.text = dic[@"price"];
//    cell.stockTextField.text = dic[@"stock"];
//    
//    cell.typeTextField.tag = indexPath.row*10;
//    cell.priceTextField.tag = indexPath.row*10+1;
//    cell.stockTextField.tag = indexPath.row*10+2;
    
    return cell;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
}

@end
