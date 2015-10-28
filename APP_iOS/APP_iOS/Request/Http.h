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
#import "UserModel.h"
#import "GoodModel.h"

@interface Http : NSObject

+ (Http *)instance;

//登录接口，error.code == 1代表正确
- (void)login:(NSString *)userName pwd:(NSString *)pwd completion:(void(^)(NSError *error, UserModel *user))completion;

//主页界面接口
- (void)main:(NSString *)shopId completion:(void(^)(NSError *error, MainModel *main))completion;

//我的店铺接口
- (void)myShop:(NSString *)shopId completion:(void(^)(NSError *error, ShopModel *shop))completion;

//店铺修改接口
- (void)modifyMyshop:(NSString *)shopId name:(NSString *)name pic:(NSString *)pic addr:(NSString *)addr linkman:(NSString *)linkman linkphone:(NSString *)linkphone completion:(void(^)(NSError *error))completion;

//店铺延长时间接口
- (void)postpone:(NSString *)shopid month:(NSInteger)month completion:(void(^)(NSError *error))completion;

//店铺修改密码接口
- (void)modifyPwd:(NSString *)shopid oldpwd:(NSString *)oldpwd newpwd:(NSString *)newpwd completion:(void(^)(NSError *error))completion;

//商品列表接口
//stat 商品状态，1：出售中，2：已下架，3：已推荐，4：未推荐 跟平台端对应
//page默认1开始
//dataArray存储GoodModel
- (void)goodsList:(NSString *)shopid stat:(NSInteger)stat count:(NSInteger)count page:(NSInteger)page completion:(void(^)(NSError *error, NSArray *dataArray))completion;

@end
