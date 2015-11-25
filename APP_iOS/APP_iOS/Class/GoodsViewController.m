//
//  GoodsViewController.m
//  APP_iOS
//
//  Created by Li on 15/10/13.
//  Copyright © 2015年 Li. All rights reserved.
//

#import "GoodsViewController.h"
#import "GoodsTableViewCell.h"
#import "AddGoodsViewController.h"
#import "GoodModel.h"
#import "BaseWebViewController.h"
#import "UMSocial.h"

@interface GoodsViewController ()<UMSocialUIDelegate> {
    UILabel *_countLabel;
}

@property (nonatomic, copy) NSString *stat;     //1-出售中 0-已下架

@property (nonatomic, assign) NSInteger page;
@property (nonatomic, assign) NSInteger pageSize;

@end

@implementation GoodsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"商品管理";
    
    //    [self setRightBarButtonWithImage:[UIImage imageNamed:@"search-icon"] withHighlightedImage:nil withBlock:^(NSInteger tag) {
    //    }];
    
    _stat = @"1";
    _page = 1;
    _pageSize = 20;
    
    UIView *headerView = [UIView new];
    headerView.frame = CGRectMake(0, 0, kScreenWidth, 20);
    headerView.backgroundColor = [UIColor clearColor];
    _countLabel = [UILabel new];
    _countLabel.frame = CGRectMake(0, 0, kScreenWidth, 12);
    _countLabel.textAlignment = NSTextAlignmentCenter;
    _countLabel.textColor = [UIColor darkGrayColor];
    _countLabel.font = [UIFont systemFontOfSize:12];
    [headerView addSubview:_countLabel];
    _tableView.tableHeaderView = headerView;
    
    kWEAKSELF;
    [self.tableView addLegendHeaderWithRefreshingBlock:^{
        _pageSize = 1;
        [weakSelf goodsListRequest:YES];
    }];
    //    [self.tableView addLegendFooterWithRefreshingBlock:^{
    //        [weakSelf goodsListRequest:NO];
    //    }];
    self.tableView.footer.stateHidden = YES;
    self.tableView.header.updatedTimeHidden = YES;
    self.tableView.tableFooterView = [UIView new];
    [self.tableView.header beginRefreshing];
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

- (IBAction)stateAction:(UISegmentedControl *)sender {
    if (sender.selectedSegmentIndex == 0) {
        _stat = @"1";
    }
    else {
        _stat = @"0";
    }
    [self.tableView.header beginRefreshing];
}

- (IBAction)addGoodsAction:(id)sender {
    AddGoodsViewController *vc = [[AddGoodsViewController alloc] initWithNibName:@"AddGoodsViewController" bundle:nil];
    vc.addNewGoods = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 190.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    AddGoodsViewController *vc = [[AddGoodsViewController alloc] initWithNibName:@"AddGoodsViewController" bundle:nil];
    vc.addNewGoods = NO;
    vc.goodModel = [self.dataSource objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"GoodsTableViewCell";
    
    GoodsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        [tableView registerNib:[UINib nibWithNibName:@"GoodsTableViewCell" bundle:nil] forCellReuseIdentifier:identifier];
        cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    GoodModel *goodModel = [self.dataSource objectAtIndex:indexPath.row];
    cell.goodModel = goodModel;
    
    [cell.btn0 addActionHandler:^(NSInteger tag) {
        [SVProgressHUD show];
        
        [[Http instance] goodsQrcode:goodModel.id completion:^(NSError *error, NSString *goodsAddr, NSString *qrcodeImg) {
            if (error.code == 0) {
                BaseWebViewController *vc = [[BaseWebViewController alloc] initWithNibName:@"BaseWebViewController" bundle:nil];
                vc.urlStr = goodsAddr;
                [self.navigationController pushViewController:vc animated:YES];
            }
            else {
                [SVProgressHUD showErrorWithStatus:@"获取店铺详情失败"];
            }
            [SVProgressHUD dismiss];
        }];
    }];
    [cell.btn1 addActionHandler:^(NSInteger tag) {
        [SVProgressHUD show];
        
        [[Http instance] goodsQrcode:goodModel.id completion:^(NSError *error, NSString *goodsAddr, NSString *qrcodeImg) {
            if (error.code == 0) {
                [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:qrcodeImg] options:SDWebImageRefreshCached progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                    
                    
                } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
                }];
                
            }
            else {
                [SVProgressHUD showErrorWithStatus:@"获取二维码失败"];
            }
        }];
    }];
    [cell.btn2 addActionHandler:^(NSInteger tag) {
        [SVProgressHUD show];
        
        [[Http instance] goodsQrcode:goodModel.id completion:^(NSError *error, NSString *goodsAddr, NSString *qrcodeImg) {
            if (error.code == 0) {
                UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
                pasteboard.string = qrcodeImg;
                
                [SVProgressHUD showSuccessWithStatus:@"复制成功"];
            }
            else {
                [SVProgressHUD showErrorWithStatus:@"获取二维码失败"];
            }
        }];
    }];
    [cell.btn3 addActionHandler:^(NSInteger tag) {
        NSString *shareText = goodModel.name;             //分享内嵌文字
        UIImage *shareImage = [UIImage imageNamed:goodModel.pic];          //分享内嵌图片
        
        //调用快速分享接口
        [UMSocialSnsService presentSnsIconSheetView:self
                                             appKey:@"564a844ee0f55ad251008b90"
                                          shareText:shareText
                                         shareImage:shareImage
                                    shareToSnsNames:@[UMShareToWechatSession, UMShareToWechatTimeline]
                                           delegate:self];
    }];
    
    return cell;
}

- (void)image: (UIImage *) image didFinishSavingWithError: (NSError *) error contextInfo: (void *) contextInfo {
    NSString *msg = nil ;
    if(error != NULL) {
        msg = @"下载失败" ;
        [SVProgressHUD showErrorWithStatus:msg];
    }
    else {
        msg = @"下载成功" ;
        [SVProgressHUD showSuccessWithStatus:msg];
    }
}

//实现回调方法（可选）：
-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
{
    //根据`responseCode`得到发送结果,如果分享成功
    if(response.responseCode == UMSResponseCodeSuccess)
    {
        //得到分享到的微博平台名
        NSLog(@"share to sns name is %@",[[response.data allKeys] objectAtIndex:0]);
    }
}

#pragma mark - Request

- (void)goodsListRequest:(BOOL)reload {
    [[Http instance] goodsList:[ShareValue instance].shopModel.shopid.integerValue stat:_stat.integerValue count:1000 page:1 recommend:YES completion:^(NSError *error, NSArray *dataArray) {
        if (error.code == 0) {
            if (self.page == 1) {
                [self.dataSource removeAllObjects];
            }
            [self.dataSource addObjectsFromArray:dataArray];
            _countLabel.text = [NSString stringWithFormat:@"共%lu个产品", (unsigned long)self.dataSource.count];
            
            [self.tableView reloadData];
        }
        [self.tableView.header endRefreshing];
    }];
}

@end
