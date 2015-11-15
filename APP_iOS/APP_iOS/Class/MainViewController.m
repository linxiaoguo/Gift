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
#import "IncomeViewCtr.h"
#import "OrderViewCtr.h"
#import "MarketViewCtr.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"天天好礼";
    
    [self setRightBarButtonWithImage:[UIImage imageNamed:@"gg_bg"] withHighlightedImage:nil withBlock:^(NSInteger tag) {
        
    }];
    
    [_headImage sd_setImageWithURL:[NSURL URLWithString:[ShareValue instance].shopModel.pic.fileAddr] placeholderImage:[UIImage imageNamed:@"tx"]];
    _shopNameLabel.text = [ShareValue instance].shopModel.name;
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

- (IBAction)orderAction:(id)sender {
    OrderViewCtr *vc = [[OrderViewCtr alloc] initWithNibName:@"OrderViewCtr" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)incomeAction:(id)sender {
    IncomeViewCtr *vc = [[IncomeViewCtr alloc] initWithNibName:@"IncomeViewCtr" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)marketAction:(id)sender {
    MarketViewCtr *vc = [[MarketViewCtr alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - http

- (void)httpRequest {
    [[Http instance] main:[ShareValue instance].shopModel.shopid.integerValue completion:^(NSError *error, MainModel *main) {
        NSLog(@"首页接口今日买家：%@", main.buyer);
        if (error.code == 0) {
            _orderLabel.text = main.order;
            _buyerLabel.text = main.buyer;
            _incomeLabel.text = [NSString stringWithFormat:@"今日收入%@元", main.income];
        }
    }];
}

@end
