//
//  Http.h
//  APP_iOS
//
//  Created by 林小果 on 15/10/28.
//  Copyright (c) 2015年 Li. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ShopModel.h"
#import "MainModel.h"
#import "GoodModel.h"
#import "GoodTypeModel.h"
#import "GoodsTopicModel.h"
#import "FieldModel.h"
#import "OrderModel.h"
#import "OrderTotalModel.h"
#import "logisticsModel.h"
#import "IncomeModel.h"
#import "BankModel.h"
#import "MessageModel.h"
#import "VersionModel.h"

@interface Http : NSObject

+ (Http *)instance;

//登录接口，error.code == 0代表正确
- (void)login:(NSString *)userName pwd:(NSString *)pwd completion:(void(^)(NSError *error, ShopModel *shop))completion;

//主页界面接口
- (void)main:(NSInteger)shopId completion:(void(^)(NSError *error, MainModel *main))completion;

//我的店铺接口
- (void)myShop:(NSInteger)shopId completion:(void(^)(NSError *error, ShopModel *shop))completion;

//店铺修改接口
//name 店铺名称
//picid 商家图片地址(图片ID)
//addr 店铺实体地址
//linkman 联系人
//linkphone 联系电话
- (void)modifyMyshop:(NSInteger)shopId name:(NSString *)name pic:(NSString *)pic addr:(NSString *)addr linkman:(NSString *)linkman linkphone:(NSString *)linkphone completion:(void(^)(NSError *error))completion;

//店铺延长时间接口
- (void)postpone:(NSInteger)shopId month:(NSInteger)month completion:(void(^)(NSError *error))completion;

//店铺修改密码接口
- (void)modifyPwd:(NSInteger)shopId oldpwd:(NSString *)oldpwd newpwd:(NSString *)newpwd completion:(void(^)(NSError *error))completion;

//商品列表接口
//stat 商品状态，1：出售中，0：已下架
//page默认1开始
//dataArray存储GoodModel
//recommend1推荐，0不推荐
//dataArray存储GoodModel
- (void)goodsList:(NSInteger)shopId stat:(NSInteger)stat count:(NSInteger)count page:(NSInteger)page recommend:(BOOL)recommend completion:(void(^)(NSError *error, NSArray *dataArray))completion;


//商品类型接口
//dataArray存储GoodTypeModel
- (void)goodsTypeList:(void(^)(NSError *error, NSArray *dataArray))completion;

//商品主题馆列表接口
//dataArray存储GoodsTopicModel
- (void)goodsTopicList:(void(^)(NSError *error, NSArray *dataArray))completion;

//上传文件接口
//mname：theme store
//dataArray存储FieldModel
- (void)uploadFile:(NSString *)fileId uploadFile:(NSData *)uploadFile mname:(NSString *)mname completion:(void(^)(NSError *error, FieldModel *fieldModel))completion;

//添加商品接口
//shopId 商家id
//name 商品名称
//typeId 商品类型id
//topicId 商品主题id
//isrecommand 是否推荐
//price 价格
//stock 库存
//fileids 商品图片集
- (void)addGoods:(NSInteger)shopId name:(NSString *)name typeId:(NSInteger)typeId topicId:(NSInteger)topicId isrecommand:(BOOL)isrecommand price:(CGFloat)price stock:(NSInteger)stock fileids:(NSArray *)fileids completion:(void(^)(NSError *error))completion;

//商品详情接口
- (void)goodsDetail:(NSInteger)shopId goodsId:(NSInteger)goodsId completion:(void(^)(NSError *error, GoodModel *goods))completion;

//商品修改接口
- (void)goodsModify:(NSInteger)shopId goodsId:(NSInteger)goodsId name:(NSString *)name typeId:(NSInteger)typeId topicId:(NSInteger)topicId isrecommand:(BOOL)isrecommand price:(CGFloat)price stock:(NSInteger)stock fileids:(NSArray *)fileids completion:(void(^)(NSError *error))completion;

//商品上下架
//status 0表示下架，1 表示上架
- (void)statusGoods:(NSInteger)status shopId:(NSInteger)shopId goodsId:(NSInteger)goodsId completion:(void(^)(NSError *error))completion;

//推荐商品
//recommend 0表示不推荐，1 表示推荐
- (void)recommendGoods:(BOOL)recommend shopId:(NSInteger)shopId goodsId:(NSInteger)goodsId completion:(void(^)(NSError *error))completion;

//订单管理
- (void)order:(NSInteger)shopId completion:(void(^)(NSError *error, OrderTotalModel *order))completion;

//订单列表
//stat 订单状态，10：待付款，20：待发货，40：已发货，60：已完成
//page 从1开始
//dataArray 存储 OrderModel
- (void)orderList:(NSInteger)shopId stat:(NSInteger)stat pageSize:(NSInteger)pageSize page:(NSInteger)page completion:(void(^)(NSError *error, NSArray *dataArray))completion;

//订单详情
- (void)orderDetail:(NSInteger)shopId orderId:(NSInteger)orderId completion:(void(^)(NSError *error, OrderModel *order))completion;


//订单统计列表
//dataArray存储
- (void)logisticsList:(void(^)(NSError *error, NSArray *dataArray))completion;

//订单发货接口
- (void)ship:(NSInteger)orderId logId:(NSInteger)logId shipCode:(NSString *)shipCode desc:(NSString *)desc completion:(void(^)(NSError *error))completion;

//收入管理
- (void)income:(NSInteger)shopId completion:(void(^)(NSError *error, IncomeTotalModel *incomeTotal))completion;

//申请提现
- (void)withdraw:(NSInteger)shopId money:(CGFloat)money completion:(void(^)(NSError *error))completion;

//提现列表接口
- (void)withdrawList:(NSInteger)shopId count:(NSInteger)count page:(NSInteger)page completion:(void(^)(NSError *error, IncomeTotalModel *incomeTotal))completion;

//银行列表
//dataArray存储BankModel
- (void)bankList:(void(^)(NSError *error, NSArray *dataArray))completion;

//绑定银行卡
- (void)bindBank:(NSInteger)shopId name:(NSString *)name idcard:(NSString *)idcard bank:(NSString *)bank card:(NSString *)card completion:(void(^)(NSError *error))completion;


//系统公告
//dataArray存储MessageModel
- (void)messageList:(NSInteger)shopId count:(NSInteger)count page:(NSInteger)page completion:(void(^)(NSError *error, NSArray *dataArray))completion;

//版本更新
- (void)queryVersion:(NSInteger)version completion:(void(^)(NSError *error, VersionModel *version))completion;
@end
