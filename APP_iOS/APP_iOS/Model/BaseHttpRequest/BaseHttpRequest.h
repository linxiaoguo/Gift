//
//  BaseHttpRequest.h
//  APP_iOS
//
//  Created by Li on 15/8/12.
//  Copyright (c) 2015年 Li. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  BaseHttpRequest：公共参数
 */
@interface BaseHttpRequest : NSObject

@property (nonatomic, copy) NSString *deviceId;

@end

/**
 *  BasePageHttpRequest：分页参数
 */
@interface BasePageHttpRequest : BaseHttpRequest

@property (nonatomic, copy) NSString *offset;   /**< 分页开始位置（偏移量）*/
@property (nonatomic, copy) NSString *max;      /**< 每页请求的条数*/

@end
