//
//  IncomeModel.m
//  APP_iOS
//
//  Created by 林小果 on 15/11/8.
//  Copyright © 2015年 Li. All rights reserved.
//

#import "IncomeModel.h"

@implementation IncomeModel
- (NSString *)statusString {
    if (self.status == 1) {
        return @"申请中";
    } else if (self.status == 2) {
        return @"提现成功";
    } else if (self.status == 3) {
        return @"提现失败";
    }
    
    return @"";
}
@end

@implementation IncomeTotalModel

@end

@implementation IncomeTotalModel2

@end