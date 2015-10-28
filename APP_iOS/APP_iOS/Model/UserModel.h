//
//  UserModel.h
//  APP_iOS
//
//  Created by 林小果 on 15/10/28.
//  Copyright (c) 2015年 Li. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserModel : NSObject
@property (nonatomic, strong)NSString *shopid;//商家ID
@property (nonatomic, strong)NSString *name;//店铺名称
@property (nonatomic, strong)NSString *validate;//有效时间
@property (nonatomic, strong)NSString *pic;//商家图片地址
@property (nonatomic, strong)NSString *addr;//店铺实体地址
@property (nonatomic, strong)NSString *linkman;//联系人
@property (nonatomic, strong)NSString *linkphone;//联系电话
@property (nonatomic, strong)NSString *regdate;//注册时间
@property (nonatomic, strong)NSString *url;//网址
@property (nonatomic, strong)NSString *status;//店铺状态，0：关闭，1：开启
@property (nonatomic, strong)NSString *isbingingcard;//是否绑定银行卡信息
@end
