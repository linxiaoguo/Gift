//
//  BaseModel.h
//  APP_iOS
//
//  Created by Li on 15/8/26.
//  Copyright (c) 2015年 Li. All rights reserved.
//

#import "BaseHttpRequest.h"
#import "BaseHttpResponse.h"

/**
 *  主页
 */

@interface ClassModel : NSObject

@property (nonatomic, copy) NSString *class_id;
@property (nonatomic, copy) NSString *class_name;
@property (nonatomic, copy) NSString *first_Pay;
@property (nonatomic, copy) NSString *note;
@property (nonatomic, copy) NSString *photo;
@property (nonatomic, copy) NSString *all_cost;
@property (nonatomic, copy) NSString *discount;

@end

@interface GetClassRequest : BaseHttpRequest

@end

@interface GetClassResponse : BaseHttpResponse

@property (nonatomic, copy) NSArray *classes;

@end

/**
 *  意见反馈
 */

@interface FeedBackRequest : BaseHttpRequest

@property (nonatomic, copy) NSString *userid;
@property (nonatomic, copy) NSString *opinion;

@end

@interface FeedBackResponse : BaseHttpResponse

@end

/**
 *  获取最新版本
 */

@interface VersionModel : NSObject

@property (nonatomic, copy) NSString *file;
@property (nonatomic, copy) NSString *info;
@property (nonatomic, copy) NSString *update_time;
@property (nonatomic, copy) NSString *version_no;

@end

@interface GetVersionRequest : BaseHttpRequest

@property (nonatomic, copy) NSString *type;         /**< 0-安卓 1-iOS */

@end

@interface GetVersionResponse : BaseHttpResponse

@property (nonatomic, strong) VersionModel *version;

@end

/**
 *  申请理赔
 */

@interface ApplyPaymentRequest : BaseHttpRequest

@property (nonatomic, copy) NSString *userid;
@property (nonatomic, copy) NSString *subject;
@property (nonatomic, copy) NSString *realname;
@property (nonatomic, copy) NSString *sex;
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *payment;
@property (nonatomic, copy) NSString *idcard;

@end

@interface ApplyPaymentResponse : BaseHttpResponse

@end
