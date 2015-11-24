//
//  ModifyViewController.m
//  APP_iOS
//
//  Created by Li on 15/8/25.
//  Copyright (c) 2015年 Li. All rights reserved.
//

#import "ModifyViewController.h"
#import "BaseTextViewController.h"

#import "UIImage+Orientation.h"
#import "AppDelegate.h"
#import "BaseWebViewController.h"

@interface ModifyViewController () <UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, copy) NSData *headData;
@property (nonatomic, copy) NSString *shopName;
@property (nonatomic, copy) NSString *shopAddr;
@property (nonatomic, copy) NSString *contact;
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *regTime;
@property (nonatomic, copy) NSString *shopURL;


@end

@implementation ModifyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"个人中心";
    
    _tableView.sectionFooterHeight = 10.0;
    [self.dataSource addObject:@[@"店铺信息", @"店铺名称", @"店铺实体地址", @"联系人", @"联系电话"]];
    [self.dataSource addObject:@[@"注册时间", @"网址"]];

    self.shopName = [ShareValue instance].shopModel.name;
    self.shopAddr = [ShareValue instance].shopModel.addr;
    self.contact = [ShareValue instance].shopModel.linkman;
    self.phone = [ShareValue instance].shopModel.linkphone;
    self.regTime = [ShareFunction stringWithTimestamp:[ShareValue instance].shopModel.regdate];
    self.shopURL = [ShareValue instance].shopModel.url;
    
    [self.tableView reloadData];
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

#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            picker.delegate = self;
            picker.allowsEditing = YES;
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
        picker.allowsEditing = YES;
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
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    _headData = UIImageJPEGRepresentation([UIImage fixOrientation:image], 0.3);
    [self.tableView reloadData];
    
    [SVProgressHUD show];
    [[Http instance] uploadFile:nil uploadFile:[UIImage fixOrientation:image] mname:@"123" completion:^(NSError *error, FieldModel *fieldModel) {
        [SVProgressHUD dismiss];
        if (error.code == 0) {
            [ShareValue instance].shopModel.pic.fileId = fieldModel.fileId;
            [self modifyShop];
        }
    }];

}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.1f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0 && indexPath.row == 0) {
        UIActionSheet *t_ac = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照", @"从相册选取", nil];
        [t_ac setActionSheetStyle:UIActionSheetStyleBlackTranslucent];
        [t_ac showInView:[UIApplication sharedApplication].keyWindow];
    }
    else if (indexPath.section == 1) {
//        kWEAKSELF;
        if (indexPath.row == 0) {
//            BaseTextViewController *vc = [[BaseTextViewController alloc] initWithNibName:@"BaseTextViewController" bundle:nil];
//            vc.title = @"注册时间";
//            vc.defaultContent = self.regTime;
//            vc.numberOfWords = 20;
//            [vc setBlock:^(BaseTextViewController *VC, NSString *text) {
//                //                UserModel *uerModel = [ShareValue instance].user;
//                //                uerModel.nickname = text;
//                //                [ShareValue instance].user = uerModel;
//                weakSelf.regTime = text;
//                [weakSelf.tableView reloadData];
//                //                [weakSelf perfectUserInfo:text withStr:@"nickname"];
//            }];
//            [self.navigationController pushViewController:vc animated:YES];
        }
        else if (indexPath.row == 1) {
            
            BaseWebViewController *vc = [[BaseWebViewController alloc] initWithNibName:@"BaseWebViewController" bundle:nil];
            vc.urlStr = self.shopURL;
            [self.navigationController pushViewController:vc animated:YES];
            
//            BaseTextViewController *vc = [[BaseTextViewController alloc] initWithNibName:@"BaseTextViewController" bundle:nil];
//            vc.title = @"网址";
//            vc.defaultContent = self.shopURL;
//            vc.numberOfWords = 50;
//            [vc setBlock:^(BaseTextViewController *VC, NSString *text) {
//                //                UserModel *uerModel = [ShareValue instance].user;
//                //                uerModel.realname = text;
//                //                [ShareValue instance].user = uerModel;
//                weakSelf.shopURL = text;
//                [weakSelf.tableView reloadData];
//                //                [weakSelf perfectUserInfo:text withStr:@"realname"];
//            }];
//            [self.navigationController pushViewController:vc animated:YES];
        }
    }
    else {
        kWEAKSELF;
        if (indexPath.row == 1) {
            BaseTextViewController *vc = [[BaseTextViewController alloc] initWithNibName:@"BaseTextViewController" bundle:nil];
            vc.title = @"店铺名称";
            vc.defaultContent = self.shopName;
            vc.numberOfWords = 20;
            [vc setBlock:^(BaseTextViewController *VC, NSString *text) {
                ShopModel *shopModel = [ShareValue instance].shopModel;
                shopModel.name = text;
                [ShareValue instance].shopModel = shopModel;
                weakSelf.shopName = text;
                [weakSelf.tableView reloadData];
                [weakSelf modifyShop];
            }];
            [self.navigationController pushViewController:vc animated:YES];
        }
        else if (indexPath.row == 2) {
            BaseTextViewController *vc = [[BaseTextViewController alloc] initWithNibName:@"BaseTextViewController" bundle:nil];
            vc.title = @"店铺实体地址";
            vc.defaultContent = self.shopAddr;
            vc.numberOfWords = 50;
            [vc setBlock:^(BaseTextViewController *VC, NSString *text) {
                ShopModel *shopModel = [ShareValue instance].shopModel;
                shopModel.addr = text;
                [ShareValue instance].shopModel = shopModel;
                weakSelf.shopAddr = text;
                [weakSelf.tableView reloadData];
                [weakSelf modifyShop];
            }];
            [self.navigationController pushViewController:vc animated:YES];
        }
        else if (indexPath.row == 3) {
            BaseTextViewController *vc = [[BaseTextViewController alloc] initWithNibName:@"BaseTextViewController" bundle:nil];
            vc.title = @"联系人";
            vc.defaultContent = self.contact;
            vc.numberOfWords = 5;
            [vc setBlock:^(BaseTextViewController *VC, NSString *text) {
                ShopModel *shopModel = [ShareValue instance].shopModel;
                shopModel.linkman = text;
                [ShareValue instance].shopModel = shopModel;
                weakSelf.contact = text;
                [weakSelf.tableView reloadData];
                [weakSelf modifyShop];
            }];
            [self.navigationController pushViewController:vc animated:YES];
        }
        else if (indexPath.row == 4) {
            BaseTextViewController *vc = [[BaseTextViewController alloc] initWithNibName:@"BaseTextViewController" bundle:nil];
            vc.title = @"联系电话";
            vc.defaultContent = self.contact;
            vc.numberOfWords = 11;
            vc.keyboardType = UIKeyboardTypeNamePhonePad;
            [vc setBlock:^(BaseTextViewController *VC, NSString *text) {
                ShopModel *shopModel = [ShareValue instance].shopModel;
                shopModel.linkphone = text;
                [ShareValue instance].shopModel = shopModel;
                weakSelf.phone = text;
                [weakSelf.tableView reloadData];
                [weakSelf modifyShop];
            }];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *arr = [self.dataSource objectAtIndex:section];
    return [arr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
        
        UIImageView *headImage = [[UIImageView alloc] init];
        headImage.frame = CGRectMake(kScreenWidth-32-30, 6, 32, 32);
        headImage.layer.cornerRadius = 16;
        headImage.layer.masksToBounds = YES;
        [headImage sd_setImageWithURL:[NSURL URLWithString:[ShareValue instance].shopModel.pic.fileAddr] placeholderImage:[UIImage imageNamed:@"tx"]];
        headImage.tag = 100;
        [cell.contentView addSubview:headImage];
    }
    
    UIImageView *headImage = (UIImageView *)[cell.contentView viewWithTag:100];
    headImage.hidden = YES;

    cell.textLabel.text = [[self.dataSource objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    
    if (indexPath.section == 0) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleGray;

        if (indexPath.row == 0) {
            headImage.hidden = NO;
            if (_headData) {
                headImage.image = [UIImage imageWithData:_headData];
            }
        }
        else if (indexPath.row == 1) {
            cell.detailTextLabel.text = self.shopName;
        }
        else if (indexPath.row == 2) {
            cell.detailTextLabel.text = self.shopAddr;
        }
        else if (indexPath.row == 3) {
            cell.detailTextLabel.text = self.contact;
        }
        else if (indexPath.row == 4) {
            cell.detailTextLabel.text = self.phone;
        }

    }
    else if (indexPath.section == 1) {
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        if (indexPath.row == 0) {
            cell.detailTextLabel.text = self.regTime;
        }
        else if (indexPath.row == 1) {
            cell.detailTextLabel.text = self.shopURL;
        }
    }
    
    return cell;
}

#pragma mark - Request

- (void)modifyShop {
    [[Http instance] modifyMyshop:[ShareValue instance].shopModel.shopid.integerValue name:[ShareValue instance].shopModel.name pic:[NSString stringWithFormat:@"%ld", (long)[ShareValue instance].shopModel.pic.fileId] addr:[ShareValue instance].shopModel.addr linkman:[ShareValue instance].shopModel.linkman linkphone:[ShareValue instance].shopModel.linkphone completion:^(NSError *error) {
        
        NSLog(@"修改我的店铺：%@", error.domain);
        if (error.code == 0) {
            [kAppDelegate loginAction];
//            [SVProgressHUD showSuccessWithStatus:@""];
        }
    }];

}

@end
