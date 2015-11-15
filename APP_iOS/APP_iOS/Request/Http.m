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
- (void)login:(NSString *)userName pwd:(NSString *)pwd completion:(void(^)(NSError *error, ShopModel *user))completion {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:userName forKey:@"username"];
    [dic setObject:pwd forKey:@"password"];
    [dic setObject:[NSNumber numberWithBool:YES] forKey:@"applogin"];
    NSString *jsonString = [dic JSONStringPlain];
    NSString *encode = [DES3Util encrypt:jsonString];
    encode = [self encodeToPercentEscapeString:encode];
    NSString *urlString = [NSString stringWithFormat:@"http://121.40.131.81/shopping/shopping_login.htm?req=%@", encode];
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
        if (success == nil)
            success = @"1";
        NSError *error = [NSError errorWithDomain:message code:success.integerValue userInfo:nil];
        NSDictionary *body = [resDic objectForKey:@"data"];
        ShopModel *shop = [ShopModel objectWithKeyValues:body];
        FieldModel *field = [FieldModel objectWithKeyValues:[body objectForKey:@"pic"]];
        shop.pic = field;
        if (completion)
            completion(error, shop);
    }];
}

- (void)main:(NSInteger)shopId completion:(void(^)(NSError *error, MainModel *main))completion {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:[NSNumber numberWithInteger:shopId] forKey:@"shopid"];
    [dic setObject:@"18" forKey:@"apilevel"];
    NSString *jsonString = [dic JSONStringPlain];
    NSString *encode = [DES3Util encrypt:jsonString];
    encode = [self encodeToPercentEscapeString:encode];
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
        if (success == nil)
            success = @"1";
        NSError *error = [NSError errorWithDomain:message code:success.integerValue userInfo:nil];
        NSDictionary *body = [resDic objectForKey:@"data"];
        MainModel *main = [MainModel objectWithKeyValues:body];
        if (completion)
            completion(error, main);
    }];
}

- (void)myShop:(NSInteger)shopId completion:(void(^)(NSError *error, ShopModel *shop))completion {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:[NSNumber numberWithInteger:shopId] forKey:@"shopid"];
    [dic setObject:@"18" forKey:@"apilevel"];
    NSString *jsonString = [dic JSONStringPlain];
    NSString *encode = [DES3Util encrypt:jsonString];
    encode = [self encodeToPercentEscapeString:encode];
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
        if (success == nil)
            success = @"1";
        NSError *error = [NSError errorWithDomain:message code:success.integerValue userInfo:nil];
        NSDictionary *body = [resDic objectForKey:@"data"];
        ShopModel *shop = [ShopModel objectWithKeyValues:body];
        FieldModel *field = [FieldModel objectWithKeyValues:[body objectForKey:@"pic"]];
        shop.pic = field;
        if (completion)
            completion(error, shop);
    }];
}

- (void)modifyMyshop:(NSInteger)shopId name:(NSString *)name pic:(NSString *)pic addr:(NSString *)addr linkman:(NSString *)linkman linkphone:(NSString *)linkphone completion:(void(^)(NSError *error))completion {

    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:[NSNumber numberWithInteger:shopId] forKey:@"shopid"];
    if (name)
        [dic setObject:name forKey:@"name"];
    if (pic)
        [dic setObject:pic forKey:@"pic"];
    if (addr)
        [dic setObject:addr forKey:@"addr"];
    if (linkman)
        [dic setObject:linkman forKey:@"linkman"];
    if (linkphone)
        [dic setObject:linkphone forKey:@"linkphone"];
    NSString *jsonString = [dic JSONStringPlain];
    NSString *encode = [DES3Util encrypt:jsonString];
    encode = [self encodeToPercentEscapeString:encode];
    NSString *urlString = [NSString stringWithFormat:@"http://121.40.131.81/shopping/mall/app/modifyShop.htm?req=%@", encode];
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
        if (success == nil)
            success = @"1";
        NSError *error = [NSError errorWithDomain:message code:success.integerValue userInfo:nil];
        if (completion)
            completion(error);
    }];
}

- (void)postpone:(NSInteger)shopId month:(NSInteger)month completion:(void(^)(NSError *error))completion {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:[NSNumber numberWithInteger:shopId] forKey:@"shopid"];
    [dic setObject:[NSNumber numberWithInteger:month] forKey:@"month"];
    NSString *jsonString = [dic JSONStringPlain];
    NSString *encode = [DES3Util encrypt:jsonString];
    encode = [self encodeToPercentEscapeString:encode];
    NSString *urlString = [NSString stringWithFormat:@"http://121.40.131.81/shopping/mall/app/postpone.htm?req=%@", encode];
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
        if (success == nil)
            success = @"1";
        NSError *error = [NSError errorWithDomain:message code:success.integerValue userInfo:nil];
        if (completion)
            completion(error);
    }];
}

- (void)modifyPwd:(NSInteger)shopId oldpwd:(NSString *)oldpwd newpwd:(NSString *)newpwd completion:(void(^)(NSError *error))completion {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:[NSNumber numberWithInteger:shopId] forKey:@"shopid"];
    [dic setObject:oldpwd forKey:@"oldpwd"];
    [dic setObject:newpwd forKey:@"newpwd"];
    NSString *jsonString = [dic JSONStringPlain];
    NSString *encode = [DES3Util encrypt:jsonString];
    encode = [self encodeToPercentEscapeString:encode];
    NSString *urlString = [NSString stringWithFormat:@"http://121.40.131.81/shopping/mall/app/modifyPwd.htm?req=%@", encode];
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
        if (success == nil)
            success = @"1";
        NSError *error = [NSError errorWithDomain:message code:success.integerValue userInfo:nil];
        if (completion)
            completion(error);
    }];
}

- (void)goodsList:(NSInteger)shopId stat:(NSInteger)stat count:(NSInteger)count page:(NSInteger)page recommend:(BOOL)recommend completion:(void(^)(NSError *error, NSArray *dataArray))completion {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:[NSNumber numberWithInteger:shopId] forKey:@"shopid"];
    [dic setObject:[NSNumber numberWithInteger:stat] forKey:@"stat"];
    [dic setObject:[NSNumber numberWithInteger:count] forKey:@"count"];
    [dic setObject:[NSNumber numberWithInteger:page] forKey:@"page"];
    [dic setObject:[NSNumber numberWithBool:recommend] forKey:@"recommend"];
    
    NSString *jsonString = [dic JSONStringPlain];
    NSString *encode = [DES3Util encrypt:jsonString];
    encode = [self encodeToPercentEscapeString:encode];
    NSString *urlString = [NSString stringWithFormat:@"http://121.40.131.81/shopping/mall/app/goodsList.htm?req=%@", encode];
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
        if (success == nil)
            success = @"1";
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


- (void)goodsTypeList:(void(^)(NSError *error, NSArray *dataArray))completion {
    NSString *urlString = [NSString stringWithFormat:@"http://121.40.131.81/shopping/mall/app/goodsType.htm"];
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
        if (success == nil)
            success = @"1";
        NSError *error = [NSError errorWithDomain:message code:success.integerValue userInfo:nil];
        NSArray *goodTypeArray = [resDic objectForKey:@"data"];
        NSMutableArray *goods = [NSMutableArray array];
        for (NSInteger i=0; i<goodTypeArray.count; i++) {
            NSDictionary *goodDic = [goodTypeArray objectAtIndex:i];
            GoodTypeModel *good = [GoodTypeModel objectWithKeyValues:goodDic];
            [goods addObject:good];
        }
        if (completion)
            completion(error, goods);
    }];
}

- (void)goodsTopicList:(void(^)(NSError *error, NSArray *dataArray))completion {
    NSString *urlString = [NSString stringWithFormat:@"http://121.40.131.81/shopping/mall/app/goodsTopic.htm"];
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
        if (success == nil)
            success = @"1";
        NSError *error = [NSError errorWithDomain:message code:success.integerValue userInfo:nil];
        NSArray *goodTypeArray = [resDic objectForKey:@"data"];
        NSMutableArray *goods = [NSMutableArray array];
        for (NSInteger i=0; i<goodTypeArray.count; i++) {
            NSDictionary *goodDic = [goodTypeArray objectAtIndex:i];
            GoodsTopicModel *good = [GoodsTopicModel objectWithKeyValues:goodDic];
            [goods addObject:good];
        }
        if (completion)
            completion(error, goods);
    }];
}

- (void)uploadFile:(NSString *)fileId uploadFile:(NSString *)uploadFile mname:(NSString *)mname completion:(void(^)(NSError *error, NSArray *dataArray))completion {
    
}

- (void)addGoods:(NSInteger)shopId name:(NSString *)name typeId:(NSInteger)typeId topicId:(NSInteger)topicId isrecommand:(BOOL)isrecommand price:(CGFloat)price stock:(NSInteger)stock fileids:(NSArray *)fileids completion:(void(^)(NSError *error))completion {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:name forKey:@"name"];
    [dic setObject:[NSNumber numberWithInteger:shopId] forKey:@"shopid"];
    [dic setObject:[NSNumber numberWithInteger:typeId] forKey:@"typeid"];
    [dic setObject:[NSNumber numberWithInteger:topicId] forKey:@"topicid"];
    [dic setObject:[NSNumber numberWithBool:isrecommand] forKey:@"isrecommand"];
    [dic setObject:[NSNumber numberWithFloat:price] forKey:@"price"];
    [dic setObject:[NSNumber numberWithInteger:stock] forKey:@"stock"];
    if (fileids)
        [dic setObject:fileids forKey:@"fileids"];
    
    NSString *jsonString = [dic JSONStringPlain];
    NSString *encode = [DES3Util encrypt:jsonString];
    encode = [self encodeToPercentEscapeString:encode];
    NSString *urlString = [NSString stringWithFormat:@"http://121.40.131.81/shopping/mall/app/addGoods.htm?req=%@", encode];
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
        if (success == nil)
            success = @"1";
        NSError *error = [NSError errorWithDomain:message code:success.integerValue userInfo:nil];
        if (completion)
            completion(error);
    }];
}

- (void)goodsDetail:(NSInteger)shopId goodsId:(NSInteger)goodsId completion:(void(^)(NSError *error, GoodModel *goods))completion {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:[NSNumber numberWithInteger:shopId] forKey:@"shopid"];
    [dic setObject:[NSNumber numberWithInteger:goodsId] forKey:@"goodsid"];
    
    NSString *jsonString = [dic JSONStringPlain];
    NSString *encode = [DES3Util encrypt:jsonString];
    encode = [self encodeToPercentEscapeString:encode];
    NSString *urlString = [NSString stringWithFormat:@"http://121.40.131.81/shopping/mall/app/goodsDetail.htm?req=%@", encode];
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
        if (success == nil)
            success = @"1";
        NSError *error = [NSError errorWithDomain:message code:success.integerValue userInfo:nil];
        
        NSDictionary *goodsDic = [resDic objectForKey:@"data"];
        GoodModel *goods = [GoodModel objectWithKeyValues:goodsDic];

        if (completion)
            completion(error, goods);
    }];
}

- (void)goodsModify:(NSInteger)shopId goodsId:(NSInteger)goodsId name:(NSString *)name typeId:(NSInteger)typeId topicId:(NSInteger)topicId isrecommand:(BOOL)isrecommand price:(CGFloat)price stock:(NSInteger)stock fileids:(NSArray *)fileids completion:(void(^)(NSError *error))completion {

    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:name forKey:@"name"];
    [dic setObject:[NSNumber numberWithInteger:shopId] forKey:@"shopid"];
    [dic setObject:[NSNumber numberWithInteger:goodsId] forKey:@"goodsid"];
    [dic setObject:[NSNumber numberWithInteger:typeId] forKey:@"typeid"];
    [dic setObject:[NSNumber numberWithInteger:topicId] forKey:@"topicid"];
    [dic setObject:[NSNumber numberWithBool:isrecommand] forKey:@"isrecommand"];
    [dic setObject:[NSNumber numberWithFloat:price] forKey:@"price"];
    [dic setObject:[NSNumber numberWithInteger:stock] forKey:@"stock"];
    if (fileids)
        [dic setObject:fileids forKey:@"fileids"];
    
    NSString *jsonString = [dic JSONStringPlain];
    NSString *encode = [DES3Util encrypt:jsonString];
    encode = [self encodeToPercentEscapeString:encode];
    NSString *urlString = [NSString stringWithFormat:@"http://121.40.131.81/shopping/mall/app/modifyGoods.htm?req=%@", encode];
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
        if (success == nil)
            success = @"1";
        NSError *error = [NSError errorWithDomain:message code:success.integerValue userInfo:nil];
        if (completion)
            completion(error);
    }];
}

- (void)statusGoods:(NSInteger)status shopId:(NSInteger)shopId goodsId:(NSInteger)goodsId completion:(void(^)(NSError *error))completion {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:[NSNumber numberWithInteger:shopId] forKey:@"shopid"];
    [dic setObject:[NSNumber numberWithInteger:goodsId] forKey:@"goodsid"];
    [dic setObject:[NSNumber numberWithInteger:status] forKey:@"status"];

    NSString *jsonString = [dic JSONStringPlain];
    NSString *encode = [DES3Util encrypt:jsonString];
    encode = [self encodeToPercentEscapeString:encode];
    NSString *urlString = [NSString stringWithFormat:@"http://121.40.131.81/shopping/mall/app/statusGoods.htm?req=%@", encode];
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
        if (success == nil)
            success = @"1";
        NSError *error = [NSError errorWithDomain:message code:success.integerValue userInfo:nil];
        if (completion)
            completion(error);
    }];
}

- (void)recommendGoods:(BOOL)recommend shopId:(NSInteger)shopId goodsId:(NSInteger)goodsId completion:(void(^)(NSError *error))completion {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:[NSNumber numberWithInteger:shopId] forKey:@"shopid"];
    [dic setObject:[NSNumber numberWithInteger:goodsId] forKey:@"goodsid"];
    [dic setObject:[NSNumber numberWithBool:recommend] forKey:@"recommend"];
    
    NSString *jsonString = [dic JSONStringPlain];
    NSString *encode = [DES3Util encrypt:jsonString];
    encode = [self encodeToPercentEscapeString:encode];
    NSString *urlString = [NSString stringWithFormat:@"http://121.40.131.81/shopping/mall/app/recommendGoods.htm?req=%@", encode];
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
        if (success == nil)
            success = @"1";
        NSError *error = [NSError errorWithDomain:message code:success.integerValue userInfo:nil];
        if (completion)
            completion(error);
    }];
}

- (void)goodsQrcode:(NSInteger)goodsId completion:(void(^)(NSError *error, NSString *goodsAddr, NSString *qrcodeImg))completion {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:[NSNumber numberWithInteger:goodsId] forKey:@"goodsid"];
    
    NSString *jsonString = [dic JSONStringPlain];
    NSString *encode = [DES3Util encrypt:jsonString];
    encode = [self encodeToPercentEscapeString:encode];
    NSString *urlString = [NSString stringWithFormat:@"http://121.40.131.81/shopping/mall/app/goodsQrcode.htm?req=%@", encode];
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
        if (success == nil)
            success = @"1";
        
        NSDictionary *goodsDic = [resDic objectForKey:@"data"];
        NSString *goodsAddr = [goodsDic objectForKey:@"goodsAddr"];
        NSString *qrcodeImg = [goodsDic objectForKey:@"qrcodeImg"];
        NSError *error = [NSError errorWithDomain:message code:success.integerValue userInfo:nil];
        if (completion)
            completion(error, goodsAddr, qrcodeImg);
    }];
}

- (void)order:(NSInteger)shopId completion:(void(^)(NSError *error, OrderTotalModel *order))completion {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:[NSNumber numberWithInteger:shopId] forKey:@"shopid"];
    
    NSString *jsonString = [dic JSONStringPlain];
    NSString *encode = [DES3Util encrypt:jsonString];
    encode = [self encodeToPercentEscapeString:encode];
    NSString *urlString = [NSString stringWithFormat:@"http://121.40.131.81/shopping/mall/app/order.htm?req=%@", encode];
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
        if (success == nil)
            success = @"1";
        NSError *error = [NSError errorWithDomain:message code:success.integerValue userInfo:nil];
        NSDictionary *dic = [resDic objectForKey:@"data"];
        OrderTotalModel *order = [OrderTotalModel objectWithKeyValues:dic];
        if (completion)
            completion(error, order);
    }];
}

- (void)orderList:(NSInteger)shopId stat:(NSInteger)stat pageSize:(NSInteger)pageSize page:(NSInteger)page completion:(void(^)(NSError *error, NSArray *dataArray))completion {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:[NSNumber numberWithInteger:shopId] forKey:@"shopid"];
    [dic setObject:[NSNumber numberWithInteger:stat] forKey:@"stat"];
    [dic setObject:[NSNumber numberWithInteger:pageSize] forKey:@"pageSize"];
    [dic setObject:[NSNumber numberWithInteger:page] forKey:@"page"];
    
    NSString *jsonString = [dic JSONStringPlain];
    NSString *encode = [DES3Util encrypt:jsonString];
    encode = [self encodeToPercentEscapeString:encode];
    NSString *urlString = [NSString stringWithFormat:@"http://121.40.131.81/shopping/mall/app/orderList.htm?req=%@", encode];
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
        if (success == nil)
            success = @"1";
        NSError *error = [NSError errorWithDomain:message code:success.integerValue userInfo:nil];
        NSArray *ordersArray = [[resDic objectForKey:@"data"] objectForKey:@"data"];
        NSMutableArray *orders = [NSMutableArray array];
        for (NSInteger i=0; i<ordersArray.count; i++) {
            NSDictionary *orderDic = [ordersArray objectAtIndex:i];
            OrderModel *order = [OrderModel objectWithKeyValues:orderDic];
            
            NSArray *goodsArray = [orderDic objectForKey:@"goods"];
            NSMutableArray *goods = [NSMutableArray array];
            for (NSInteger j=0; j<goodsArray.count; j++) {
                NSDictionary *goodDic = [goodsArray objectAtIndex:j];
                GoodOrderModel *goodOder = [GoodOrderModel objectWithKeyValues:goodDic];
                [goods addObject:goodOder];
            }
            order.goods = goods;
            [orders addObject:order];
        }
        if (completion)
            completion(error, orders);
    }];
}

- (void)orderDetail:(NSInteger)shopId orderId:(NSInteger)orderId completion:(void(^)(NSError *error, OrderModel *order))completion {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:[NSNumber numberWithInteger:shopId] forKey:@"shopid"];
    [dic setObject:[NSNumber numberWithInteger:orderId] forKey:@"orderid"];
    
    NSString *jsonString = [dic JSONStringPlain];
    NSString *encode = [DES3Util encrypt:jsonString];
    encode = [self encodeToPercentEscapeString:encode];
    NSString *urlString = [NSString stringWithFormat:@"http://121.40.131.81/shopping/mall/app/orderDetail.htm?req=%@", encode];
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
        if (success == nil)
            success = @"1";
        NSError *error = [NSError errorWithDomain:message code:success.integerValue userInfo:nil];
        NSDictionary *dic = [resDic objectForKey:@"data"];

        OrderModel *order = [OrderModel objectWithKeyValues:dic];
        NSArray *goodsArray = [dic objectForKey:@"goods"];
        NSMutableArray *goods = [NSMutableArray array];
        for (NSInteger j=0; j<goodsArray.count; j++) {
            NSDictionary *goodDic = [goodsArray objectAtIndex:j];
            GoodOrderModel *goodOder = [GoodOrderModel objectWithKeyValues:goodDic];
            [goods addObject:goodOder];
        }
        order.goods = goods;

        if (completion)
            completion(error, order);
    }];
}

- (void)logisticsList:(void(^)(NSError *error, NSArray *dataArray))completion {
    NSString *urlString = [NSString stringWithFormat:@"http://121.40.131.81/shopping/mall/app/orderList.htm"];
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
        if (success == nil)
            success = @"1";
        NSError *error = [NSError errorWithDomain:message code:success.integerValue userInfo:nil];
        NSArray *ordersArray = [resDic objectForKey:@"data"];
        NSMutableArray *orders = [NSMutableArray array];
        for (NSInteger i=0; i<ordersArray.count; i++) {
            NSDictionary *orderDic = [ordersArray objectAtIndex:i];
            logisticsModel *order = [logisticsModel objectWithKeyValues:orderDic];
            [orders addObject:order];
        }
        if (completion)
            completion(error, orders);
    }];
}

- (void)ship:(NSInteger)orderId logId:(NSInteger)logId shipCode:(NSString *)shipCode desc:(NSString *)desc completion:(void(^)(NSError *error))completion {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:[NSNumber numberWithInteger:logId] forKey:@"logid"];
    [dic setObject:[NSNumber numberWithInteger:orderId] forKey:@"orderid"];
    [dic setObject:shipCode forKey:@"shipCode"];
    [dic setObject:desc forKey:@"desc"];
    
    NSString *jsonString = [dic JSONStringPlain];
    NSString *encode = [DES3Util encrypt:jsonString];
    encode = [self encodeToPercentEscapeString:encode];
    NSString *urlString = [NSString stringWithFormat:@"http://121.40.131.81/shopping/mall/app/ship.htm?req=%@", encode];
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
        if (success == nil)
            success = @"1";
        NSError *error = [NSError errorWithDomain:message code:success.integerValue userInfo:nil];

        if (completion)
            completion(error);
    }];
}

- (void)income:(NSInteger)shopId completion:(void(^)(NSError *error, IncomeTotalModel *incomeTotal))completion {

    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:[NSNumber numberWithInteger:shopId] forKey:@"shopid"];
    
    NSString *jsonString = [dic JSONStringPlain];
    NSString *encode = [DES3Util encrypt:jsonString];
    encode = [self encodeToPercentEscapeString:encode];
    NSString *urlString = [NSString stringWithFormat:@"http://121.40.131.81/shopping/mall/app/income.htm?req=%@", encode];
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
        if (success == nil)
            success = @"1";
        NSError *error = [NSError errorWithDomain:message code:success.integerValue userInfo:nil];
        NSDictionary *dic = [resDic objectForKey:@"data"];
        IncomeTotalModel *incomeTotal = [IncomeTotalModel objectWithKeyValues:dic];
        if (completion)
            completion(error, incomeTotal);
    }];
}

- (void)withdraw:(NSInteger)shopId money:(CGFloat)money completion:(void(^)(NSError *error))completion {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:[NSNumber numberWithInteger:shopId] forKey:@"shopid"];
    [dic setObject:[NSNumber numberWithFloat:money] forKey:@"money"];
    NSString *jsonString = [dic JSONStringPlain];
    NSString *encode = [DES3Util encrypt:jsonString];
    encode = [self encodeToPercentEscapeString:encode];
    NSString *urlString = [NSString stringWithFormat:@"http://121.40.131.81/shopping/mall/app/withdraw.htm?req=%@", encode];
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
        if (success == nil)
            success = @"1";
        NSError *error = [NSError errorWithDomain:message code:success.integerValue userInfo:nil];
        if (completion)
            completion(error);
    }];
}

- (void)withdrawList:(NSInteger)shopId count:(NSInteger)count page:(NSInteger)page completion:(void(^)(NSError *error, IncomeTotalModel *incomeTotal))completion {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:[NSNumber numberWithInteger:shopId] forKey:@"shopid"];
    [dic setObject:[NSNumber numberWithInteger:count] forKey:@"count"];
    [dic setObject:[NSNumber numberWithInteger:page] forKey:@"page"];

    NSString *jsonString = [dic JSONStringPlain];
    NSString *encode = [DES3Util encrypt:jsonString];
    encode = [self encodeToPercentEscapeString:encode];
    NSString *urlString = [NSString stringWithFormat:@"http://121.40.131.81/shopping/mall/app/withdraw.htm?req=%@", encode];
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
        if (success == nil)
            success = @"1";
        NSError *error = [NSError errorWithDomain:message code:success.integerValue userInfo:nil];
        
        NSDictionary *dic = [resDic objectForKey:@"data"];
        IncomeTotalModel *incomeTotal = [IncomeTotalModel objectWithKeyValues:dic];
        NSArray *lists = [dic objectForKey:@"lists"];
        NSMutableArray *drawList = [NSMutableArray array];
        for (NSInteger i=0; i<lists.count; i++) {
            NSDictionary *draw = [lists objectAtIndex:i];
            IncomeModel *model = [IncomeModel objectWithKeyValues:draw];
            [drawList addObject:model];
        }
        incomeTotal.lists = drawList;
        if (completion)
            completion(error, incomeTotal);
    }];
}

- (void)bankList:(void(^)(NSError *error, NSArray *dataArray))completion {
    NSString *urlString = [NSString stringWithFormat:@"http://121.40.131.81/shopping/mall/app/bankList.htm"];
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
        if (success == nil)
            success = @"1";
        NSError *error = [NSError errorWithDomain:message code:success.integerValue userInfo:nil];
        
        NSArray *array = [resDic objectForKey:@"data"];
        NSMutableArray *banks = [NSMutableArray array];
        for (NSInteger i=0; i<array.count; i++) {
            NSDictionary *dic = [array objectAtIndex:i];
            BankModel *model = [BankModel objectWithKeyValues:dic];
            [banks addObject:model];
        }
        if (completion)
            completion(error, banks);
    }];
}

- (void)bindBank:(NSInteger)shopId name:(NSString *)name idcard:(NSString *)idcard bank:(NSString *)bank card:(NSString *)card completion:(void(^)(NSError *error))completion {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:[NSNumber numberWithInteger:shopId] forKey:@"shopid"];
    [dic setObject:name forKey:@"name"];
    [dic setObject:idcard forKey:@"idcard"];
    [dic setObject:bank forKey:@"bank"];
    [dic setObject:card forKey:@"card"];
    NSString *jsonString = [dic JSONStringPlain];
    NSString *encode = [DES3Util encrypt:jsonString];
    encode = [self encodeToPercentEscapeString:encode];
    NSString *urlString = [NSString stringWithFormat:@"http://121.40.131.81/shopping/mall/app/bindbank.htm?req=%@", encode];
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
        if (success == nil)
            success = @"1";
        NSError *error = [NSError errorWithDomain:message code:success.integerValue userInfo:nil];
        if (completion)
            completion(error);
    }];
}

- (void)messageList:(NSInteger)shopId count:(NSInteger)count page:(NSInteger)page completion:(void(^)(NSError *error, NSArray *dataArray))completion {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:[NSNumber numberWithInteger:shopId] forKey:@"shopid"];
    [dic setObject:[NSNumber numberWithInteger:count] forKey:@"count"];
    [dic setObject:[NSNumber numberWithInteger:page] forKey:@"page"];
    NSString *jsonString = [dic JSONStringPlain];
    NSString *encode = [DES3Util encrypt:jsonString];
    encode = [self encodeToPercentEscapeString:encode];
    NSString *urlString = [NSString stringWithFormat:@"http://121.40.131.81/shopping/mall/app/messageList.htm?req=%@", encode];
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
        if (success == nil)
            success = @"1";
        NSError *error = [NSError errorWithDomain:message code:success.integerValue userInfo:nil];
        NSArray *array = [resDic objectForKey:@"data"];
        NSMutableArray *messages = [NSMutableArray array];
        for (NSInteger i=0; i<array.count; i++) {
            NSDictionary *dic = [array objectAtIndex:i];
            MessageModel *msg = [MessageModel objectWithKeyValues:dic];
            [messages addObject:msg];
        }
        if (completion)
            completion(error, messages);
    }];
}

- (void)queryVersion:(NSInteger)version completion:(void(^)(NSError *error, VersionModel *version))completion {

    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:[NSNumber numberWithInteger:version] forKey:@"version"];
    NSString *boundle = @"com.haisi.liwu";
    [dic setObject:boundle forKey:@"pagename"];
    [dic setObject:[NSNumber numberWithInteger:2] forKey:@"type"];
    NSString *jsonString = [dic JSONStringPlain];
    NSString *encode = [DES3Util encrypt:jsonString];
    encode = [self encodeToPercentEscapeString:encode];
    NSString *urlString = [NSString stringWithFormat:@"http://121.40.131.81/shopping/mall/app/upgrade.htm?req=%@", encode];
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
        if (success == nil)
            success = @"1";
        NSError *error = [NSError errorWithDomain:message code:success.integerValue userInfo:nil];
        NSDictionary *dic = [resDic objectForKey:@"data"];
        VersionModel *ver = [VersionModel objectWithKeyValues:dic];

        if (completion)
            completion(error, ver);
    }];
}

////
- (NSString *)encodeToPercentEscapeString: (NSString *) input {
    NSString*
    outputStr = (__bridge NSString *)CFURLCreateStringByAddingPercentEscapes(NULL,(__bridge CFStringRef)input, NULL,                                                                         (CFStringRef)@"!*'();:@&=+$,/?%#[]", kCFStringEncodingUTF8);
    
    
    return outputStr;
}

- (NSString *)decodeFromPercentEscapeString: (NSString *) input {
    NSMutableString *outputStr = [NSMutableString stringWithString:input];
    [outputStr replaceOccurrencesOfString:@"+"
                               withString:@""
                                  options:NSLiteralSearch
                                    range:NSMakeRange(0,
                                                      [outputStr length])];
    
    return [outputStr stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}
@end
