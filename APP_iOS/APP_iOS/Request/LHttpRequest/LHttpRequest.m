//
//  LHttpRequest.m
//  baseProject
//
//  Created by Li on 15/4/7.
//  Copyright (c) 2015年 Li. All rights reserved.
//

#import "LHttpRequest.h"
#import "NSObject+HXAddtions.h"
#import "AFHTTPRequestOperationManager.h"
#import "LHttpConfig.h"
#import "DES3Util.h"
#import "NSDictionary+JSONString.h"

@implementation LHttpRequest

+ (void)getHttpRequest:(NSString *)path parameters:(NSDictionary *)parameters success:(void (^)(NSDictionary *responseDic))sucess failure:(void (^)(NSString *descript))failure {

    NSString *requestURL = [NSString stringWithFormat:@"%@%@", kServerUrl, path];
    DLog(@"请求网址：%@\n请求参数：\n%@", requestURL, parameters);
    
    NSString *jsonString = [parameters JSONStringPlain];
    NSString *encode = [DES3Util encrypt:jsonString];

    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setObject:encode forKey:@"req"];

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:requestURL parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSString *jsonString = [DES3Util decrypt:string];
        jsonString = [jsonString stringByReplacingOccurrencesOfString:@":null" withString:@":\"\""];

        NSError *error = nil;
        id jsonObject = [NSJSONSerialization JSONObjectWithData:[jsonString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:&error];
        if (jsonObject && !error) {
            NSDictionary *jsonDic = [NSDictionary dictionaryWithDictionary:jsonObject];
            DLog(@"requestSuccess:\n%@", jsonDic);
            sucess(jsonDic);
        }
        else {
            // 解析错误
            DLog(@"requestFailure:\n%@", error.domain);
            failure(error.domain);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLog(@"requestFailure:\n%@", error);
        failure(error.domain);
    }];
}

+ (void)postHttpRequest:(NSString *)path parameters:(NSDictionary *)parameters success:(void (^)(NSDictionary *responseDic))sucess failure:(void (^)(NSString *descript))failure {

    NSString *requestURL = [NSString stringWithFormat:@"%@%@", kServerUrl, path];    
    DLog(@"请求网址：%@\n请求参数：\n%@", requestURL, parameters);

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.requestSerializer.timeoutInterval = 15;	//超时
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObjectsFromArray:@[@"text/plain"]];

    [manager POST:requestURL parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSString *jsonString = [NSObject jsonStringWithObject:responseObject];
        jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
        jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
        NSError *error = nil;
        id jsonObject = [NSJSONSerialization JSONObjectWithData:[jsonString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:&error];
        if (jsonObject && !error) {
            NSDictionary *jsonDic;
            if ([jsonObject isKindOfClass:[NSArray class]]) {
                jsonDic = [NSDictionary dictionaryWithObject:jsonObject forKey:@"data"];
            } else if ([jsonObject isKindOfClass:[NSDictionary class]]) {
                jsonDic = [NSDictionary dictionaryWithDictionary:jsonObject];
            }
            DLog(@"requestSuccess:\n%@", jsonDic);
            sucess(jsonDic);
        }
        else {
            // 解析错误
            DLog(@"requestFailure:\n%@", error.domain);
            failure(error.domain);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLog(@"requestFailure:\n%@", error.userInfo[@"NSLocalizedDescription"]);
        failure(error.domain);
    }];
}

+ (void)postHttpRequest:(NSString *)path parameters:(NSDictionary *)parameters data:(NSData *)data name:(NSString *)name fileName:(NSString *)fileName mimeType:(NSString *)mimeType success:(void (^)(NSDictionary *responseDic))sucess failure:(void (^)(NSString *descript))failure {
    DLog(@"requestParemeters:\n%@", parameters);

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [manager POST:[NSString stringWithFormat:@"%@%@", kServerUrl, path] parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        [formData appendPartWithFileData:data name:name fileName:fileName mimeType:mimeType];
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSString *jsonString = [NSObject jsonStringWithObject:responseObject];
        NSError *error = nil;
        id jsonObject = [NSJSONSerialization JSONObjectWithData:[jsonString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:&error];
        if (jsonObject && !error) {
            NSDictionary *jsonDic = [NSDictionary dictionaryWithDictionary:jsonObject];
            if (![[jsonDic objectForKey:kSuccessKey] isEqualToString:kSuccessCode]) {
                DLog(@"requestFailure:\n%@", jsonDic);
                failure([jsonDic objectForKey:@"desc"]);
            }
            else {
                DLog(@"requestSuccess:\n%@", jsonDic);
                sucess(jsonDic);
            }
        }
        else {
            // 解析错误
            DLog(@"requestFailure:\n%@", error.domain);
            failure(error.domain);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        DLog(@"requestFailure:\n%@", error.domain);
        failure(error.domain);
        
    }];
}

@end
