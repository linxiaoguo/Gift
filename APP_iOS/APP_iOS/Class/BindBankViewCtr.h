//
//  BindBankViewCtr.h
//  APP_iOS
//
//  Created by 林小果 on 15/10/4.
//  Copyright (c) 2015年 Li. All rights reserved.
//

#import "BaseViewController.h"

@interface BindBankModel : NSObject
@property (nonatomic, strong)NSString *name;
@property (nonatomic, strong)NSString *identify;//身份证
@property (nonatomic, strong)NSString *bankName;
@property (nonatomic, strong)NSString *bandNo;
@end

@interface BindBankViewCtr : BaseViewController

@end
