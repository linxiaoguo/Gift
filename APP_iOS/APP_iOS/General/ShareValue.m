//
//  AudioPlayerInstance.m
//  XMU1.0
//
//  Created by lihj on 14-5-6.
//  Copyright (c) 2014年 DongXM. All rights reserved.
//

#import "ShareValue.h"

@implementation ShareValue

+ (ShareValue *)instance
{
    static ShareValue *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once (&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

@end
