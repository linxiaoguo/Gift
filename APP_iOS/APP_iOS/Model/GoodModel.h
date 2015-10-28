//
//  GoodModel.h
//  APP_iOS
//
//  Created by 林小果 on 15/10/28.
//  Copyright (c) 2015年 Li. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GoodModel : NSObject
@property (nonatomic, strong)NSString *id;
@property (nonatomic, strong)NSString *name;
@property (nonatomic, strong)NSString *price;
@property (nonatomic, strong)NSString *stock;//库存
@property (nonatomic, strong)NSString *sales;//销量
@property (nonatomic, strong)NSString *pic;
@property (nonatomic, strong)NSString *addtime;//添加时间
@end
