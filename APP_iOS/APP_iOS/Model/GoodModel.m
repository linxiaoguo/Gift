//
//  GoodModel.m
//  APP_iOS
//
//  Created by 林小果 on 15/10/28.
//  Copyright (c) 2015年 Li. All rights reserved.
//

#import "GoodModel.h"

@implementation GoodModel

- (void)setAddtime:(NSString *)addtime {
    _addtime = addtime;
    if (addtime.length > 10) {
        _addtime = [addtime substringToIndex:10];
    }
}

@end

@implementation GoodOrderModel

@end

@implementation GoodsListRequest

@end

@implementation GoodsListResponse

+ (NSDictionary *)objectClassInArray {
    return @{
             @"data" : @"GoodModel",
             };
}

@end