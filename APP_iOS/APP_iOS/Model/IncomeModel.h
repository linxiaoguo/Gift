//
//  IncomeModel.h
//  APP_iOS
//
//  Created by 林小果 on 15/11/8.
//  Copyright © 2015年 Li. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IncomeModel : NSObject
@property (nonatomic, assign)NSTimeInterval time;
@property (nonatomic, assign)CGFloat money;
@property (nonatomic, assign)NSInteger status;//状态，1:申请中，2:提现成功，3：提现失败
@end

@interface IncomeTotalModel : NSObject
@property (nonatomic, assign)CGFloat wait;
@property (nonatomic, assign)CGFloat already;
@property (nonatomic, assign)CGFloat doing;
@property (nonatomic, assign)CGFloat can;
@property (nonatomic, assign)CGFloat not;

@property (nonatomic, assign)NSInteger total;
@property (nonatomic, strong)NSArray *lists;//IncomeModel
@end
