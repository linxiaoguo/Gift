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
@property (nonatomic, copy)   NSString *name;//商品名称
@property (nonatomic, copy) NSString *price;//价格
@property (nonatomic, assign) NSInteger stock;//库存
@property (nonatomic, assign) NSInteger sales;//销量
@property (nonatomic, copy)   NSString *pic;//图片地址
@property (nonatomic, copy)   NSString *addtime;//添加时间
@property (nonatomic, assign) NSInteger typeid;
@property (nonatomic, copy) NSString *typename;
@property (nonatomic, assign) NSInteger topicid;
@property (nonatomic, copy) NSString *topicname;
@property (nonatomic, strong) NSArray *fileids;//FieldModel
@property (nonatomic, assign) BOOL isrecommand;
@property (nonatomic, assign) BOOL recommend;//是否推荐
@property (nonatomic, assign) NSInteger goods_status;//商品状态，文档未提供说明
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
