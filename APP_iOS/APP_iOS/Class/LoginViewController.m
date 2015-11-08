//
//  LoginViewController.m
//  APP_iOS
//
//  Created by Li on 15/10/8.
//  Copyright © 2015年 Li. All rights reserved.
//

#import "LoginViewController.h"
#import "KeyboardManager.h"
#import "AppDelegate.h"
#import "ShopModel.h"
#import "Http.h"
#import "NSDictionary+JSONString.h"
#import "DES3Util.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [_nickNameTextField setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
    [_passwordTextField setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Action

- (IBAction)loginAction:(id)sender {
    
//    if (!_nickNameTextField.text.length) {
//        [SVProgressHUD showErrorWithStatus:@"请输入用户名"];
//        return;
//    }
//    if (!_passwordTextField.text.length) {
//        [SVProgressHUD showErrorWithStatus:@"请输入密码"];
//        return;
//    }
    
    
//    NSMutableDictionary *param = [NSMutableDictionary dictionary];
//    [param setValue:_nickNameTextField.text forKey:@"username"];
//    [param setValue:_passwordTextField.text forKey:@"password"];
//    [param setValue:@"1" forKey:@"applogin"];
//    
//    [LHttpRequest getHttpRequest:@"shopping_login.htm" parameters:param success:^(NSDictionary *responseDic) {
//        NSLog(@"%@", responseDic);
//        [kAppDelegate showMainViewController];
//    } failure:^(NSString *descript) {
//        
//    }];
    [self testHttp];
}

#pragma mark - UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if (textField == _passwordTextField) {
        [[IQKeyboardManager sharedManager] setKeyboardDistanceFromTextField:125];
    }
    else if (textField == _nickNameTextField) {
        [[IQKeyboardManager sharedManager] setKeyboardDistanceFromTextField:170];
    }
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    [[IQKeyboardManager sharedManager] setKeyboardDistanceFromTextField:10];
    return YES;
}

#pragma mark - 测试接口
- (void)testHttp {
    [[Http instance] myShop:@"1" completion:^(NSError *error, ShopModel *shop) {
        if ([error.domain isEqualToString:@""]) {
            NSLog(@"shopid=%@", shop.shopid);
        }
    }];
    
    [[Http instance] login:@"username" pwd:@"123456" completion:^(NSError *error, UserModel *user) {
        
    }];
    
    [[Http instance] main:@"32769" completion:^(NSError *error, MainModel *main) {
        NSLog(@"首页接口：%@", main.buyer);
    }];
    
    [[Http instance] modifyMyshop:@"32769" name:@"我的店铺" pic:@"" addr:@"" linkman:@"" linkphone:@"" completion:^(NSError *error) {
        NSLog(@"修改店铺信息%@", error.domain);
    }];
    
    [[Http instance] postpone:@"32769" month:1 completion:^(NSError *error) {
                NSLog(@"延长店铺时间%@", error.domain);
    }];
    
    [[Http instance] modifyPwd:@"32769" oldpwd:@"123456" newpwd:@"1111111" completion:^(NSError *error) {
        NSLog(@"修改密码%@", error.domain);
    }];
    
    [[Http instance] goodsList:@"32769" stat:1 count:10 page:1 completion:^(NSError *error, NSArray *dataArray) {
        NSLog(@"商品列表：%@", dataArray);
    }];
}
@end
