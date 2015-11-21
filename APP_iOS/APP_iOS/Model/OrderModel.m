//
//  OrderModel.m
//  APP_iOS
//
//  Created by 林小果 on 15/11/8.
//  Copyright © 2015年 Li. All rights reserved.
//

#import "OrderModel.h"

@implementation OrderModel

- (NSString *)statString {
    if (self.stat == 10) {
        return @"待付款";
    } else if (self.stat == 20) {
        return @"待发货";
    } else if (self.stat == 40) {
        return @"已发货";
    } else if (self.stat == 20) {
        return @"已完成";
    }
    return @"";
}
@end

@implementation OrderDetailModel

@end
