//
//  ValidityDateViewController.m
//  APP_iOS
//
//  Created by Li on 15/10/13.
//  Copyright © 2015年 Li. All rights reserved.
//

#import "ValidityDateViewController.h"

@interface ValidityDateViewController ()

@property (weak, nonatomic) IBOutlet UILabel *monthLabel;

@end

@implementation ValidityDateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"延长有效期";
    
    _monthView.layer.borderColor = kRGBCOLOR(200, 200, 200).CGColor;
    _ValidityPeriodLabel.text = [ShareFunction stringWithTimestamp:[ShareValue instance].shopModel.validate];
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

- (IBAction)monthAction:(UIButton *)sender {
    NSInteger tag = sender.tag;
    if (tag == 1) {
        if (_monthLabel.text.integerValue == 1) {
            return;
        }
        else {
            _monthLabel.text = [NSString stringWithFormat:@"%d", _monthLabel.text.integerValue - 1];
        }
    }
    else if (tag == 2) {
        if (_monthLabel.text.integerValue == 100) {
            return;
        }
        else {
            _monthLabel.text = [NSString stringWithFormat:@"%d", _monthLabel.text.integerValue + 1];
        }
    }
    _totalLabel.text = [NSString stringWithFormat:@"￥%d", _monthLabel.text.integerValue * 100];
}

- (IBAction)payAction:(id)sender {
    [[Http instance] postpone:[ShareValue instance].shopModel.shopid.integerValue month:_monthLabel.text.integerValue completion:^(NSError *error) {
        NSLog(@"延长店铺时间：%@", error.domain);
        if (error.code == 0) {
            [SVProgressHUD showSuccessWithStatus:@"延长有效期成功"];
        }
    }];
}

@end
