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

@property (nonatomic, assign) NSInteger id;
@property (nonatomic, copy)   NSString *name;
@property (nonatomic, assign) CGFloat price;
@property (nonatomic, assign) NSInteger stock;//库存
@property (nonatomic, assign) NSInteger sales;//销量
@property (nonatomic, copy)   NSString *pic;
@property (nonatomic, copy)   NSString *addtime;//添加时间
@property (nonatomic, assign) NSInteger typeid;
@property (nonatomic, assign) NSInteger topicid;
@property (nonatomic, strong) NSArray *fileids;//FieldModel
@property (nonatomic, assign) BOOL isrecommand;
@end

@interface GoodOrderModel : NSObject

@property (nonatomic, assign)NSInteger id;
@property (nonatomic, strong)NSString *name;
@property (nonatomic, assign)CGFloat price;
@property (nonatomic, assign)NSInteger sales;//数量
@property (nonatomic, strong)NSString *color;//颜色
@property (nonatomic, assign)NSInteger num;//数量，num和sales到底用哪个？
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
