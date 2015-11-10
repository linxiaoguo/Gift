//
//  OrderModel.h
//  APP_iOS
//
//  Created by 林小果 on 15/11/8.
//  Copyright © 2015年 Li. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderModel : NSObject


@property (nonatomic, assign)NSInteger id;
@property (nonatomic, strong)NSString *code;//订单号
@property (nonatomic, assign)NSTimeInterval addTime;//下单时间
@property (nonatomic, assign)NSTimeInterval time;//下单时间
@property (nonatomic, assign)CGFloat totalPrice;//总价格
@property (nonatomic, assign)CGFloat money;//总价格 
@property (nonatomic, assign)CGFloat freight;//运费
@property (nonatomic, assign)NSInteger total;//总件数
@property (nonatomic, assign)NSInteger addrid;//收件地址id
@property (nonatomic, strong)NSString *addrname;//收件人名字
@property (nonatomic, strong)NSString *addrmobile;
@property (nonatomic, strong)NSString *addr;
@property (nonatomic, strong)NSString *logname;//物流名称
@property (nonatomic, strong)NSString *number;//物流单号
@property (nonatomic, strong)NSArray *goods;//订单商品列表
@property (nonatomic, strong)NSArray *pic;//图片列表
@end
