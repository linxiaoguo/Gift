//
//  BaseHttpRequest.m
//  APP_iOS
//
//  Created by Li on 15/8/12.
//  Copyright (c) 2015年 Li. All rights reserved.
//

#import "BaseHttpRequest.h"
#import "SvUDIDTools.h"

@implementation BaseHttpRequest

- (id)init {
    self = [super init];
    if (self) {
        _deviceId = [SvUDIDTools UDID];
    }
    return self;
}


@end

@implementation BasePageHttpRequest

- (id)init {
    self = [super init];
    if (self) {
        _offset = @"1";
        _max = @"20";
    }
    return self;
}


@end
