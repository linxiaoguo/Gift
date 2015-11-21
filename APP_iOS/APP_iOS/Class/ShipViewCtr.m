//
//  ShipViewCtr.m
//  APP_iOS
//
//  Created by 林小果 on 15/11/21.
//  Copyright © 2015年 Li. All rights reserved.
//

#import "ShipViewCtr.h"

@interface ShipViewCtr ()

@end

@implementation ShipViewCtr

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    UIAlertController *alc = [UIAlertController alertControllerWithTitle:@"天天有礼" message:@"请填写物流编号" preferredStyle:UIAlertControllerStyleAlert];
//    [alc addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        NSString *sipCode = [[alc textFields] objectAtIndex:0].text;
//        if (sipCode.length == 0) {
//        } else {
//            NSInteger orderId = 1;
//            [[Http instance] ship:orderId logId:11 shipCode:sipCode desc:@"" completion:^(NSError * error) {
//                
//            }];
//        }
//    }]];
//    [alc addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {}]];
//    [alc addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
//        textField.placeholder = @"请填写物流编号";
//    }];
//    [self presentViewController:alc animated:YES completion:nil];
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
