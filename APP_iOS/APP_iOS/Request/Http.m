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
        [dic setObject:pic forKey:@"picid"];
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
    if(stat >= 0)
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

- (void)uploadFile:(NSString *)fileId uploadFile:(UIImage *)image mname:(NSString *)mname completion:(void(^)(NSError *error, FieldModel *fieldModel))completion {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if (fileId)
        [dic setValue:fileId forKey:@"fileId"];
    if (mname)
        [dic setValue:mname forKey:@"mname"];
    else
        [dic setValue:@"theme store" forKey:@"mname"];
    
    NSString *jsonString = [dic JSONStringPlain];
    NSString *encode = [DES3Util encrypt:jsonString];
    encode = [self encodeToPercentEscapeString:encode];
    NSString *urlString = [NSString stringWithFormat:@"http://121.40.131.81/shopping/mall/app/addFile.htm?req=%@", encode];

    //字典里面装的是你要上传的内容
//    NSDictionary *parameters = @{@"content": @"这是刚刚在线的官方网站www.superqq.com"};
    //分界线的标识符
    NSString *TWITTERFON_FORM_BOUNDARY = @"AaB03x";
    //根据url初始化request
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]
                                                            cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                                        timeoutInterval:10];
    //分界线 --AaB03x
    NSString *MPboundary = [[NSString alloc]initWithFormat:@"--%@",TWITTERFON_FORM_BOUNDARY];
    //结束符 AaB03x--
    NSString *endMPboundary = [[NSString alloc]initWithFormat:@"%@--",MPboundary];
    //	//要上传的图片
    //	UIImage *image = [params objectForKey:@"pic"];
    //得到图片的data
    NSData *data = UIImagePNGRepresentation(image);
    //http body的字符串
    NSMutableString *body = [[NSMutableString alloc] init];
    //参数的集合的所有key的集合
//    NSArray *keys = [parameters allKeys];
//    //遍历keys
//    for(int i=0; i<[keys count]; i++)
//    {
//        //得到当前key
//        NSString *key = [keys objectAtIndex:i];
//        //如果key不是pic，说明value是字符类型，比如name：Boris
//        if(![key isEqualToString:@"pic"])
//        {
//            //添加分界线，换行
//            [body appendFormat:@"%@\r\n",MPboundary];
//            //添加字段名称，换2行
//            [body appendFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n",key];
//            //添加字段的值
//            [body appendFormat:@"%@\r\n",[parameters objectForKey:key]];
//        }
//    }
    ////添加分界线，换行
    [body appendFormat:@"%@\r\n",MPboundary];
    //声明pic字段，文件名为boris.png
    [body appendFormat:@"Content-Disposition: form-data; name=\"uploadFile\"; filename=\"ios.png\"\r\n"];
    //声明上传文件的格式
    [body appendFormat:@"Content-Type: image/png\r\n\r\n"];
    //声明结束符：--AaB03x--
    NSString *end = [[NSString alloc]initWithFormat:@"\r\n%@",endMPboundary];
    //声明myRequestData，用来放入http body
    NSMutableData *myRequestData = [NSMutableData data];
    //将body字符串转化为UTF8格式的二进制
    [myRequestData appendData:[body dataUsingEncoding:NSUTF8StringEncoding]];
    //将image的data加入
    [myRequestData appendData:data];
    //加入结束符--AaB03x--
    [myRequestData appendData:[end dataUsingEncoding:NSUTF8StringEncoding]];
    //设置HTTPHeader中Content-Type的值
    NSString *content=[[NSString alloc]initWithFormat:@"multipart/form-data; boundary=%@",TWITTERFON_FORM_BOUNDARY];
    //设置HTTPHeader
    [request setValue:content forHTTPHeaderField:@"Content-Type"];
    //设置Content-Length
    [request setValue:[NSString stringWithFormat:@"%d", (int)[myRequestData length]] forHTTPHeaderField:@"Content-Length"];
    //设置http body
    [request setHTTPBody:myRequestData];
    //http method
    [request setHTTPMethod:@"POST"];
    //建立连接
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
        FieldModel *fieldModel = [FieldModel objectWithKeyValues:body];

        if (completion)
            completion(error, fieldModel);
    }];
 
//    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:urlString]];
//    [request setHTTPMethod:@"POST"];
//    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue currentQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
//        NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//        NSString *decode = [DES3Util decrypt:string];
//        NSLog(@"请求url：%@", urlString);
//        NSLog(@"返回数据：%@", decode);
//        NSDictionary *resDic = [decode objectFromJSONString];
//        NSString *message = [resDic objectForKey:@"message"];
//        NSString *success = [resDic objectForKey:@"success"];
//        if (message == nil)
//            message = @"";
//        if (success == nil)
//            success = @"1";
//
//        NSError *error = [NSError errorWithDomain:message code:success.integerValue userInfo:nil];
//        NSDictionary *body = [resDic objectForKey:@"data"];
//        FieldModel *fieldModel = [FieldModel objectWithKeyValues:body];
//
//        if (completion)
//            completion(error, fieldModel);
//    }];
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
        qrcodeImg = [qrcodeImg stringByReplacingOccurrencesOfString:@"\\" withString:@"/"];
        NSError *error = [NSError errorWithDomain:message code:success.integerValue userInfo:nil];
        if (completion)
            completion(error, goodsAddr, qrcodeImg);
    }];
}

- (void)shopQrcode:(NSInteger)shopid completion:(void(^)(NSError *error, NSString *shopAddr, NSString *qrcodeImg))completion {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:[NSNumber numberWithInteger:shopid] forKey:@"shopid"];
    
    NSString *jsonString = [dic JSONStringPlain];
    NSString *encode = [DES3Util encrypt:jsonString];
    encode = [self encodeToPercentEscapeString:encode];
    NSString *urlString = [NSString stringWithFormat:@"http://121.40.131.81/shopping/mall/app/shopQrcode.htm?req=%@", encode];
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
        NSString *shopAddr = [goodsDic objectForKey:@"shopAddr"];
        NSString *qrcodeImg = [goodsDic objectForKey:@"qrcodeImg"];
        NSError *error = [NSError errorWithDomain:message code:success.integerValue userInfo:nil];
        if (completion)
            completion(error, shopAddr, qrcodeImg);
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

- (void)orderDetail:(NSInteger)shopId orderId:(NSInteger)orderId completion:(void(^)(NSError *error, OrderDetailModel *order))completion {
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

        OrderDetailModel *order = [OrderDetailModel objectWithKeyValues:dic];
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
    NSString *urlString = [NSString stringWithFormat:@"http://121.40.131.81/shopping/mall/app/logisticsList.htm"];
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

- (void)income:(NSInteger)shopId completion:(void(^)(NSError *error, IncomeTotalModel2 *incomeTotal))completion {

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
        IncomeTotalModel2 *incomeTotal = [IncomeTotalModel2 objectWithKeyValues:dic];
        if (completion)
            completion(error, incomeTotal);
    }];
}

- (void)withdraw:(NSInteger)shopId money:(CGFloat)money completion:(void(^)(NSError *error))completion {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:[NSNumber numberWithInteger:shopId] forKey:@"shopid"];
    [dic setObject:[NSNumber numberWithFloat:money] forKey:@"outMoney"];
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
    [dic setObject:[NSNumber numberWithInteger:count] forKey:@"pageSize"];
    [dic setObject:[NSNumber numberWithInteger:page] forKey:@"page"];

    NSString *jsonString = [dic JSONStringPlain];
    NSString *encode = [DES3Util encrypt:jsonString];
    encode = [self encodeToPercentEscapeString:encode];
    NSString *urlString = [NSString stringWithFormat:@"http://121.40.131.81/shopping/mall/app/withdrawList.htm?req=%@", encode];
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
        NSArray *lists = [dic objectForKey:@"data"];
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
        NSArray *array = [[resDic objectForKey:@"data"] objectForKey:@"data"];
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
    NSString *boundle = @"com.haisi.gift";
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
