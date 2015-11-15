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
#import "MyCodeViewController.h"

@interface MyShopViewController ()

@end

@implementation MyShopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"个人中心";
    
    [_headImage sd_setImageWithURL:[NSURL URLWithString:[ShareValue instance].shopModel.pic.fileAddr] placeholderImage:[UIImage imageNamed:@"tx"]];
    _shopNameLabel.text = [ShareValue instance].shopModel.name;

    [self httpRequest];

    [self performSelector:@selector(addDay) withObject:nil afterDelay:0.1f];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addDay {
    double lastactivityInterval = [[ShareValue instance].shopModel.validate doubleValue];
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:lastactivityInterval];
    
    NSDate *now = [NSDate date];
    double deltaSeconds = [date timeIntervalSinceDate:now];
    double deltaMinutes = deltaSeconds / 60.0f;
    double deltaHours = deltaMinutes / 60.0f;
    double deltaDays = deltaHours / 24.0f;
    
    UILabel *day = [[UILabel alloc] initWithFrame:CGRectMake(_validateButton.centerX + 30, 0, 100, _validateButton.height)];
    day.textColor = kRGBCOLOR(164, 31, 38);
    day.font = [UIFont systemFontOfSize:14];
    if (deltaDays < 0.0f) {
        day.text = [NSString stringWithFormat:@"已过期%d天", -(NSUInteger)deltaDays];
    }
    else {
        day.text = [NSString stringWithFormat:@"剩余%d天", (NSUInteger)deltaDays];
    }
    [_validateButton addSubview:day];

    [_validateButton setTitle:[NSString stringWithFormat:@"有效期至%@                    ", [ShareFunction stringWithTimestamp:[ShareValue instance].shopModel.validate]] forState:UIControlStateNormal];

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)copyUrlAction:(id)sender {
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = [ShareValue instance].shopModel.url;
    
    [SVProgressHUD showSuccessWithStatus:@"已复制店铺链接到剪贴板"];
}

- (IBAction)shareAction:(id)sender {
}

- (IBAction)shopInfoAction:(id)sender {
    ModifyViewController *vc = [[ModifyViewController alloc] initWithNibName:@"ModifyViewController" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)validityAction:(id)sender {
    MyValidityDateViewController *vc = [[MyValidityDateViewController alloc] initWithNibName:@"MyValidityDateViewController" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)scanAction:(id)sender {
    MyCodeViewController *vc = [[MyCodeViewController alloc] initWithNibName:@"MyCodeViewController" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
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
