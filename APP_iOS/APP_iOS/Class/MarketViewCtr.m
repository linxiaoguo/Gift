//
//  MarketViewCtr.m
//  APP_iOS
//
//  Created by 林小果 on 15/11/10.
//  Copyright © 2015年 Li. All rights reserved.
//

#import "MarketViewCtr.h"
#import "TestHttpViewCtr.h"
#import "GoodsTableViewCell.h"
#import "AddGoodsViewController.h"
#import "GoodsTableViewCell.h"
#import "GoodModel.h"
#import "BaseWebViewController.h"
#import "UMSocial.h"

@interface MarketViewCtr () <UMSocialUIDelegate>
@property (nonatomic, copy) NSString *stat;     //1-已推荐 0-未推荐

@property (nonatomic, assign) NSInteger page;
@property (nonatomic, assign) NSInteger pageSize;

@property (nonatomic, strong) NSMutableDictionary *selectDic;
@property (nonatomic, assign) NSInteger selectRow;

@property (nonatomic, strong) IBOutlet UIView *viewAdd;
@end

@implementation MarketViewCtr

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"营销管理"];
    
    _page = 1;
    _pageSize = 20;
    _selectRow = -1;
    
    UIView *headerView = [UIView new];
    headerView.frame = CGRectMake(0, 0, kScreenWidth, 20);
    headerView.backgroundColor = [UIColor clearColor];
//    _tableView.tableHeaderView = headerView;
    
    kWEAKSELF;
    [self.tableView addLegendHeaderWithRefreshingBlock:^{
        _pageSize = 1;
        [weakSelf getData];
    }];
    
    _selectDic = [NSMutableDictionary dictionary];
    self.tableView.footer.stateHidden = YES;
    self.tableView.header.updatedTimeHidden = YES;
    self.tableView.tableFooterView = [UIView new];
    [self.tableView.header beginRefreshing];
    
    _stat = @"1";
    _viewAdd.hidden = YES;
    _tableView.tableFooterView = nil;
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


- (IBAction)testHttp:(id)sender {
    TestHttpViewCtr *vc = [[TestHttpViewCtr alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 200.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([_stat isEqualToString:@"0"]) {
        _selectRow = indexPath.row;
    } else {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        [self.tableView reloadData];
    }
    
    
//    AddGoodsViewController *vc = [[AddGoodsViewController alloc] initWithNibName:@"AddGoodsViewController" bundle:nil];
//    vc.addNewGoods = NO;
//    vc.goodModel = [self.dataSource objectAtIndex:indexPath.row];
//    [self.navigationController pushViewController:vc animated:YES];
//    NSString *rowString = [NSString stringWithFormat:@"row-%ld", (long)indexPath.row];
//    BOOL isSelect = [[_selectDic objectForKey:rowString] boolValue];
//    if (isSelect) {
//        [_selectDic setObject:[NSNumber numberWithBool:NO] forKey:rowString];
//    } else {
//        [_selectDic setObject:[NSNumber numberWithBool:YES] forKey:rowString];
//    }
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
    cell.backgroundColor = [UIColor clearColor];
    cell.accessImageView.hidden = NO;
    cell.goodModel = [self.dataSource objectAtIndex:indexPath.row];
    
//    if ([_stat isEqualToString:@"0"]) {
//        NSString *rowString = [NSString stringWithFormat:@"row-%ld", (long)indexPath.row];
//        BOOL isSelect = [[_selectDic objectForKey:rowString] boolValue];
//        if (isSelect) {
//            cell.accessoryType = UITableViewCellAccessoryCheckmark;
//        } else {
//            cell.accessoryType = UITableViewCellAccessoryNone;
//        }
//        cell.accessImageView.hidden = YES;
//    }
    GoodModel *goodModel = [self.dataSource objectAtIndex:indexPath.row];
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
        [SVProgressHUD show];
        
        [[Http instance] goodsQrcode:goodModel.id completion:^(NSError *error, NSString *goodsAddr, NSString *qrcodeImg) {
            if (error.code == 0) {
                [SVProgressHUD dismiss];
                
                [UMSocialData defaultData].extConfig.wxMessageType = UMSocialWXMessageTypeWeb;
                [UMSocialData defaultData].extConfig.wechatSessionData.title = @"天天好礼商城";
                
                [UMSocialData defaultData].extConfig.wechatSessionData.url = goodsAddr;
                [UMSocialData defaultData].extConfig.wechatTimelineData.url = goodsAddr;
                
                NSString *shareText = goodModel.name;             //分享内嵌文字
                UIImage *shareImage = cell.headImage.image;          //分享内嵌图片
                
                //调用快速分享接口
                [UMSocialSnsService presentSnsIconSheetView:self
                                                     appKey:@"564a844ee0f55ad251008b90"
                                                  shareText:shareText
                                                 shareImage:shareImage
                                            shareToSnsNames:@[UMShareToWechatSession, UMShareToWechatTimeline]
                                                   delegate:self];
            }
            else {
                [SVProgressHUD showErrorWithStatus:@"获取商品失败"];
            }
        }];
    }];

    return cell;
}


#pragma mark - 切换UISegmentedControl
- (IBAction)stateAction:(UISegmentedControl *)sender {
    if (sender.selectedSegmentIndex == 0) {
        _stat = @"1";
        _viewAdd.hidden = YES;
        _tableView.tableFooterView = nil;
    }
    else {
        _stat = @"0";
        _viewAdd.hidden = NO;
        
        UIView *aView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _tableView.frame.size.width, 50)];
        _tableView.tableFooterView = aView;
    }
    [self.tableView.header beginRefreshing];
}

#pragma mark - 按钮事件
- (IBAction)addRecommandAction:(id)sender {
    kWEAKSELF;
    NSInteger shopId = [ShareValue instance].shopModel.shopid.integerValue;
    if (_selectRow < self.dataSource.count && _selectRow >= 0) {
        GoodModel *goods = [self.dataSource objectAtIndex:_selectRow];
        [[Http instance] recommendGoods:YES shopId:shopId goodsId:goods.id completion:^(NSError *error) {
            if (error.code == 0) {
                [SVProgressHUD showSuccessWithStatus:@"添加成功"];
                [weakSelf.tableView.header beginRefreshing];
            }
            
        }];
    }
}

#pragma mark - 获取数据
- (void)getData {
    [[Http instance] goodsList:[ShareValue instance].shopModel.shopid.integerValue stat:1 count:1000 page:1 recommend:[_stat boolValue] completion:^(NSError *error, NSArray *dataArray) {
        if (error.code == 0) {
            if (self.page == 1) {
                [self.dataSource removeAllObjects];
            }
            [self.dataSource addObjectsFromArray:dataArray];
            
            [self.tableView reloadData];
        }
        [self.tableView.header endRefreshing];
    }];
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
@end
