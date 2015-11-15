//
//  ShopModel.m
//  APP_iOS
//
//  Created by 林小果 on 15/10/28.
//  Copyright (c) 2015年 Li. All rights reserved.
//

#import "ShopModel.h"

@implementation ShopModel

- (void)setValidate:(NSString *)validate {
    _validate = validate;
    if (validate.length > 10) {
        _validate = [validate substringToIndex:10];
    }
}

- (void)setRegdate:(NSString *)regdate {
    _regdate = regdate;
    if (regdate.length > 10) {
        _regdate = [regdate substringToIndex:10];
    }
}

@end
