//
//  BaseHttpResponse.h
//  APP_iOS
//
//  Created by Li on 15/8/12.
//  Copyright (c) 2015年 Li. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  BaseHttpResponse：返回公共参数
 */
@interface BaseHttpResponse : NSObject

@property (nonatomic, copy) NSString *code;
@property (nonatomic, copy) NSString *desc;

@end

/**
 *  PagingModel：返回分页参数
 */
@interface BasePageModel : NSObject

@property (nonatomic, copy) NSString *offset;           //分页开始位置（偏移量）
@property (nonatomic, copy) NSString *max;              //每页记录数
@property (nonatomic, copy) NSString *timeline;         //时间线
@property (nonatomic, copy) NSString *lastPage;         //1-最后一页 0-还有

@end

@interface BasePageHttpResponse : BaseHttpResponse

@property (nonatomic, strong) BasePageModel *pageModel;

@end
