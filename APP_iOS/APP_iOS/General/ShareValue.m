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

- (void)setLoginName:(NSString *)loginName {
    [[NSUserDefaults standardUserDefaults] setValue:loginName forKey:@"loginName"];
}

- (NSString *)loginName {
    return [[NSUserDefaults standardUserDefaults] valueForKey:@"loginName"];
}

- (void)setLoginPwd:(NSString *)loginPwd {
    [[NSUserDefaults standardUserDefaults] setValue:loginPwd forKey:@"loginPwd"];
}

- (NSString *)loginPwd {
    return [[NSUserDefaults standardUserDefaults] valueForKey:@"loginPwd"];
}

- (void)setShopModel:(ShopModel *)shopModel {
    if (shopModel) {
        NSDictionary *dic = shopModel.keyValues;
        NSData *userData = [NSKeyedArchiver archivedDataWithRootObject:dic];
        [[NSUserDefaults standardUserDefaults] setValue:userData forKey:@"userModelUD"];
    }
    else {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"userModelUD"];
    }
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (ShopModel *)shopModel {
    NSData *mcUserData = [[NSUserDefaults standardUserDefaults] valueForKey:@"userModelUD"];
    if (mcUserData) {
        NSDictionary *mcUserDic = [NSKeyedUnarchiver unarchiveObjectWithData:mcUserData];
        return [ShopModel objectWithKeyValues:mcUserDic];
    }
    else {
        return nil;
    }
}

@end
