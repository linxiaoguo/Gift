//
//  ValidityDateViewController.m
//  APP_iOS
//
//  Created by Li on 15/10/13.
//  Copyright © 2015年 Li. All rights reserved.
//

#import "ValidityDateViewController.h"

@interface ValidityDateViewController ()

@end

@implementation ValidityDateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"延长有效期";
    
    _monthView.layer.borderColor = kRGBCOLOR(200, 200, 200).CGColor;

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

@end