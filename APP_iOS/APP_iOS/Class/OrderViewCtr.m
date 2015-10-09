//
//  OrderViewCtr.m
//  APP_iOS
//
//  Created by 林小果 on 15/10/2.
//  Copyright (c) 2015年 Li. All rights reserved.
//

#import "OrderViewCtr.h"
#import "OrderHeadCell.h"
#import "OrderCell.h"

@interface OrderViewCtr ()

@property (nonatomic, strong)IBOutlet UITableView *tableView;
@property (nonatomic, strong)IBOutlet UIView *vHeader;
@property (nonatomic, strong)IBOutlet OrderHeadCell *waitSend;
@property (nonatomic, strong)IBOutlet OrderHeadCell *waitPay;
@property (nonatomic, strong)IBOutlet OrderHeadCell *alreadySend;
@property (nonatomic, strong)IBOutlet OrderHeadCell *alreadyDone;
@property (nonatomic, strong)NSMutableArray *marOderHeaderCell;
@end

@implementation OrderViewCtr

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"订单管理"];
    kWEAKSELF;
    [self setLeftBarButtonWithTitle:@"返回" withBlock:^(NSInteger tag) {
        [weakSelf backAction];
    }];
    
    _marOderHeaderCell = [NSMutableArray array];
    _waitSend = [CustomView viewWithNibName:@"OrderHeadCell"];
    _waitPay = [CustomView viewWithNibName:@"OrderHeadCell"];
    _alreadySend = [CustomView viewWithNibName:@"OrderHeadCell"];
    _alreadyDone = [CustomView viewWithNibName:@"OrderHeadCell"];
    
    for (NSInteger i=1; i<4; i++) {
        UIImageView *line = [[UIImageView alloc] init];
        [_vHeader addSubview:line];
        [line setBackgroundColor:[UIColor darkGrayColor]];
        [line setTag:100+i];
    }
    [_vHeader addSubview:_waitSend];
    [_vHeader addSubview:_waitPay];
    [_vHeader addSubview:_alreadySend];
    [_vHeader addSubview:_alreadyDone];
    [_waitSend setSelected:YES];
    [_waitPay.lblTitle setText:@"待支付"];
    [_alreadySend.lblTitle setText:@"已发货"];
    [_alreadyDone.lblTitle setText:@"已完成"];
    [_marOderHeaderCell addObject:_waitSend];
    [_marOderHeaderCell addObject:_waitPay];
    [_marOderHeaderCell addObject:_alreadySend];
    [_marOderHeaderCell addObject:_alreadyDone];
    
    for (NSInteger i=0; i<_marOderHeaderCell.count; i++) {
        OrderHeadCell *cell = [_marOderHeaderCell objectAtIndex:i];
        [cell.btnBg addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [cell.btnBg setTag:i];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat w = _vHeader.frame.size.width / 4;
    CGFloat h = _vHeader.frame.size.height;
    for (NSInteger i=0; i<_marOderHeaderCell.count; i++) {
        OrderHeadCell *cell = [_marOderHeaderCell objectAtIndex:i];
        cell.frame = CGRectMake(x + w * i - 1, y, w + 2, h);
        UIImageView *line = (UIImageView *)[_vHeader viewWithTag:100+i];
        line.frame = CGRectMake(x + w * i - 1, 10, 1, h - 20);
    }
}

- (void)btnClick:(UIButton *)sender {
    [self setSelectIndex:sender.tag];
}

- (void)setSelectIndex:(NSInteger)index {
    for (NSInteger i=0; i<_marOderHeaderCell.count; i++) {
        OrderHeadCell *cell = [_marOderHeaderCell objectAtIndex:i];
        if (index == i)
            [cell setSelected:YES];
        else
            [cell setSelected:NO];
    }
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
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 155;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {        static NSString *identifier=@"OrderCell";
    OrderCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [CustomView viewWithNibName:@"OrderCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];
    
    
}

@end
