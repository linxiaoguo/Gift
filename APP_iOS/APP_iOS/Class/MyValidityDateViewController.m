//
//  MyValidityDateViewController.m
//  APP_iOS
//
//  Created by Li on 15/10/13.
//  Copyright © 2015年 Li. All rights reserved.
//

#import "MyValidityDateViewController.h"
#import "ValidityDateViewController.h"

@interface MyValidityDateViewController ()

@end

@implementation MyValidityDateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"有效期";
    
    double lastactivityInterval = [[ShareValue instance].shopModel.validate doubleValue];
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:lastactivityInterval];

    NSDate *now = [NSDate date];
    double deltaSeconds = [date timeIntervalSinceDate:now];
    double deltaMinutes = deltaSeconds / 60.0f;
    double deltaHours = deltaMinutes / 60.0f;
    double deltaDays = deltaHours / 24.0f;
    
    if (deltaDays < 0.0f) {
        _dayLabel.text = [NSString stringWithFormat:@"已过期%lu天", (unsigned long)-(NSUInteger)deltaDays];
    }
    else {
        _dayLabel.text = [NSString stringWithFormat:@"剩余%lu天", (unsigned long)deltaDays];
    }
    _ValidityPeriodLabel.text = [NSString stringWithFormat:@"有效期至 %@", [ShareFunction stringWithTimestamp:[ShareValue instance].shopModel.validate]];
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

- (IBAction)longAction:(id)sender {
    ValidityDateViewController *vc = [[ValidityDateViewController alloc] initWithNibName:@"ValidityDateViewController" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
