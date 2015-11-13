//
//  MyShopViewController.m
//  APP_iOS
//
//  Created by Li on 15/10/10.
//  Copyright © 2015年 Li. All rights reserved.
//

#import "MyShopViewController.h"
#import "MyValidityDateViewController.h"
#import "ModifyViewController.h"

@interface MyShopViewController ()

@end

@implementation MyShopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"微店信息";
    
    [self httpRequest];

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

- (IBAction)shopInfoAction:(id)sender {
    ModifyViewController *vc = [[ModifyViewController alloc] initWithNibName:@"ModifyViewController" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)validityAction:(id)sender {
    MyValidityDateViewController *vc = [[MyValidityDateViewController alloc] initWithNibName:@"MyValidityDateViewController" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)scanAction:(id)sender {
}

#pragma mark - http

- (void)httpRequest {
    [[Http instance] myShop:[ShareValue instance].shopModel.shopid.integerValue completion:^(NSError *error, ShopModel *shop) {
        if (error.code == 0) {
            NSLog(@"我的店铺shopid：%@", shop.shopid);
        }
    }];

}

@end
