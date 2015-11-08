//
//  GoodModel.h
//  APP_iOS
//
//  Created by 林小果 on 15/10/28.
//  Copyright (c) 2015年 Li. All rights reserved.
//

#import "BaseHttpRequest.h"
#import "BaseHttpResponse.h"

@interface GoodModel : NSObject

@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *stock;//库存
@property (nonatomic, copy) NSString *sales;//销量
@property (nonatomic, copy) NSString *pic;
@property (nonatomic, copy) NSString *addtime;//添加时间

@end

/**
 *  商品列表
 */
@interface GoodsListRequest : BasePageHttpRequest

@property (nonatomic, copy) NSString *shopid;
@property (nonatomic, copy) NSString *stat;

@end

@interface GoodsListResponse : BaseHttpResponse

@property (nonatomic, strong) NSArray *data;

@end
