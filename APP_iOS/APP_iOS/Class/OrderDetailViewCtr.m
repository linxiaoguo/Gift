//
//  OrderDetailViewCtr.m
//  APP_iOS
//
//  Created by 林小果 on 15/11/14.
//  Copyright © 2015年 Li. All rights reserved.
//

#import "OrderDetailViewCtr.h"
#import "OrderTitleCell.h"
#import "OrderDetailCell.h"
#import "OrderDoCell.h"
#import "OrderFeeCell.h"
#import "OrderInfoCell.h"
#import "CustomView.h"

@interface OrderDetailViewCtr ()

@end

@implementation OrderDetailViewCtr

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"订单管理"];
    // Do any additional setup after loading the view from its nib.
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
    if (indexPath.section == 0) {
        if (indexPath.row == 0)
            return 44;
        if (indexPath.row == 1)
            return 85;
        if (indexPath.row == 2)
            return 60;
        if (indexPath.row == 3)
            return 44;
    } else {
        return 150;
    }
    return 0;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0)
        return 4;
    else
        return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            static NSString *identifier=@"OrderTitleCell";
            OrderTitleCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
            if (cell == nil) {
                cell = [CustomView viewWithNibName:@"OrderTitleCell"];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            return cell;
        } else if (indexPath.row == 1) {
            static NSString *identifier=@"OrderDetailCell";
            OrderDetailCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
            if (cell == nil) {
                cell = [CustomView viewWithNibName:@"OrderDetailCell"];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            return cell;
        } else if (indexPath.row == 2) {
            static NSString *identifier=@"OrderFeeCell";
            OrderFeeCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
            if (cell == nil) {
                cell = [CustomView viewWithNibName:@"OrderFeeCell"];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            return cell;
        } else {
            static NSString *identifier=@"OrderDoCell";
            OrderDoCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
            if (cell == nil) {
                cell = [CustomView viewWithNibName:@"OrderDoCell"];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            return cell;
        }
    } else {
        static NSString *identifier=@"OrderInfoCell";
        OrderInfoCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            cell = [CustomView viewWithNibName:@"OrderInfoCell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"订单编号:20000001111111\n创建时间:2015-11-15\n付款时间:2015-11-15\n发货时间2015-11-15\n成交时间2015-11-15"];
        NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:10];
        [string addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [string length])];
        cell.lblDesc.attributedText = string;
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];
}

@end
