//
//  TestHttpViewCtr.m
//  APP_iOS
//
//  Created by 林小果 on 15/11/9.
//  Copyright © 2015年 Li. All rights reserved.
//

#import "TestHttpViewCtr.h"
#import "Http.h"

@interface TestHttpViewCtr ()

@property (nonatomic, strong)NSMutableArray *titles;
@property (nonatomic, strong)NSMutableArray *actions;
@end

@implementation TestHttpViewCtr

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    _titles = [NSMutableArray arrayWithObjects:@"登录", @"首页", @"我的店铺", @"店铺修改", @"店铺延长时间",
               @"店铺修改密码", @"商品列表", @"商品类型列表", @"商品主题列表", @"上传文件(未实现)",
               @"添加商品", @"商品详情", @"商品修改", @"商品上下架", @"推荐商品",
               @"商品二维码",
               @"订单管理", @"订单列表", @"订单详情", @"订单统计列表", @"订单发货",
               @"收入管理", @"申请提现", @"提现列表", @"银行列表", @"绑定银行卡",
               @"系统公告", @"版本更新", nil];
    
    _actions = [NSMutableArray arrayWithObjects:@"login", @"main", @"myShop", @"modifyMyshop", @"postpone",
                @"modifyPwd", @"goodsList", @"goodsTypeList", @"goodsTopicList", @"uploadFile",
                @"addGoods", @"goodsDetail", @"goodsModify", @"statusGoods", @"recommendGoods",
                @"goodsQrcode",
                @"order", @"orderList", @"orderDetail", @"logisticsList", @"ship",
                @"income", @"withdraw", @"withdrawList", @"bankList", @"bindBank",
                @"messageList", @"queryVersion", nil];}

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
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _titles.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"testHttp";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    NSString *title = @"";
    if (indexPath.row < _titles.count)
        title = [_titles objectAtIndex:indexPath.row];
    cell.textLabel.text = title;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];
    
    NSString *action = @"";
    if (indexPath.row < _actions.count)
        action = [_actions objectAtIndex:indexPath.row];
    SEL sel = NSSelectorFromString(action);
    if ([self respondsToSelector:sel])
        [self performSelector:sel];
}

- (void)login {
    [[Http instance] login:@"admin" pwd:@"heyeah" completion:^(NSError *error, ShopModel *shop) {
        if (error.code == 0) {
            NSLog(@"登陆成功，用户名字：%@", shop.name);
        }
    }];
}

- (void)logout {

}

- (void)main {
    [[Http instance] main:32768 completion:^(NSError *error, MainModel *main) {
        NSLog(@"首页接口今日买家：%@", main.buyer);
    }];
}

- (void)myShop {
    [[Http instance] myShop:32768 completion:^(NSError *error, ShopModel *shop) {
        if (error.code == 0) {
            NSLog(@"我的店铺shopid：%@", shop.shopid);
        }
    }];
}

- (void)modifyMyshop {    
    [[Http instance] modifyMyshop:32768 name:@"我的店铺2" pic:@"426308" addr:nil linkman:@"小张" linkphone:@"12345678901" completion:^(NSError *error) {
       NSLog(@"修改我的店铺：%@", error.domain);
    }];
}

- (void)postpone {
    [[Http instance] postpone:32768 month:1 completion:^(NSError *error) {
        NSLog(@"延长店铺时间：%@", error.domain);
    }];
}

- (void)modifyPwd{
    [[Http instance] modifyPwd:32768 oldpwd:@"123456" newpwd:@"1234567" completion:^(NSError *error) {
        NSLog(@"修改我的密码：%@", error.domain);
    }];
}

- (void)goodsList {
    [[Http instance] goodsList:32768 stat:1 count:10 page:1 recommend:YES completion:^(NSError *error, NSArray *dataArray) {
        NSLog(@"商品列表：%lu", (unsigned long)dataArray.count);
    }];
}

- (void)goodsTypeList {
    [[Http instance] goodsTypeList:^(NSError *error, NSArray *dataArray) {
        NSLog(@"商品类型：%lu", (unsigned long)dataArray.count);
    }];
}

- (void)goodsTopicList {
    [[Http instance] goodsTopicList:^(NSError *error, NSArray *dataArray) {
        NSLog(@"商品主题：%lu", (unsigned long)dataArray.count);
    }];
}

- (void)uploadFile {
    
}

- (void)addGoods {
    [[Http instance] addGoods:32768 name:@"商品1" typeId:1 topicId:1 isrecommand:YES price:10 stock:10 fileids:nil completion:^(NSError *error) {
        NSLog(@"添加商品：%@", error.domain);
    }];
}

- (void)goodsDetail {
    [[Http instance] goodsDetail:32768 goodsId:98471 completion:^(NSError *error, GoodModel *goods) {
        NSLog(@"商品详情：%@", goods.name);
    }];
}

- (void)goodsModify {
    [[Http instance] goodsModify:32768 goodsId:98524 name:@"商品新名称" typeId:1 topicId:1 isrecommand:YES price:100 stock:10 fileids:nil completion:^(NSError *error) {
        NSLog(@"修改商品：%@", error.domain);
    }];
}

- (void)statusGoods {
    [[Http instance] statusGoods:1 shopId:32768 goodsId:98524 completion:^(NSError *error) {
        NSLog(@"商品上架：%@", error.domain);
    }];
}

- (void)recommendGoods {
    [[Http instance] recommendGoods:YES shopId:32768 goodsId:98524 completion:^(NSError *error) {
       NSLog(@"推荐商品：%@", error.domain);
    }];
}

- (void)goodsQrcode {
    [[Http instance] goodsQrcode:98524 completion:^(NSError *error, NSString *goodsAddr, NSString *qrcodeImg) {
       NSLog(@"商品二维码%@, %@", goodsAddr, qrcodeImg);
    }];
}

- (void)order {
    [[Http instance] order:32768 completion:^(NSError *error, OrderTotalModel *order) {
       NSLog(@"订单管理：%@", error.domain);
    }];
}

- (void)orderList {
    [[Http instance] orderList:32768 stat:10 pageSize:20 page:1 completion:^(NSError *error, NSArray *dataArray) {
        NSLog(@"订单列表%lu", (unsigned long)dataArray.count);
    }];
}

- (void)orderDetail {
    [[Http instance] orderDetail:32768 orderId:1 completion:^(NSError *error, OrderModel *order) {
       NSLog(@"订单详情：%@", error.domain);
    }];
}

- (void)logisticsList {
    [[Http instance] logisticsList:^(NSError *error, NSArray *dataArray) {
       NSLog(@"订单统计列表%lu", (unsigned long)dataArray.count);
    }];
}

- (void)ship {
    [[Http instance] ship:32768 logId:1 shipCode:@"" desc:@"快点到" completion:^(NSError *error) {
           NSLog(@"订单发货：%@", error.domain);
    }];
}

- (void)income {
    [[Http instance] income:32768 completion:^(NSError *error, IncomeTotalModel2 *incomeTotal) {
                   NSLog(@"收入管理：%ld", (long)incomeTotal.totalInMoney);
    }];
}

- (void)withdraw {
    [[Http instance] withdraw:32768 money:100 completion:^(NSError *error) {
           NSLog(@"提现：%@", error.domain);
    }];
}

- (void)withdrawList {
    [[Http instance] withdrawList:32768 count:20 page:1 completion:^(NSError *error, IncomeTotalModel *incomeTotal) {
       NSLog(@"提现列表：%@", error.domain);
    }];
}

- (void)bankList {
    [[Http instance] bankList:^(NSError *error, NSArray *dataArray) {
                   NSLog(@"银行列表：%ld", (long)dataArray.count);
    }];
}

- (void)bindBank {
    [[Http instance] bindBank:32768 name:@"林小果" idcard:@"12334567890" bank:@"中国测试银行" card:@"1234567890" completion:^(NSError *error) {
               NSLog(@"绑定银行：%@", error.domain);
    }];
}

- (void)messageList {
    [[Http instance] messageList:32768 count:20 page:1 completion:^(NSError *error, NSArray *dataArray) {
       NSLog(@"消息列表：%ld", (long)dataArray.count);
    }];
}

- (void)queryVersion {
    [[Http instance] queryVersion:1 completion:^(NSError *error, VersionModel *version) {
        NSLog(@"版本更新：%@", version.versionname);
    }];
}
@end
