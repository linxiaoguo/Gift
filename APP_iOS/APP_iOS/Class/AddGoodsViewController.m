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
#import "UIImage+Orientation.h"
#import "UIImage+Resize.h"

@interface AddGoodsViewController () <UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate>

@property (nonatomic, strong) GoodsClassModel *goodsClassModel;
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
        [self refreshPhoto];
    }
    else {
        self.title = @"商品管理";
        [self goodsInfoRequest];
        
        _tableView.tableFooterView = _footerView1;
    }
    
    _recomendSwitch.on = _isRecommand;
    
}

- (void)goodsInfoRequest {
    [[Http instance] goodsDetail:[ShareValue instance].shopModel.shopid.integerValue goodsId:_goodModel.id completion:^(NSError *error, GoodModel *goods) {
        if (error.code == 0) {
            
            _isRecommand = goods.isrecommand;
            _goodName.text = goods.name;
            _goodPrice.text = goods.price;
            _goodNum.text = [NSString stringWithFormat:@"%ld", (long)goods.stock];
            
            GoodsClassModel *goodsClassModel = [GoodsClassModel new];
            goodsClassModel.id = goods.typeid;
            goodsClassModel.name = goods.typename;
            _goodsClassModel = goodsClassModel;
            
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
            
            [self.dataSource addObjectsFromArray:goods.files];
            [self refreshPhoto];
        }
    }];
}

- (void)refreshPhoto {
    for (UIView *view in _photoView.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            [view removeFromSuperview];
        }
    }
    for (int i=0; i<=self.dataSource.count; i++) {
        
        if (i == self.dataSource.count) {
            
            UIButton *imageButton = [UIButton buttonWithType:UIButtonTypeCustom];
            imageButton.frame = CGRectMake(16+16*(i%3)+(kScreenWidth-16*4)/3*(i%3), 45+16*(i/3)+(kScreenWidth-16*4)/3*(i/3), (kScreenWidth-16*4)/3, (kScreenWidth-16*4)/3);
            [imageButton setImage:[UIImage imageNamed:@"增加成员"] forState:UIControlStateNormal];
            imageButton.adjustsImageWhenHighlighted = NO;
            [imageButton addTarget:self action:@selector(addPhotoAction:) forControlEvents:UIControlEventTouchUpInside];
            [_photoView addSubview:imageButton];

            break;
        }
        
        FieldModel *fieldModel = [self.dataSource objectAtIndex:i];
        
        UIButton *imageButton = [UIButton buttonWithType:UIButtonTypeCustom];
        imageButton.frame = CGRectMake(16+16*(i%3)+(kScreenWidth-16*4)/3*(i%3), 45+16*(i/3)+(kScreenWidth-16*4)/3*(i/3), (kScreenWidth-16*4)/3, (kScreenWidth-16*4)/3);
        if (fieldModel.fileData) {
            [imageButton setImage:[UIImage imageWithData:fieldModel.fileData] forState:UIControlStateNormal];
        }
        else {
            [imageButton sd_setImageWithURL:[NSURL URLWithString:fieldModel.fileAddr] forState:UIControlStateNormal];
        }
        imageButton.adjustsImageWhenHighlighted = NO;
        [_photoView addSubview:imageButton];
        
        UIButton *deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [deleteButton setFrame:CGRectMake(imageButton.right - 10, imageButton.top - 10, 20, 20)];
        [deleteButton setImage:[UIImage imageNamed:@"delete"] forState:UIControlStateNormal];
        deleteButton.tag = i;
        [deleteButton addTarget:self action:@selector(deleteAction:) forControlEvents:UIControlEventTouchUpInside];
        [_photoView addSubview:deleteButton];
        
    }
    _photoViewH.constant =  45+16*(self.dataSource.count/3+1)+(kScreenWidth-16*4)/3*(self.dataSource.count/3 + 1);
    
    _headerView.height = _photoViewH.constant - 128 + 393;
    
    _tableView.tableHeaderView = _headerView;
}

- (void)deleteAction:(UIButton *)sender {
    [self.dataSource removeObjectAtIndex:sender.tag];
    [self refreshPhoto];
}

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
    if (!_goodsClassModel) {
        [SVProgressHUD showErrorWithStatus:@"请选择商品分类"];
        return;
    }
    if (!_goodsTopicModel) {
        [SVProgressHUD showErrorWithStatus:@"请选择商品主题"];
        return;
    }

    NSMutableArray *fileids = [NSMutableArray array];
    for (FieldModel *fieldMode in self.dataSource) {
        NSMutableDictionary *fileDic = [NSMutableDictionary dictionary];
        [fileDic setObject:[NSString stringWithFormat:@"%ld", (long)fieldMode.fileId] forKey:@"fileid"];
        [fileids addObject:fileDic];
    }
    
    if (_addNewGoods) {
        [[Http instance] addGoods:[ShareValue instance].shopModel.shopid.integerValue name:_goodName.text typeId:_goodsClassModel.id topicId:_goodsTopicModel.id isrecommand:_isRecommand price:_goodPrice.text.integerValue stock:_goodNum.text.integerValue fileids:fileids goodsDesc:nil completion:^(NSError *error) {
            NSLog(@"添加商品：%@", error.domain);
            if (error.code == 0) {
                [super backAction];
                [SVProgressHUD showSuccessWithStatus:@"添加成功"];
            }
        }];
    }
    else {
        [[Http instance] goodsModify:[ShareValue instance].shopModel.shopid.integerValue goodsId:_goodModel.id name:_goodName.text typeId:_goodsClassModel.id topicId:_goodsTopicModel.id isrecommand:_isRecommand price:_goodPrice.text.integerValue stock:_goodNum.text.integerValue fileids:fileids goodsDesc:@"新的描述" completion:^(NSError *error) {
            NSLog(@"修改商品：%@", error.domain);
            if (error.code == 0) {
                [super backAction];
                [SVProgressHUD showSuccessWithStatus:@"修改成功"];
            }

        }];
    }
}

- (IBAction)addPhotoAction:(UIButton *)sender {
    UIActionSheet *t_ac = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照", @"从相册选取", nil];
    [t_ac setActionSheetStyle:UIActionSheetStyleBlackTranslucent];
    [t_ac showInView:[UIApplication sharedApplication].keyWindow];
}

- (IBAction)typeAction:(UIButton *)sender {
    [self.view resignFirstResponder];

    kWEAKSELF;
    
    GoodsListViewController *vc = [[GoodsListViewController alloc] initWithNibName:@"GoodsListViewController" bundle:nil];
    vc.type = 1;
    vc.parentId = 0;
    [vc setBlock:^(NSObject *model) {
        weakSelf.goodsClassModel = (GoodsClassModel *)model;
        [sender setTitle:weakSelf.goodsClassModel.name forState:UIControlStateNormal];
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

#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            picker.delegate = self;
//            picker.allowsEditing = YES;
            picker.sourceType = sourceType;
            [self presentViewController:picker animated:YES completion:^(){
                [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
            }];
        }
        else {
            [ShareFunction showAlert:@"您的设备没有拍照设备"];
        }
    }
    else if (buttonIndex == 1) {
        UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        UIImagePickerController *picker = [[UIImagePickerController alloc]init];
        [[picker navigationBar] setTintColor:[UIColor whiteColor]];
        [picker.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName, nil]];
        picker.delegate = self;
//        picker.allowsEditing = YES;
        picker.sourceType = sourceType;
        [self presentViewController:picker animated:YES completion:^(){
            [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
        }];
    }
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:^(){
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    }];
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    [[Http instance] uploadFile:nil uploadFile:[UIImage fixOrientation:image] mname:@"123" completion:^(NSError *error, FieldModel *fieldModel) {
        [SVProgressHUD dismiss];
        if (error.code == 0) {
            fieldModel.fileData = UIImageJPEGRepresentation([UIImage fixOrientation:image], 0.4);
            [self.dataSource addObject:fieldModel];
            [self refreshPhoto];
        }
    }];
}

@end
