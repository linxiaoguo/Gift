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
 *  获取最新版本
 */

@interface VersionModel : NSObject

@property (nonatomic, copy) NSString *pagename;
@property (nonatomic, copy) NSString *version;
@property (nonatomic, copy) NSString *downurl;
@property (nonatomic, copy) NSString *size;
@property (nonatomic, copy) NSString *litpic;
@property (nonatomic, copy) NSString *info;
@property (nonatomic, copy) NSString *versionname;
@property (nonatomic, copy) NSString *status;

@end

@interface GetVersionRequest : BaseHttpRequest

@property (nonatomic, copy) NSString *type;         /**< 0-安卓 1-iOS */
@property (nonatomic, copy) NSString *pagename;     /**< 包名 */
@property (nonatomic, copy) NSString *version;      /**< 版本号 */

@end

@interface GetVersionResponse : BaseHttpResponse

@property (nonatomic, strong) VersionModel *data;

@end

/**
 *  系统公告
 */

@interface NoticeModel : NSObject

@property (nonatomic, copy) NSString *msgid;
@property (nonatomic, copy) NSString *msgtitle;
@property (nonatomic, copy) NSString *msgtime;

@end

@interface NoticeRequest : BasePageHttpRequest

@property (nonatomic, copy) NSString *shopid;

@end

@interface NoticeResponse : BaseHttpResponse

@property (nonatomic, strong) NoticeModel *data;

@end
