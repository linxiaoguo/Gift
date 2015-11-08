//
//  Http.m
//  APP_iOS
//
//  Created by 林小果 on 15/10/28.
//  Copyright (c) 2015年 Li. All rights reserved.
//

#import "Http.h"
#import "DES3Util.h"
#import "NSDictionary+JSONString.h"
#import "JSONKit.h"

@implementation Http

+ (Http *)instance {
    static Http *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once (&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
    }
    return self;
}

#pragma mark - 接口
- (void)login:(NSString *)userName pwd:(NSString *)pwd completion:(void(^)(NSError *error, UserModel *user))completion {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:userName forKey:@"username"];
    [dic setObject:pwd forKey:@"password"];
    [dic setObject:[NSNumber numberWithBool:YES] forKey:@"applogin"];
    NSString *jsonString = [dic JSONStringPlain];
    NSString *encode = [DES3Util encrypt:jsonString];
    NSString *urlString = [NSString stringWithFormat:@"http://121.40.131.81/shopping/mall/app/shopping_login.htm?req=%@", encode];
    urlString = [urlString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"GET"];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue currentQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSString *decode = [DES3Util decrypt:string];
        NSLog(@"请求url：%@", urlString);
        NSLog(@"返回数据：%@", decode);
        NSDictionary *resDic = [decode objectFromJSONString];
        NSString *message = [resDic objectForKey:@"message"];
        NSString *success = [resDic objectForKey:@"success"];
        if (message == nil)
            message = @"";
        NSError *error = [NSError errorWithDomain:message code:success.integerValue userInfo:nil];
        NSDictionary *body = [resDic objectForKey:@"data"];
        UserModel *user = [UserModel objectWithKeyValues:body];
        if (completion)
            completion(error, user);
    }];
}

- (void)main:(NSString *)shopId completion:(void(^)(NSError *error, MainModel *main))completion {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:shopId forKey:@"shopid"];
    [dic setObject:@"18" forKey:@"apilevel"];
    NSString *jsonString = [dic JSONStringPlain];
    NSString *encode = [DES3Util encrypt:jsonString];
    NSString *urlString = [NSString stringWithFormat:@"http://121.40.131.81/shopping/mall/app/main.htm?req=%@", encode];
    urlString = [urlString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"GET"];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue currentQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSString *decode = [DES3Util decrypt:string];
        NSLog(@"请求url：%@", urlString);
        NSLog(@"返回数据：%@", decode);
        NSDictionary *resDic = [decode objectFromJSONString];
        NSString *message = [resDic objectForKey:@"message"];
        NSString *success = [resDic objectForKey:@"success"];
        if (message == nil)
            message = @"";
        NSError *error = [NSError errorWithDomain:message code:success.integerValue userInfo:nil];
        NSDictionary *body = [resDic objectForKey:@"data"];
        MainModel *main = [MainModel objectWithKeyValues:body];
        if (completion)
            completion(error, main);
    }];
}

- (void)myShop:(NSString *)shopId completion:(void(^)(NSError *error, ShopModel *shop))completion {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:@"32769" forKey:@"shopid"];
    [dic setObject:@"18" forKey:@"apilevel"];
    NSString *jsonString = [dic JSONStringPlain];
    NSString *encode = [DES3Util encrypt:jsonString];
    NSString *urlString = [NSString stringWithFormat:@"http://121.40.131.81/shopping/mall/app/myshop.htm?req=%@", encode];
    urlString = [urlString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"GET"];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue currentQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSString *decode = [DES3Util decrypt:string];
        NSLog(@"请求url：%@", urlString);
        NSLog(@"返回数据：%@", decode);
        NSDictionary *resDic = [decode objectFromJSONString];
        NSString *message = [resDic objectForKey:@"message"];
        NSString *success = [resDic objectForKey:@"success"];
        if (message == nil)
            message = @"";
        NSError *error = [NSError errorWithDomain:message code:success.integerValue userInfo:nil];
        NSDictionary *body = [resDic objectForKey:@"data"];
        ShopModel *shop = [ShopModel objectWithKeyValues:body];
        if (completion)
            completion(error, shop);
    }];
}

- (void)modifyMyshop:(NSString *)shopId name:(NSString *)name pic:(NSString *)pic addr:(NSString *)addr linkman:(NSString *)linkman linkphone:(NSString *)linkphone completion:(void(^)(NSError *error))completion {

    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:shopId forKey:@"shopid"];
    if (name)
        [dic setObject:name forKey:@"name"];
    if (pic)
        [dic setObject:pic forKey:@"pic"];
    if (addr)
        [dic setObject:addr forKey:@"addr"];
    if (linkman)
        [dic setObject:linkman forKey:linkman];
    if (linkphone)
        [dic setObject:linkphone forKey:@"linkphone"];
    NSString *jsonString = [dic JSONStringPlain];
    NSString *encode = [DES3Util encrypt:jsonString];
    NSString *urlString = [NSString stringWithFormat:@"http://121.40.131.81/shopping/mall/app/modifyMyshop.htm?req=%@", encode];
    urlString = [urlString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"GET"];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue currentQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSString *decode = [DES3Util decrypt:string];
        NSLog(@"请求url：%@", urlString);
        NSLog(@"返回数据：%@", decode);
        NSDictionary *resDic = [decode objectFromJSONString];
        NSString *message = [resDic objectForKey:@"message"];
        NSString *success = [resDic objectForKey:@"success"];
        if (message == nil)
            message = @"";
        NSError *error = [NSError errorWithDomain:message code:success.integerValue userInfo:nil];
        if (completion)
            completion(error);
    }];
}

- (void)postpone:(NSString *)shopid month:(NSInteger)month completion:(void(^)(NSError *error))completion {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:shopid forKey:@"shopid"];
    [dic setObject:[NSNumber numberWithInteger:month] forKey:@"month"];
    NSString *jsonString = [dic JSONStringPlain];
    NSString *encode = [DES3Util encrypt:jsonString];
    NSString *urlString = [NSString stringWithFormat:@"http://121.40.131.81/shopping/mall/app/postpone.htm?req=%@", encode];
    urlString = [urlString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"GET"];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue currentQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSString *decode = [DES3Util decrypt:string];
        NSLog(@"请求url：%@", urlString);
        NSLog(@"返回数据：%@", decode);
        NSDictionary *resDic = [decode objectFromJSONString];
        NSString *message = [resDic objectForKey:@"message"];
        NSString *success = [resDic objectForKey:@"success"];
        if (message == nil)
            message = @"";
        NSError *error = [NSError errorWithDomain:message code:success.integerValue userInfo:nil];
        if (completion)
            completion(error);
    }];
}

- (void)modifyPwd:(NSString *)shopid oldpwd:(NSString *)oldpwd newpwd:(NSString *)newpwd completion:(void(^)(NSError *error))completion {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:shopid forKey:@"shopid"];
    [dic setObject:oldpwd forKey:@"oldpwd"];
    [dic setObject:newpwd forKey:@"newpwd"];
    NSString *jsonString = [dic JSONStringPlain];
    NSString *encode = [DES3Util encrypt:jsonString];
    NSString *urlString = [NSString stringWithFormat:@"http://121.40.131.81/shopping/mall/app/modifyPwd.htm?req=%@", encode];
    urlString = [urlString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"GET"];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue currentQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSString *decode = [DES3Util decrypt:string];
        NSLog(@"请求url：%@", urlString);
        NSLog(@"返回数据：%@", decode);
        NSDictionary *resDic = [decode objectFromJSONString];
        NSString *message = [resDic objectForKey:@"message"];
        NSString *success = [resDic objectForKey:@"success"];
        if (message == nil)
            message = @"";
        NSError *error = [NSError errorWithDomain:message code:success.integerValue userInfo:nil];
        if (completion)
            completion(error);
    }];
}

- (void)goodsList:(NSString *)shopid stat:(NSInteger)stat count:(NSInteger)count page:(NSInteger)page completion:(void(^)(NSError *error, NSArray *dataArray))completion {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:shopid forKey:@"shopid"];
    [dic setObject:[NSNumber numberWithInteger:stat] forKey:@"stat"];
    [dic setObject:[NSNumber numberWithInteger:count] forKey:@"count"];
    [dic setObject:[NSNumber numberWithInteger:page] forKey:@"page"];
    
    NSString *jsonString = [dic JSONStringPlain];
    NSString *encode = [DES3Util encrypt:jsonString];
    NSString *urlString = [NSString stringWithFormat:@"http://121.40.131.81/shopping/mall/app/goodsList.htm?req=%@", encode];
    urlString = [urlString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"GET"];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue currentQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSString *decode = [DES3Util decrypt:string];
        NSLog(@"请求url：%@", urlString);
        NSLog(@"返回数据：%@", decode);
        NSDictionary *resDic = [decode objectFromJSONString];
        NSString *message = [resDic objectForKey:@"message"];
        NSString *success = [resDic objectForKey:@"success"];
        if (message == nil)
            message = @"";
        NSError *error = [NSError errorWithDomain:message code:success.integerValue userInfo:nil];
        NSDictionary *body = [resDic objectForKey:@"data"];
        NSArray *goodsArray = [body objectForKey:@"data"];
        NSMutableArray *goods = [NSMutableArray array];
        for (NSInteger i=0; i<goodsArray.count; i++) {
            NSDictionary *goodDic = [goodsArray objectAtIndex:i];
            GoodModel *good = [GoodModel objectWithKeyValues:goodDic];
            [goods addObject:good];
        }
        if (completion)
            completion(error, goods);
    }];
}
@end
