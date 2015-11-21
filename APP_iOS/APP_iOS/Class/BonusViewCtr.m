//
//  BonusViewCtr.m
//  APP_iOS
//
//  Created by 林小果 on 15/10/4.
//  Copyright (c) 2015年 Li. All rights reserved.
//

#import "BonusViewCtr.h"
#import "BonusCell.h"
#import "BonusTotalCell.h"
#import "UITableView+Separator.h"

@interface BonusViewCtr ()

@property (nonatomic, strong)IBOutlet UILabel *lblTips1;
@property (nonatomic, strong)IBOutlet UILabel *lblTips2;
@property (nonatomic, strong)IBOutlet UITableView *tableView;
@end

@implementation BonusViewCtr

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.scrollEnabled = NO;
    [self setTitle:@"未提现金额"];
    _lblTips1.numberOfLines = 2;
    [_tableView setFullWidthSeparator];
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

#pragma mark - UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row != 2)
    return 60;
    return 0.5;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    IncomeTotalModel2 *model = self.incomeTotal;
    if (indexPath.row == 0) {
        static NSString *identifier = @"BonusTotalCell";
        BonusTotalCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            cell = [CustomView viewWithNibName:@"BonusTotalCell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.lblFee.text = [NSString stringWithFormat:@"¥%.2f", model.effectiveOutMoney];
        return cell;
    } else if (indexPath.row == 1){
        static NSString *identifier = @"BonusCell";
        BonusCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            cell = [CustomView viewWithNibName:@"BonusCell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.lblFee.text = [NSString stringWithFormat:@"¥%.2f", model.effectiveOutMoney];
        cell.row = indexPath.row;
        kWEAKSELF;
        [cell setBlock:^(NSInteger row) {//提现操作
            UIAlertController *alc = [UIAlertController alertControllerWithTitle:@"天天有礼" message:@"请输入提现金额" preferredStyle:UIAlertControllerStyleAlert];
            [alc addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                NSString *money = [[alc textFields] objectAtIndex:0].text;
                CGFloat m = money.floatValue;
                NSInteger shopId = [ShareValue instance].shopModel.shopid.integerValue;
                [[Http instance] withdraw:shopId money:m completion:^(NSError *error) {
                    if (error.code == 0) {
                        NSLog(@"%@", @"提现成功");
                    }
                }];
            }]];
            [alc addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {}]];
            [alc addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
                textField.keyboardType = UIKeyboardTypeNumberPad;
                textField.placeholder = @"输入金额";
            }];
            [weakSelf presentViewController:alc animated:YES completion:nil];
        }];
        return cell;
    } else {
        UITableViewCell *cell = [[UITableViewCell alloc] init];
        cell.backgroundColor = [UIColor clearColor];
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}
@end
