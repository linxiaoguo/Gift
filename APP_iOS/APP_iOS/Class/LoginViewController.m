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
#import "DES3Util.h"
#import "NSDictionary+JSONString.h"

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

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    [_scrollView setContentSize:CGSizeMake(kScreenWidth, kScreenHeight)];
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

//    [LHttpRequest getHttpRequest:@"goodsType.htm" parameters:nil success:^(NSDictionary *responseDic) {
//        NSLog(@"%@", responseDic);
//    } failure:^(NSString *descript) {
//        
//    }];
    [self testHttp];
    [kAppDelegate showMainViewController];
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
//    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
//    [dic setObject:@"32768" forKey:@"shopid"];
//    [dic setObject:@"18" forKey:@"apilevel"];
//    NSString *shopid = [dic JSONStringPlain];
//    NSLog(@"%@", encode);
//    NSString *decode = [DES3Util decrypt:encode];
//    NSLog(@"%@", decode);
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:@"1" forKey:@"shopid"];
    NSString *jsonString = [dic JSONStringPlain];
    NSString *encode = [DES3Util encrypt:jsonString];

    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setObject:encode forKey:@"req"];
    [LHttpRequest getHttpRequest:@"myshop.htm" parameters:param success:^(NSDictionary *responseDic) {
        NSLog(@"%@", responseDic);
    } failure:^(NSString *descript) {
        
    }];
}
@end
