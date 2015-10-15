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

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
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

    [LHttpRequest getHttpRequest:@"goodsType.htm" parameters:nil success:^(NSDictionary *responseDic) {
        NSLog(@"%@", responseDic);
    } failure:^(NSString *descript) {
        
    }];
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


@end
