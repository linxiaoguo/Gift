//
//  OrderTotalModel.h
//  APP_iOS
//
//  Created by 林小果 on 15/11/8.
//  Copyright © 2015年 Li. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderTotalModel : NSObject
@property (nonatomic, assign)NSInteger waitshipnum;//待发货总数
@property (nonatomic, assign)NSInteger shipnum;//已发货总数
@property (nonatomic, assign)NSInteger waitpaynum;//待付款总数
@property (nonatomic, assign)NSInteger finishnum;//已完成总数
@end
