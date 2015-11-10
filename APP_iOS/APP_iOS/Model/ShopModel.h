//
//  ShopModel.h
//  APP_iOS
//
//  Created by 林小果 on 15/10/28.
//  Copyright (c) 2015年 Li. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FieldModel.h"

@interface ShopModel : NSObject
@property (nonatomic, strong)NSString *shopid;//商家ID
@property (nonatomic, strong)NSString *name;//店铺名称
@property (nonatomic, assign)long validate;//有效时间(Long类型)
@property (nonatomic, strong)FieldModel *pic;//商家图片地址
@property (nonatomic, strong)NSString *addr;//店铺实体地址
@property (nonatomic, strong)NSString *linkman;//联系人
@property (nonatomic, strong)NSString *linkphone;//联系电话
@property (nonatomic, assign)long regdate;//注册时间
@property (nonatomic, strong)NSString *url;//网址
@property (nonatomic, assign)NSInteger status;//2 正常营业 3 违规关闭 1 等待审核 -1 拒绝审核
@property (nonatomic, assign)BOOL isbingingcard;//是否绑定银行卡
@end
