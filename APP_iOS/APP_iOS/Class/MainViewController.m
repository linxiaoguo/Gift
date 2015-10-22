//
//  MainViewController.m
//  APP_iOS
//
//  Created by Li on 15/10/8.
//  Copyright © 2015年 Li. All rights reserved.
//

#import "MainViewController.h"
#import "UIImage+Color.h"

#import "MyShopViewController.h"
#import "GoodsViewController.h"
#import "SettingViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"天天好礼";
    
    [self setRightBarButtonWithImage:[UIImage imageNamed:@"gg_bg"] withHighlightedImage:nil withBlock:^(NSInteger tag) {
        
    }];
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

#pragma mark - action

- (IBAction)myShopAction:(id)sender {
    MyShopViewController *vc = [[MyShopViewController alloc] initWithNibName:@"MyShopViewController" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)goodsAction:(id)sender {
    GoodsViewController *vc = [[GoodsViewController alloc] initWithNibName:@"GoodsViewController" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)settingAction:(id)sender {
    SettingViewController *vc = [[SettingViewController alloc] initWithNibName:@"SettingViewController" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
