//
//  IncomeViewCtr.m
//  APP_iOS
//
//  Created by 林小果 on 15/10/2.
//  Copyright (c) 2015年 Li. All rights reserved.
//

#import "IncomeViewCtr.h"
#import "IncomeCell.h"
#import "IncomeBindCell.h"
#import "UITableView+Separator.h"
#import "BindBankViewCtr.h"
#import "BonusViewCtr.h"
#import "BonusHistroyViewCtr.h"

@interface IncomeViewCtr ()
@property (nonatomic, strong)IBOutlet UITableView *tableView;
@property (nonatomic, strong)IncomeTotalModel2 *incomeTotal;
@end

@implementation IncomeViewCtr

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"收入管理"];
    [_tableView setNoFooterSeparator];
    [_tableView setFullWidthSeparator];
    [self getData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [_tableView reloadData];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark -  UITableViewDelegate
//section头部间距
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 5;
}
//section头部视图
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 5)];
    view.backgroundColor = [UIColor clearColor];
    return view;
}
//section底部间距
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 1;
}
//section底部视图
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 1)];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0)
        return 65;
    else
        return 40;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0)
        return 2;
    else
        return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    IncomeTotalModel2 *model = _incomeTotal;
    if (indexPath.section == 0) {
        static NSString *identifier=@"IncomeCell";
        IncomeCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            cell = [CustomView viewWithNibName:@"IncomeCell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        if (indexPath.row == 0) {
            cell.lblTitle.text = @"未提现金额（元）";
            cell.lblFee.text = [NSString stringWithFormat:@"%.2f", model.effectiveOutMoney];
        } else if (indexPath.row == 1) {
            cell.imvIcon.image = [UIImage imageNamed:@"sr_ytx"];
            cell.lblTitle.text = @"已提现金额（元）";
            cell.lblFee.text = [NSString stringWithFormat:@"%.2f", model.totalOutMoney];
        }
        return cell;
    } else {
        static NSString *identifier=@"IncomeBindCell";
        IncomeBindCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            cell = [CustomView viewWithNibName:@"IncomeBindCell"];
        }
        BOOL isBindBank = [ShareValue instance].shopModel.isbingingcard;
        if (isBindBank) {
            cell.lblState.text = @"已绑定";
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        } else {
            cell.selectionStyle = UITableViewCellSelectionStyleDefault;
        }
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];
    if (indexPath.section == 1) {
        
        BOOL isBindBank = [ShareValue instance].shopModel.isbingingcard;
        if (isBindBank)
            return;
        BindBankViewCtr *vc = [[BindBankViewCtr alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            BonusViewCtr *vc = [[BonusViewCtr alloc] init];
            vc.incomeTotal = self.incomeTotal;
            [self.navigationController pushViewController:vc animated:YES];
        } else if (indexPath.row == 1) {
            BonusHistroyViewCtr *vc = [[BonusHistroyViewCtr alloc] init];
            vc.incomeTotal = self.incomeTotal;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (void)getData {
    kWEAKSELF;
    NSInteger shopId = [ShareValue instance].shopModel.shopid.integerValue;
    [[Http instance] income:shopId completion:^(NSError *error, IncomeTotalModel2 *incomeTotal) {
        weakSelf.incomeTotal = incomeTotal;
        [weakSelf.tableView reloadData];
    }];
}
@end
