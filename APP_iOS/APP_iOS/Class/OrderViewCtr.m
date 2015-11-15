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
#import "OrderDetailViewCtr.h"

@interface OrderViewCtr ()

@property (nonatomic, strong)IBOutlet UIScrollView *scrollView;
@property (nonatomic, strong)IBOutlet UITableView *tbvWait;
@property (nonatomic, strong)IBOutlet UITableView *tbvPay;
@property (nonatomic, strong)IBOutlet UITableView *tbvAlreadySend;
@property (nonatomic, strong)IBOutlet UITableView *tbvAlreadyDone;
@property (nonatomic, strong)IBOutlet NSMutableArray *tableViewArray;

@property (nonatomic, strong)IBOutlet UIView *vHeader;
@property (nonatomic, strong)IBOutlet OrderHeadCell *waitSend;
@property (nonatomic, strong)IBOutlet OrderHeadCell *waitPay;
@property (nonatomic, strong)IBOutlet OrderHeadCell *alreadySend;
@property (nonatomic, strong)IBOutlet OrderHeadCell *alreadyDone;
@property (nonatomic, strong)UIImageView *selectImageView;
@property (nonatomic, strong)IBOutlet NSMutableArray *cellArray;

@property (nonatomic, assign)BOOL isAnimation;

@end

@implementation OrderViewCtr

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"订单管理"];
    
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.pagingEnabled = YES;
    
    _cellArray = [NSMutableArray array];
    _tableViewArray = [NSMutableArray array];
    
    [_vHeader setBackgroundColor:kRGBCOLOR(230, 230, 230)];
    _waitSend = [CustomView viewWithNibName:@"OrderHeadCell"];
    _waitPay = [CustomView viewWithNibName:@"OrderHeadCell"];
    _alreadySend = [CustomView viewWithNibName:@"OrderHeadCell"];
    _alreadyDone = [CustomView viewWithNibName:@"OrderHeadCell"];
    _selectImageView = [[UIImageView alloc] init];
    _selectImageView.backgroundColor = [UIColor lightGrayColor];
    
    [_vHeader addSubview:_selectImageView];
    [_vHeader addSubview:_waitSend];
    [_vHeader addSubview:_waitPay];
    [_vHeader addSubview:_alreadySend];
    [_vHeader addSubview:_alreadyDone];
    [_waitSend setSelected:YES];
    _waitSend.imvLine.hidden = YES;
    [_waitPay.lblTitle setText:@"待支付"];
    [_alreadySend.lblTitle setText:@"已发货"];
    [_alreadyDone.lblTitle setText:@"已完成"];
    [_cellArray addObject:_waitSend];
    [_cellArray addObject:_waitPay];
    [_cellArray addObject:_alreadySend];
    [_cellArray addObject:_alreadyDone];
    
    for (NSInteger i=0; i<_cellArray.count; i++) {
        OrderHeadCell *cell = [_cellArray objectAtIndex:i];
        [cell.btnBg addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [cell.btnBg setTag:i];
    }
    
    _tbvWait = [[UITableView alloc] init];
    _tbvPay = [[UITableView alloc] init];
    _tbvAlreadySend = [[UITableView alloc] init];
    _tbvAlreadyDone = [[UITableView alloc] init];
    [_scrollView addSubview:_tbvWait];
    [_scrollView addSubview:_tbvPay];
    [_scrollView addSubview:_tbvAlreadySend];
    [_scrollView addSubview:_tbvAlreadyDone];
    [_tableViewArray addObject:_tbvWait];
    [_tableViewArray addObject:_tbvPay];
    [_tableViewArray addObject:_tbvAlreadySend];
    [_tableViewArray addObject:_tbvAlreadyDone];
    for (NSInteger i=0; i<_tableViewArray.count; i++) {
        UITableView *tbv = [_tableViewArray objectAtIndex:i];
        tbv.delegate = self;
        tbv.dataSource = self;
        tbv.separatorStyle = UITableViewCellSeparatorStyleNone;
        tbv.showsHorizontalScrollIndicator = NO;
        tbv.showsVerticalScrollIndicator = NO;
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
    for (NSInteger i=0; i<_cellArray.count; i++) {
        OrderHeadCell *cell = [_cellArray objectAtIndex:i];
        cell.frame = CGRectMake(x + w * i, y, w, h);
    }
    _selectImageView.frame = CGRectMake(x-1, y, w+2, h);
    
    x = 0;
    y = 0;
    w = _scrollView.frame.size.width;
    h = _scrollView.frame.size.height;
    for (NSInteger i=0; i<_tableViewArray.count; i++) {
        UITableView *tbv = [_tableViewArray objectAtIndex:i];
        CGRect rect = CGRectMake(x+w*i, y, w, h);
        [tbv setFrame:rect];
    }
    
    _scrollView.contentSize = CGSizeMake(w*4, h);
}

- (void)btnClick:(UIButton *)sender {
    [self setSelectIndex:sender.tag];
    
    CGFloat x = _scrollView.frame.origin.x;
    CGFloat y = _scrollView.frame.origin.y;
    CGFloat w = _scrollView.frame.size.width;
    CGFloat h = _scrollView.frame.size.height;

    NSInteger tag = sender.tag;
    [_scrollView scrollRectToVisible:CGRectMake(x + w * tag, y, w, h) animated:YES];
}

- (void)setSelectIndex:(NSInteger)index {
    
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat w = _vHeader.frame.size.width / 4;
    CGFloat h = _vHeader.frame.size.height;
    
    if (_isAnimation) {
        return;
    }
    _isAnimation = YES;
    
    [UIView animateWithDuration:0.25 animations:^{
        _selectImageView.frame = CGRectMake(x + w * index - 1, y, w+2, h);
        
        for (NSInteger i=0; i<_cellArray.count; i++) {
            OrderHeadCell *cell = [_cellArray objectAtIndex:i];
            if (index == i)
                [cell setSelected:YES];
            else
                [cell setSelected:NO];
        }
    } completion:^(BOOL finished) {
        if (finished)
            _isAnimation = NO;
    }];
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

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier=@"OrderCell";
    OrderCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [CustomView viewWithNibName:@"OrderCell"];
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];
    
    OrderDetailViewCtr *vc = [[OrderDetailViewCtr alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == _scrollView) {
        CGFloat pageWidth = scrollView.frame.size.width;
        CGFloat x = scrollView.contentOffset.x;
        int page = floor((x - pageWidth / 2) / pageWidth) + 1;   //这一句还不是理解，但实验确实成功了
        
        [self setSelectIndex:page];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
}

@end
