//
//  ModifyPwdViewController.m
//  APP_iOS
//
//  Created by Li on 15/10/22.
//  Copyright © 2015年 Li. All rights reserved.
//

#import "ModifyPwdViewController.h"

@interface ModifyPwdViewController ()

@end

@implementation ModifyPwdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"密码修改";
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


- (IBAction)modifyAction:(id)sender {
    
    if (_oldPwd.text.length < 1) {
        [SVProgressHUD showErrorWithStatus:@"请输入旧密码"];
        return;
    }
    if (_newPwd0.text.length < 1 || _newPwd1.text.length < 1) {
        [SVProgressHUD showErrorWithStatus:@"请输入新密码"];
        return;
    }
    if (![_newPwd0.text isEqualToString:_newPwd1.text]) {
        [SVProgressHUD showErrorWithStatus:@"两次输入的新密码不一样"];
        return;
    }

    
    [[Http instance] modifyPwd:[ShareValue instance].shopModel.shopid.integerValue oldpwd:_oldPwd.text newpwd:_newPwd1.text completion:^(NSError *error) {
        if (error.code == 0) {
            [super backAction];
            [SVProgressHUD showSuccessWithStatus:@"修改成功"];
        }
        else {
            [SVProgressHUD showErrorWithStatus:error.domain];
        }
        NSLog(@"修改我的密码：%@", error.domain);
    }];

}

@end
