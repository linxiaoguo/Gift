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
#import "OrderContactCell.h"
#import "CustomView.h"
#import "NSDate+Addition.h"
#import "UIView+Toast.h"

#import "ShipViewCtr.h"

@interface OrderDetailViewCtr ()

@property (nonatomic, strong)IBOutlet UITableView *tableView;
@end

@implementation OrderDetailViewCtr

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"订单管理"];
    // Do any additional setup after loading the view from its nib.
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(shipSuccess:) name:@"ShipSuccess" object:nil];
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
    return 3;
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
    } else if (indexPath.section == 1){
        return 95;
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
    OrderModel *model = _order;
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            static NSString *identifier=@"OrderTitleCell";
            OrderTitleCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
            if (cell == nil) {
                cell = [CustomView viewWithNibName:@"OrderTitleCell"];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            NSString *shopImg = [ShareValue instance].shopModel.pic.fileAddr;
            [cell.imvIcon sd_setImageWithURL:[NSURL URLWithString:shopImg] placeholderImage:nil];
            NSString *shopName = [ShareValue instance].shopModel.name;
            cell.lblTitle.text = shopName;
            return cell;
        } else if (indexPath.row == 1) {
            static NSString *identifier=@"OrderDetailCell";
            OrderDetailCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
            if (cell == nil) {
                cell = [CustomView viewWithNibName:@"OrderDetailCell"];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            cell.imvIcon.image = [UIImage imageNamed:@"cpxqq"];
            NSArray *goods = model.goods;
            if (goods.count > 0) {
                GoodOrderModel *good = [goods objectAtIndex:0];
                cell.lblDesc.text = good.name;
                cell.lblCount.text = [NSString stringWithFormat:@"×%ld", (long)good.sales];
                cell.lblFee.text = [NSString stringWithFormat:@"¥%.2f", good.price];
                cell.lblSize.text = good.color;
            }
            return cell;
        } else if (indexPath.row == 2) {
            static NSString *identifier=@"OrderFeeCell";
            OrderFeeCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
            if (cell == nil) {
                cell = [CustomView viewWithNibName:@"OrderFeeCell"];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            cell.lblYunFee.text = [NSString stringWithFormat:@"¥%.2f", model.freight];
            cell.lblTotal.text = [NSString stringWithFormat:@"¥%.2f", model.totalPrice];
            return cell;
        } else {
            static NSString *identifier=@"OrderDoCell";
            OrderDoCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
            if (cell == nil) {
                cell = [CustomView viewWithNibName:@"OrderDoCell"];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            [cell setRow:indexPath.row];
            [cell setShowBlock:^(NSInteger row) {//显示物流
                
            }];
            
            if (_tag == 0) {
                cell.btnConfirm.hidden = NO;
                cell.lblStat.hidden = YES;
                
                kWEAKSELF;
                [cell setConfirmBlock:^(NSInteger row) {//确认发货
                    ShipViewCtr *vc = [[ShipViewCtr alloc] init];
                    vc.order = weakSelf.order;
                    [weakSelf.navigationController pushViewController:vc animated:YES]; 
                }];
            } else {
                cell.btnConfirm.hidden = YES;
                cell.lblStat.hidden = NO;
                
                NSArray *arr = @[@"", @"待付款", @"已发货", @"已完成"];
                if (_tag < arr.count)
                    cell.lblStat.text = [arr objectAtIndex:_tag];
            }
        
            return cell;
        }
    } else if (indexPath.section == 1){
        static NSString *identifier=@"OrderContactCell";
        OrderContactCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            cell = [CustomView viewWithNibName:@"OrderContactCell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        NSString *addr = model.addr;
        NSString *addrname = model.addrname;
        NSString *mobile = model.addrmobile;
        if (addr == nil)
            addr = @"";
        if (addrname == nil)
            addrname = @"";
        if (mobile == nil)
            mobile = @"";
        
        NSString *text = [NSString stringWithFormat:@"收货人:%@\n联系电话:%@\n收获地址:%@", addr, mobile, addrname];
        NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:text];
        NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:10];
        [string addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [string length])];
        cell.lblDesc.attributedText = string;

        return cell;
    } else {
        static NSString *identifier=@"OrderInfoCell";
        OrderInfoCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            cell = [CustomView viewWithNibName:@"OrderInfoCell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        NSString *orderNum = [NSString stringWithFormat:@"%@", model.code];
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:model.addTime/1000];
        NSString *createTime = [date dateWithFormat:@"yyyy-MM-dd hh:mm"];
        NSString *payTime = @"";
        NSString *sendTime = @"";
        NSString *dealTime = @"";
        NSString *text = [NSString stringWithFormat:@"订单编号:%@\n创建时间:%@\n付款时间:%@\n发货时间:%@\n成交时间:%@", orderNum, createTime, payTime, sendTime, dealTime];
        NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:text];
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


- (void)shipSuccess:(NSNotification *)notify {

    _tag = 2;
    [self.tableView reloadData];
}
@end
