//
//  BonusHistroyViewCtr.m
//  APP_iOS
//
//  Created by 林小果 on 15/11/15.
//  Copyright © 2015年 Li. All rights reserved.
//

#import "BonusHistroyViewCtr.h"
#import "BonusHistroyCell.h"
#import "BonusHistroyHeaderCell.h"
#import "CustomView.h"
#import "NSDate+Addition.h"

@interface BonusHistroyViewCtr ()

@property (nonatomic, strong)IBOutlet UITableView *tableView;
@property (nonatomic, strong)IBOutlet UILabel *lblApplyed;
@property (nonatomic, strong)IBOutlet UILabel *llbApplying;
@property (nonatomic, strong)IncomeTotalModel *total;
@end

@implementation BonusHistroyViewCtr

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"已提现金额"];
    _llbApplying.text = [NSString stringWithFormat:@"¥%.2f", _incomeTotal.totalOutingMoney];
    _lblApplyed.text = [NSString stringWithFormat:@"¥%.2f", _incomeTotal.totalOutMoney];
    [self getData];
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
    return 44;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1+_total.lists.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        static NSString *identifier = @"BonusHistroyHeaderCell";
        BonusHistroyHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            cell = [CustomView viewWithNibName:@"BonusHistroyHeaderCell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        return cell;
    } else {
        static NSString *identifier = @"BonusHistroyCell";
        BonusHistroyCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            cell = [CustomView viewWithNibName:@"BonusHistroyCell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        if (indexPath.row - 1 < _total.lists.count) {
            IncomeModel *model = [_total.lists objectAtIndex:indexPath.row - 1];
            NSDate *date = [NSDate dateWithTimeIntervalSince1970:model.time/1000];
            cell.lblTime.text = [date dateWithFormat:@"yyyy-MM-dd hh:mm"];
            cell.lblFee.text = [NSString stringWithFormat:@"%.2f", model.money];
            cell.lblState.text = [model statusString];
        }
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];
}

- (void)getData {
    kWEAKSELF;
    NSInteger shopId = [ShareValue instance].shopModel.shopid.integerValue;
    [[Http instance] withdrawList:shopId count:100 page:1 completion:^(NSError *error, IncomeTotalModel *incomeTotal) {
        if (error.code == 0) {
            weakSelf.total = incomeTotal;
            [weakSelf.tableView reloadData];
        }
    }];
}
@end
